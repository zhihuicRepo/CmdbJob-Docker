# -*- encoding:utf-8 -*-
#--------------------------------
# @Date    : 2017-05-10 18:21
# @Author  : wye
# @Version : v1.0
# @Desrc   : blue king cmdb api interface
# -------------------------------- 

import requests

bking_cmdb_server = "cmdb.qk.com"
bking_cmdb_port = 80



def get_app_info():

    resp = requests.post('http://%s:%s/api/App/getapplist'%(bking_cmdb_server,bking_cmdb_port))
    if resp.json()["code"] == 0:
        return resp.json()["data"]
    else:
        return []



def get_set_info(appid):
            
    resp = requests.post('http://%s:%s/api/TopSetModule/getappsetmoduletreebyappid'%(bking_cmdb_server,bking_cmdb_port),data={
         "ApplicationID":appid,
        })
    if resp.json()["code"] == 0:
        return resp.json()["data"]['Children']
    else:
        return []



def get_module_info(setid):
    set_map_appid = None
    resp_app_list = requests.post('http://%s:%s/api/App/getapplist'%(bking_cmdb_server,bking_cmdb_port))
    if resp_app_list.json()["code"] == 0:
        appid_list = [ item['ApplicationID'] for item in resp_app_list.json()['data'] ]
        for appid in appid_list:
            resp_set_list = requests.post('http://%s:%s/api/Host/getsethostlist'%(bking_cmdb_server,bking_cmdb_port),data={'ApplicationID':appid,'SetID':setid})
            if len(resp_set_list.json()['data']) != 0:
                set_map_appid = appid
                break
        resp_app_set_module_list = requests.post('http://%s:%s/api/TopSetModule/getappsetmoduletreebyappid'%(bking_cmdb_server,bking_cmdb_port),data={'ApplicationID':set_map_appid})
        
        for item in resp_app_set_module_list.json()['data']['Children']:
            if item['SetID'] == setid:
                return  item['Children']
    else:
        return []



def get_hosts_info_by_module(app_id,set_id,module_id):
    resp_hosts_list = requests.post('http://%s:%s/api/Host/getmodulehostlist'%(bking_cmdb_server,bking_cmdb_port),data={
        "ApplicationID":app_id,
        "ModuleID":module_id
        })
    if resp_hosts_list.json()['code'] == 0:
        return resp_hosts_list.json()['data']
    else:
        return []


if __name__ == "__main__":

    print get_app_info()
    #print get_set_info(6,6)
    #print get_module_info()
    #print get_module_info(10)
    #print len(get_hosts_info_by_module(2,3,33))
