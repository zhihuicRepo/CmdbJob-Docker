# -*- encoding:utf-8 -*-
#--------------------------------
# @Date    : 2017-05-10 15:00
# @Author  : wye
# @Version : v1.0
# @Desrc   : job control app views
# -------------------------------- 

from django.shortcuts import render
from django.http import HttpResponse,JsonResponse,HttpResponseRedirect
from django.contrib.auth import authenticate,login,logout
from django.core.urlresolvers import reverse
from django.contrib.auth.decorators import login_required
from django.views.decorators.csrf import csrf_exempt
from django.core.paginator import Paginator,EmptyPage,PageNotAnInteger

from jobapp.models import DynamicGroup , SaltGroup , action_audit , ExecUser , CustomScript

import os
import sys
import time
import json
import MySQLdb
from salt_api_sdk import *
from bk_cmdb_api import *

reload(sys)
sys.setdefaultencoding('utf-8')

# -----------------------------------------
# MYSQL SERVER INFO
# -----------------------------------------
MysqlServer = "mysql"
MysqlUser = "root"
MysqlPasswd = "openet12"
MysqlDB = "salt_job_sys"
# -----------------------------------------


def execute_sql(sql):
    try:
        DBConn = MySQLdb.connect(host=MysqlServer,user=MysqlUser,passwd=MysqlPasswd)
        DBCursor = DBConn.cursor()
        DBConn.select_db(MysqlDB)
        RecordNums = DBCursor.execute(sql)
        if RecordNums == 0 or RecordNums == None:
            RecordNums = 0
            RecordSets = ()
        else:
           RecordSets = DBCursor.fetchall()
           DBConn.commit()
        return RecordNums , RecordSets
    except Exception,e:
        print (" Execute sql error,error is %s"%e)
    finally:
        DBConn.close()
        DBCursor.close()



def get_recent_failure_tasks_info(num=10):

    sql = 'select fun,jid,id,alter_time from salt_returns  \n \
           where fun <> "runner.jobs.active"  \n \
           and fun <> "saltutil.running"  \n \
           and success=0 order by jid desc limit 0,%s'%num

    recent_failure_tasks_nums,recent_failure_tasks_records_tuple =  execute_sql(sql)
    return recent_failure_tasks_records_tuple



def get_recent_failure_tasks_nums():

    sql = 'select count(*) from salt_returns  \n \
           where fun <> "runner.jobs.active"  \n \
           and fun <> "saltutil.running"  \n \
           and success=0'

    _ , Records_tuple = execute_sql(sql)
    recent_failure_tasks_nums = Records_tuple[0][0]
    return recent_failure_tasks_nums



def get_recent_succss_tasks_info(num=10):
    sql = 'select fun,jid,id,alter_time from salt_returns where success=1 and fun="%s" or fun="%s" or fun="%s" order by jid desc limit 0,%s'%("cmd.run","state.sls","cp.get_file",num)
    recent_success_tasks_nums,recent_success_tasks_records_tuple =  execute_sql(sql)
    # recent_success_tasks_records = {}
    # if recent_success_tasks_nums != 0:    
    #     for i in range(recent_success_tasks_nums):
    #         recent_success_tasks_records[i+1] = recent_success_tasks_records_tuple[i]

    # return recent_success_tasks_records
    return recent_success_tasks_records_tuple



def get_recent_success_tasks_nums():
    sql = "select count(*) from salt_returns where success=1"
    _ , Records_tuple = execute_sql(sql)
    recent_success_tasks_nums = Records_tuple[0][0]
    return recent_success_tasks_nums



def get_recent_all_jobs_nums():
    sql = "select count(*) from jids"
    _ , Records_tuple = execute_sql(sql)
    recent_all_jobs_nums = Records_tuple[0][0]
    return recent_all_jobs_nums



def get_job_host_task_status(host,jid):
    sql = "select full_ret from salt_returns where jid='%s' and id='%s'"%(jid,host)
    Records_num, Records_tuple = execute_sql(sql)
    if Records_num == 0 or Records_num == None:
        status = None
    else:
        status = json.loads(Records_tuple[0][0])['retcode']

    return status



def get_upload_job_host_task_status(host,jid):
    sql = "select full_ret from salt_returns where jid='%s' and id='%s'"%(jid,host)
    Records_num, Records_tuple = execute_sql(sql)
    if Records_num == 0 or Records_num == None:
        status = None
    else:
        status = json.loads(Records_tuple[0][0])['return']

    return status



def get_script_job_host_task_status(host,jid):
    sql = "select full_ret from salt_returns where jid='%s' and id='%s'"%(jid,host)
    Records_num, Records_tuple = execute_sql(sql)
    if Records_num == 0 or Records_num == None:
        status = None
    else:
        status = json.loads(Records_tuple[0][0])['return']

    return status



def job_host_task_info(host,jid):
    sql = "select full_ret from salt_returns where jid='%s' and id='%s'"%(jid,host)
    _, Records_tuple = execute_sql(sql)
    return json.loads(Records_tuple[0][0])


def write_audit_info(jid,user):
    audit_info_obj = action_audit(jid=jid,user=user)
    audit_info_obj.save()



def get_jid_info(jid):
    sql = "select * from jids where jid='%s'"%jid
    Records_num, Records_tuple = execute_sql(sql)
    if Records_num != 0 and Records_num != None:
        return Records_tuple
    else:
        return None


@login_required
def index(request):    
    resp_info = {}
    #resp_info['recent_all_jobs_nums'] = get_recent_all_jobs_nums()
    #resp_info['recent_success_tasks_nums'] = get_recent_success_tasks_nums()
    #resp_info['recent_failure_tasks_nums'] = get_recent_failure_tasks_nums()
    resp_info['recent_failure_tasks_info'] = get_recent_failure_tasks_info(10)
    resp_info['recent_succss_tasks_info'] = get_recent_succss_tasks_info(10)
    #resp_info['running_jobs_nums'],resp_info['running_jobs_info'] = get_running_jobs_info()
    resp_info['last_days'] = get_keep_jobs_time()

    return render(request,'jobapp/index.html',resp_info)


@login_required
def get_appinfo_from_bking(request):
    appinfo = get_app_info()
    return JsonResponse(appinfo,safe=False)


@login_required
def get_setinfo_from_bking(request):
    app_field_name = request.GET['filter[filters][0][field]']
    app_id = request.GET['filter[filters][0][value]']
    setinfo = get_set_info(app_id)
    return JsonResponse(setinfo,safe=False)



@login_required
def get_moduleinfo_from_bking(request):
    set_name = request.GET['filter[filters][0][field]']
    set_id = request.GET['filter[filters][0][value]']
    moduleinfo = get_module_info(set_id)
    return JsonResponse(moduleinfo,safe=False)


@login_required
def target_hosts_info(request):
    target_hosts_info = {}
    appid = request.GET['app'].split("_")[0]
    appname = request.GET['app'].split("_")[1]

    setid = request.GET['set'].split("_")[0]
    setname = request.GET['set'].split("_")[1]

    moduleid = request.GET['module'].split("_")[0]
    modulename = request.GET['module'].split("_")[1]
    
    target_hosts_info["appname"] = appname
    target_hosts_info["setname"] = setname
    target_hosts_info["modulename"] = modulename

    hosts_list = get_hosts_info_by_module(appid,setid,moduleid)

    # -------------
    hostnames_list = []
    for host1 in hosts_list:
        hostnames_list.append(host1['HostName'])

    hosts_status = get_hosts_status(hostnames_list)
    # -------------

    for host in hosts_list:
        host['status'] = hosts_status.get(host['HostName'])
        if host.get('status'):
            host_meta_info = get_host_meta_info(host['HostName'])
            host['osname_salt'] = host_meta_info['os'] + " " + host_meta_info['osrelease']
            host['ip_salt'] = '|'.join(host_meta_info['ipv4'])
        else:
            pass

    target_hosts_info['hosts'] = hosts_list
    target_hosts_info['GroupName'] = "%s/%s/%s"%(appname,setname,modulename)
    target_hosts_info['datasource'] = "Cmdb"

    return render(request,"jobapp/salt_group_hosts_info.html",target_hosts_info)


def hostname_base_bking_module(request):

    appid = request.GET['appid']
    setid = request.GET['setid']
    moduleid = request.GET['moduleid']
    hosts_list = get_hosts_info_by_module(appid,setid,moduleid)

    hostname_list = []

    for host in hosts_list:
        hostname_list.append(host['HostName'])

    #hostname_list = [{"hostname":"wer","hostid":"234"}]

    return JsonResponse(hostname_list,safe=False)



@login_required
def get_host_detail_info(request):
    hostname = request.GET['hostname']
    host_meta_info = get_host_meta_info(hostname)
    host_meta_info['osname_salt'] = host_meta_info['os'] + " " + host_meta_info['osrelease']
    host_meta_info['ip_salt'] = '|'.join(host_meta_info['ipv4'])

    return render(request,'jobapp/host_detail.html',{"host_detail_info":host_meta_info})




def auth_login(request):
    context = {}
    if request.method == "POST":
        username = request.POST.get('username')
        password = request.POST.get('password')
        user = authenticate(username=username,password=password)
        if user:
            if user.is_active:
                login(request,user)
                return HttpResponseRedirect(reverse('jobapp:index'))
            else:
                context['error_info'] = "%s ACCOUNT IS DISABLED!"%username
        else:
            context['error_info'] = "INVALID ACCOUNT!"
    

    return render(request,'jobapp/login.html',context)

def auth_login_new(request):
    import redis,re
    try:
        ci_session = request.COOKIES['ci_session']
        find_key = 'ci_session:' +ci_session
    except:
        return HttpResponse("Login has expired,please login again")
    if find_key:
        redis_conn = redis.Redis(host='redis',port=6379,decode_responses=True)
        res = redis_conn.get(find_key)
        if res and res.find('username|s:') != -1 and res.find('chinese_name|s:') != -1:
            username = re.split(r'(?:";chinese_name)',res)[0].split('"')[-1]
            password = 'my password'
            conn1 = MySQLdb.connect(host='mysql',user='root',passwd='openet12',db='cmdb_job_sys',port=3306)
            cursor1 = conn1.cursor()
            sql1 = "select is_active from auth_user where username='%s'"%username
            cursor1.execute(sql1)
            res1 = cursor1.fetchone()
            cursor1.close()
            conn1.close() 
            is_active = res1[0]
            setFlag = True if is_active==1 else False
            user = authenticate(username=username,password=password,MyFlag=setFlag)
            if user:
                if user.is_active:
                    login(request,user)
                    return HttpResponseRedirect(reverse('jobapp:index'))
            return HttpResponse("please login first %s")
        else:
            return HttpResponseRedirect(reverse('jobapp:login'))


@login_required
def auth_logout(request):
    logout(request)
    return HttpResponseRedirect(reverse('jobapp:login'))




@login_required
def get_failure_task_detail_info(request):
    context = {}
    jid = request.GET['jid']
    hostname = request.GET['hostname']
    sql = 'select full_ret from salt_returns where jid="%s" and id="%s"'%(jid,hostname)
    failure_task_num,failure_task_record_tuple =  execute_sql(sql)
    if failure_task_num != 0:
        failure_task_record = json.loads(failure_task_record_tuple[0][0])
        context['failure_task_record'] = failure_task_record  

    return render(request,'jobapp/failure_task_detail.html',context)




@login_required
def state_sls_job_execute(request):
    user = request.user
    target_hosts = request.POST['show_target_hosts']
    action = request.POST['state_sls_select']
    is_test = request.POST.get('state_sls_is_test')
    
    target_hosts_list = target_hosts.split(",")
    target_hosts_num = len(target_hosts_list)

    jid = state_sls_execute(target_hosts_list,action,is_test)

    write_audit_info(jid,user)

    return render(request,'jobapp/exec_result_show.html',{"target_hosts_list":target_hosts_list,"target_hosts_num":target_hosts_num,"jid":jid,"is_test":is_test})




@login_required
@csrf_exempt
def get_job_hosts_task_status(request):
    hosts = request.POST['hosts']
    jid = request.POST['jid']
    
    host_list = hosts.split(",")
    hosts_status = []

    for host in host_list:
        
        status = get_job_host_task_status(host,jid)

        if status != None:
            host_status = {'host':host,'status':status}
            hosts_status.append(host_status)

    #hosts_status = [{'host':'w26','status':1},{'host':'456','status':0}]

    return JsonResponse(hosts_status,safe=False)
 



@login_required
@csrf_exempt
def get_upload_job_hosts_task_status(request):
    hosts = request.POST['hosts']
    jid = request.POST['jid']
    
    host_list = hosts.split(",")
    hosts_status = []

    for host in host_list:
        
        status = get_upload_job_host_task_status(host,jid)

        if status != None:
            if status != "" and status != "false":
                status = 0
            host_status = {'host':host,'status':status}
            hosts_status.append(host_status)
    
    return JsonResponse(hosts_status,safe=False)    


@login_required
@csrf_exempt
def get_script_job_hosts_task_status(request):
    hosts = request.POST['hosts']
    jid = request.POST['jid']
    
    host_list = hosts.split(",")
    hosts_status = []

    for host in host_list:
        
        status = get_script_job_host_task_status(host,jid)

        if status != None:
            if isinstance(status,dict):
                pid = status["pid"]
                retcode = status["retcode"]
                stderr = status["stderr"]
                stdout = status["stdout"]
            else:
                pid = ""
                retcode = 1
                stderr = status
                stdout = ""
            host_status = {'host':host,'pid':pid,'retcode':retcode,'stderr':stderr,'stdout':stdout}
            hosts_status.append(host_status)
    
    return JsonResponse(hosts_status,safe=False)    


@login_required
@csrf_exempt
def get_upload_file_progress(request):
    user = request.user
    user_dir = "/srv/salt/upload_files/%s/"%user

    hosts = request.POST['hosts']
    jid = request.POST['jid']
    source_file_name = request.POST["source_file_name"]
    dest_file_path = request.POST["dest_file_path"]
 
    source_file_path = os.path.join(user_dir,source_file_name)
    source_file_size = os.path.getsize(source_file_path)

    host_list = hosts.split(",")
    hosts_prog = []

    for host in host_list:
        try:
            size = get_file_stats(host,dest_file_path)[host]["size"]
        except KeyError:
            size = 0
        prog = "%.0f"%(float(size)/float(source_file_size)*100)
        host_prog = {'host':host,'prog':prog}
        hosts_prog.append(host_prog)

    return JsonResponse(hosts_prog,safe=False)



@login_required
@csrf_exempt
def get_job_host_task_info(request):
    host = request.POST['host']
    jid = request.POST['jid']
    info = job_host_task_info(host,jid)
    return JsonResponse([{"info":info}],safe=False)



@login_required
def dynamic_group_manage(request):
    group_name = request.GET.get("group_name")
    group_members = request.GET.get("group_members")

    #print "info is %s - %s"%(group_name,group_members)

    group_members_list = group_members.split(",")
    group_members_list = list(set(group_members_list))
    group_members = ",".join(group_members_list)
    
    retinfo = {}

    try:
        group_obj = DynamicGroup.objects.get(GroupName=group_name)
        group_obj.GroupMembers = group_members
        group_obj.save()
        retinfo["operate"] = "update group %s"%group_name
    except DynamicGroup.DoesNotExist:
        group_obj = DynamicGroup(GroupName=group_name,GroupMembers=group_members)
        group_obj.save()
        retinfo["operate"] = "create group %s"%group_name
   
    return JsonResponse(retinfo,safe=False)




@login_required
def dynamic_group_records(request):
    groups_obj = DynamicGroup.objects.order_by('id')
    groups_list = []
    for group_obj in groups_obj:
        group = {"id":group_obj.id,"GroupName":group_obj.GroupName,"GroupMembers":group_obj.GroupMembers}
        groups_list.append(group)
    return JsonResponse(groups_list,safe=False)




@login_required
def dynamic_group_record_by_id(request):
    id = request.GET.get("id")
    group_obj = DynamicGroup.objects.get(id=id)
    GroupMembers_Str = group_obj.GroupMembers
    GroupMembers_List = GroupMembers_Str.split(",")
    hostname_list = []
    for hostname in GroupMembers_List:
        hostname_list.append({"hostname":hostname,"hostid":"9999"})

    group = {"id":group_obj.id,"GroupName":group_obj.GroupName,"GroupMembers":hostname_list}
    return JsonResponse(group,safe=False)



@login_required
def dynamic_group_del_record_by_id(request):
    id = request.GET.get("id")
    DynamicGroup.objects.filter(id=id).delete()
    return JsonResponse({},safe=False)



@login_required
def dynamic_group_hosts_info(request):
    GroupName = request.GET.get("GroupName")
    GroupID = request.GET.get("GroupID")

    group_obj = DynamicGroup.objects.get(id=GroupID)
    GroupMembers_Str = group_obj.GroupMembers
    GroupMembers_List = GroupMembers_Str.split(",")

    hosts_list = []
    
    for hostname in GroupMembers_List:
        host = {}
        host["HostName"] = hostname
        host['status'] = get_host_status(host['HostName'])
        if host['status']:
            host_meta_info = get_host_meta_info(host['HostName'])
            host['osname_salt'] = host_meta_info['os'] + " " + host_meta_info['osrelease']
            host['ip_salt'] = '|'.join(host_meta_info['ipv4'])
        else:
            pass
        hosts_list.append(host)

    return render(request,"jobapp/salt_group_hosts_info.html",{"hosts":hosts_list,"GroupName":GroupName,"datasource":"DynamicGroup"})




@login_required
def salt_group_manage(request):
    group_name = request.GET.get("group_name")
    group_expr = request.GET.get("group_expr")
    
    retinfo = {}

    try:
        group_obj = SaltGroup.objects.get(GroupName=group_name)
        group_obj.GroupExpr = group_expr
        group_obj.save()
        retinfo["operate"] = "update group %s"%group_name
    except SaltGroup.DoesNotExist:
        group_obj = SaltGroup(GroupName=group_name,GroupExpr=group_expr)
        group_obj.save()
        retinfo["operate"] = "create group %s"%group_name

    return JsonResponse(retinfo,safe=False)





@login_required
def salt_group_all(request):
    groups_obj = SaltGroup.objects.order_by('id')
    groups_list = []
    for group_obj in groups_obj:
        group = {"id":group_obj.id,"GroupName":group_obj.GroupName,"GroupExpr":group_obj.GroupExpr}
        groups_list.append(group)
    return JsonResponse(groups_list,safe=False)
 


@login_required
def salt_group_record_by_id(request):
    group_id = request.GET.get("group_id")
    group_obj = SaltGroup.objects.get(id=group_id)
    group = {"group_id":group_obj.id,"GroupName":group_obj.GroupName,"GroupExpr":group_obj.GroupExpr}
    return JsonResponse(group,safe=False)




@login_required
def salt_group_del_record_by_id(request):
    group_id = request.GET.get("group_id")
    SaltGroup.objects.filter(id=group_id).delete()
    return JsonResponse({},safe=False)




@login_required
def salt_group_hosts_info(request):
    group_id = request.GET.get('GroupID')
    group_name = request.GET.get('GroupName')
    
    group_obj = SaltGroup.objects.get(id=group_id)
    group_expr = group_obj.GroupExpr
    
    resp = get_salt_group_hosts(group_expr)
    resp = {key:value for key,value in resp.iteritems() if value}

    hosts_list = []

    #print("resp is %s"%resp)

    for hostname , host_obj in resp.iteritems():
        if host_obj:
            host = {}
            host["HostName"] = hostname
            host["status"] = 1
            host['osname_salt'] = host_obj['os'] + " " + host_obj['osrelease']
            host['ip_salt'] = '|'.join(host_obj['ipv4'])
            hosts_list.append(host)
        else:
            host = {}
            host["HostName"] = hostname
            host["status"] = 0
            hosts_list.append(host)

    return render(request,"jobapp/salt_group_hosts_info.html",{"hosts":hosts_list,"GroupName":group_name,"datasource":"SaltGroup"})



@login_required
def cmd_run_job_execute(request):
    user = request.user
    target_hosts = request.POST['show_target_hosts']
    cmd = request.POST['cmd_run_str']
    exec_user = request.POST['cmd_run_exec_user']
    cmd = cmd.replace("\r\n"," ")
    
    is_test = None

    target_hosts_list = target_hosts.split(",")
    target_hosts_num = len(target_hosts_list)

    if is_test == None:
        # Real execute job
        jid = cmd_run_job_execute_real(target_hosts_list,cmd,exec_user)
    else:
        # test execute job
        jid = cmd_run_job_execute_test(target_hosts_list,cmd)

    write_audit_info(jid,user)

    return render(request,'jobapp/cmdrun_exec_result_show.html',{"target_hosts":target_hosts,"target_hosts_num":target_hosts_num,"jid":jid,"is_test":is_test})




@login_required
def upload_file_job_execute(request):
    user = request.user
    user_dir = "/srv/salt/upload_files/%s/"%user

    source_file_name = request.POST.get("source_file")
    target_hosts = request.POST.get("show_target_hosts")
    dest_dir = request.POST.get("dest_dir")


    target_hosts_list = target_hosts.split(",")
    target_hosts_num = len(target_hosts_list)
    source_file_path = os.path.join(user_dir,source_file_name)
    dest_file_path = dest_dir + os.sep + source_file_name
    
    source_file_size = os.path.getsize(source_file_path)/1024/1024

    jid = upload_file(target_hosts_list,user,source_file_name,dest_file_path)

    write_audit_info(jid,user)
    
    return render(request,'jobapp/upload_exec_result_show.html',{"target_hosts_list":target_hosts_list,"target_hosts_num":target_hosts_num,"jid":jid,"source_file_name":source_file_name,"dest_file_path":dest_file_path,"source_file_size":source_file_size})




@login_required
@csrf_exempt
def upload(request):
    user = request.user
    user_dir = "/srv/salt/upload_files/%s/"%user
    if not os.path.isdir(user_dir):os.makedirs(user_dir)
    if request.method == "POST":    
        myFile =request.FILES.get("files", None)    
        if not myFile:  
            return HttpResponse("no files for upload!")  
        destination = open(os.path.join(user_dir,myFile.name),'wb+')    
        for chunk in myFile.chunks():      
            destination.write(chunk)  
        destination.close()  
        return HttpResponse("")  




@login_required
def user_dir_files_list(request):
    user = request.user
    user_dir = "/srv/salt/upload_files/%s/"%user
    if not os.path.isdir(user_dir):
        os.makedirs(user_dir)
    filename_list = os.listdir(user_dir)
    files_list = []
    files_list.append({"FileName":"Please Select File..."})
    for filename in filename_list:
        file = {"FileName":filename}
        files_list.append(file)
    return JsonResponse(files_list,safe=False)




@login_required
def audit(request):
    actions_obj = action_audit.objects.order_by("-id")[:50]
    action_info_list = []
    for  action_obj in actions_obj:
        jid = action_obj.jid
        user = action_obj.user
        jid_info = get_jid_info(jid)
        if jid_info:
            action_detail_info = json.loads(jid_info[0][1])
            tgt = action_detail_info['tgt']
            fun = action_detail_info['fun']
            arg = action_detail_info['arg']

            action_info = {"jid":jid,"user":user,"tgt":tgt,"fun":fun,"arg":arg}
            action_info_list.append(action_info)
        else:
            continue

    last_days = get_keep_jobs_time()
    return render(request,'jobapp/audit.html',{"action_info_list":action_info_list,"last_days":last_days})           



@login_required
def help(request):
    return render(request,'jobapp/help.html',{})


@login_required
def del_file(request):
    user = request.user
    user_dir = "/srv/salt/upload_files/%s/"%user
    file_name = request.GET.get("file_name")
    file_path = os.path.join(user_dir,file_name)
    os.remove(file_path)
    return JsonResponse({'info':'info'},safe=False)


@login_required
def shortcut_search_host(request):
    keyWord = request.GET.get("search_key_word")
    
    group_expr = []
    # if keyWord is ip
    group_expr.append("S@"+keyWord)
    # if keyWord is hostname
    group_expr.append("G@nodename:"+keyWord)

    for tgt_type in group_expr:
        resp = get_salt_group_hosts(tgt_type)
        resp = {key:value for key,value in resp.iteritems() if value}
        if resp:
            break
        else:
            continue

    hosts_list = []

    for hostname , host_obj in resp.iteritems():
        host = {}
        host["HostName"] = hostname
        host["status"] = 1
        host['osname_salt'] = host_obj['os'] + " " + host_obj['osrelease']
        host['ip_salt'] = '|'.join(host_obj['ipv4'])
        hosts_list.append(host)

    return render(request,"jobapp/salt_group_hosts_info.html",{"hosts":hosts_list,"GroupName":keyWord,"datasource":"Host"})


@login_required
def execuser_name_list(request):
    user = request.user
    username_list = []
    username_list.append({"UserName":"root"})
    username_list.append({"UserName":"%s"%user})

    other_users_obj = ExecUser.objects.order_by("id")
    for user_obj in other_users_obj:
        username_list.append({"UserName":"%s"%user_obj.user,"UserID":user_obj.id})

    return JsonResponse(username_list,safe=False)


@login_required
def get_custom_script_list(request,page):
    num_pageper = 12
    #script_list = CustomScript.objects.all()
    script_list = CustomScript.objects.order_by("-id")
    paginator = Paginator(script_list,num_pageper)

    try:
        scripts = paginator.page(page)
    except PageNotAnInteger:
        scripts = paginator.page(1)
    except EmptyPage:
        scripts = paginator.page(paginator.num_pages)

    
    return render(request,'jobapp/custom_script_show.html',{'scripts':scripts})


@login_required
def get_system_user_list(request,page):
    num_pageper = 10
    user_list = ExecUser.objects.order_by("-id")
    paginator = Paginator(user_list,num_pageper)

    try:
        users = paginator.page(page)
    except PageNotAnInteger:
        users = paginator.page(1)
    except EmptyPage:
        users = paginator.page(paginator.num_pages)

    return render(request,'jobapp/system_user_manage.html',{'users':users})


@login_required
def create_custom_script(request):
    return  render(request,'jobapp/create_custom_script.html',{})


@login_required
def get_script_args(request):
    id = request.GET.get("id")
    script_obj = CustomScript.objects.get(id=id)
    script_args = script_obj.script_args
    return JsonResponse({'script_args':script_args},safe=False)


@login_required
def edit_custom_script(request,id):
    script_obj = CustomScript.objects.get(id=id)
    script_name = script_obj.script_name
    script_type = script_obj.script_type
    script_code = script_obj.script_code
    script_args = script_obj.script_args

    return  render(request,'jobapp/create_custom_script.html',{'script_name':script_name,'script_type':script_type,'script_code':script_code,'script_args':script_args,'script_id':id})


@login_required
def save_custom_script(request):

    script_name = request.POST.get("script_name")
    script_type = request.POST.get("script_type")
    script_code = request.POST.get("editor")
    script_args = request.POST.get("script_args").strip()

    if request.POST.get("script_id"):
        id = request.POST.get("script_id")
        script_obj = CustomScript.objects.get(id=id)
        script_obj.script_code = script_code
        script_obj.script_args = script_args
        script_obj.script_type = script_type
        script_obj.editor = "%s"%request.user
        script_obj.save()
    else:
        author = request.user
        editor = author

        custom_script_obj = CustomScript(script_name=script_name,author=author,editor=editor,script_code=script_code,script_args=script_args,script_type=script_type)
        custom_script_obj.save()
    
    #return get_custom_script_list(request,1)
    return HttpResponseRedirect("/jobapp/show/customscript/1/")


@login_required
def custom_scripts_all(request):
    scripts_obj = CustomScript.objects.order_by("-id")
    script_list = []
    for script_obj in scripts_obj:
        script = {'id':script_obj.id,'script_name':script_obj.script_name}
        script_list.append(script)
        
    return JsonResponse(script_list,safe=False)
 

@login_required
def cmd_script_job_execute(request):
    target_hosts = request.POST.get("show_target_hosts")
    script_exec_user = request.POST.get("cmd_script_exec_user")
    script_style = request.POST.get("script_style")
    target_hosts_list = target_hosts.split(",")
    target_hosts_num = len(target_hosts_list)

    script_dir = "/srv/salt/scripts"

    # common script
    if script_style == "common_script":
        script_id = request.POST.get("cmd_script_name")
        script_args = request.POST.get("cmd_script_args")
        script_obj = CustomScript.objects.get(id=script_id)
        script_code = script_obj.script_code
        script_type = script_obj.script_type
        script_local_name = "%s_%s_%s"%(request.user,int(time.time()),script_id) + ".%s"%(script_type[0:2])
        
    # temporary script
    if script_style == "tmp_script":
        script_args = ""
        script_code = request.POST.get("editor")
        script_local_name = "%s_%s"%(request.user,int(time.time())) + ".tmp"

        
    script_local_path = script_dir + os.sep + script_local_name

    with open(script_local_path,'w') as file_obj:
        file_obj.write(script_code)

    os.system("sed -i 's/\r$//' %s"%script_local_path)
    
    jid = cmd_script_job_execute_real(target_hosts_list,script_local_name,script_args,script_exec_user)

    write_audit_info(jid,request.user)

    return render(request,'jobapp/cmd_script_result_show.html',{"target_hosts_list":target_hosts_list,"target_hosts_num":target_hosts_num,"jid":jid})


@login_required
def system_user_save(request):

    data = request.GET.get("models")
    data_dict = json.loads(data)
    UserName = data_dict[0]["UserName"]
    user_obj = ExecUser(user=UserName)
    user_obj.save() 

    return JsonResponse({"UserName":user_obj.user,"UserID":user_obj.id})
 

@login_required
def system_user_del(request):
    id = request.GET.get("id")
    ExecUser.objects.filter(id=id).delete()
    return JsonResponse({},safe=False)


@login_required
def del_custom_script(request):
    id = request.GET.get("id")
    CustomScript.objects.filter(id=id).delete()
    return JsonResponse({},safe=False)


# ----------------------
# FOR DEBUG
# ----------------------

if __name__ == "__main__":
    # print get_recent_failure_tasks_info(10)
    # print get_recent_succss_tasks_info(10)
    # print get_recent_all_jobs_nums()
    # print get_recent_failure_tasks_nums()
    # print get_recent_success_tasks_nums()
    #get_failure_task_detail_info_test("20170518140245899698","W612-JENKDOCK-3")
    #print get_job_host_task_status("W612-JENKDOCK-4","20170523140452702260")
    #print json.loads(get_jid_info("20170608112713263763")[0][1])['arg']
    #get_script_job_host_task_status("node101","20171007001810839593")["stdout"]
    pass



