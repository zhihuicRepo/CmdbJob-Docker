#!/usr/bin/python
#-*- encoding:utf-8 -*-
# Write by weiye in 201710 

import os
import sys
import time
import commands
import datetime

#------------------------
# 参数
#------------------------

# 指定拉取dac那个服务的日志或者tsp,task,service全部拉取，默认是全部拉取(dac)。
# default_service_name: [dac|tsp|task|service]
default_service_name = "dac"

# 过去几天的日志,默认过去1天的日志(即今天)
default_last_days = 1

#------------------------
# 常量
#------------------------

# dac服务所在主机IP列表
dac_server = ["10.19.64.1","10.19.64.2"]


def get_date_flag(last_days):
    date_flag = []
    for i in range(last_days):
        DayAgo = (datetime.datetime.now() - datetime.timedelta(days = i))
        StyleTime = DayAgo.strftime("%Y-%m-%d")        
        date_flag.append(StyleTime)
    return date_flag 


def get_tsp_logs(server_ip,last_days,archive_dir):
    server_flag = server_ip.replace(".","")
    ports = ["10004","10006"]
    date_flag = get_date_flag(last_days)
    logs_dir = []
    logs_flag = []
    for port in ports:
        dir = "/opt/logs/"+"QUARK_PROD_DAC_TSP_%s_%s"%(server_flag,port)
        logs_dir.append(dir)
        logs_flag.append(dir + "/" + "dac_tsp.log")
    
    for date in date_flag:
        for dir in logs_dir:
            path = dir + "/" + "dac_tsp." + date + "*"
            logs_flag.append(path)
    
    archive_path = archive_dir + "/" + "dac_tsp.tar.gz"

    os.system("tar zcPf %s %s"%(archive_path," ".join(logs_flag)))


def get_task_logs(server_ip,last_days,archive_dir):
    server_flag = server_ip.replace(".","")
    ports = ["10005"]
    date_flag = get_date_flag(last_days)
    logs_dir = []
    logs_flag = []
    for port in ports:
        dir = "/opt/logs/"+"QUARK_PROD_PBOC_TASK_%s_%s"%(server_flag,port)
        logs_dir.append(dir)
        logs_flag.append(dir + "/" + "pboc_task.log")
    
    for date in date_flag:
        for dir in logs_dir:
            path = dir + "/" + "pboc_task." + date + "*"
            logs_flag.append(path)
    
    archive_path = archive_dir + "/" + "pboc_task.tar.gz"

    os.system("tar zcPf %s %s"%(archive_path," ".join(logs_flag)))


def get_service_logs(server_ip,last_days,archive_dir):
    server_flag = server_ip.replace(".","")
    ports = ["10160","10161","10163"]
    date_flag = get_date_flag(last_days)
    logs_dir = []
    logs_flag = []
    for port in ports:
        dir = "/opt/logs/"+"QUARK_PROD_PBOC_SERVICE_%s_%s"%(server_flag,port)
        logs_dir.append(dir)
        logs_flag.append(dir + "/" + "pboc_service.log")
    
    for date in date_flag:
        for dir in logs_dir:
            path = dir + "/" + "pboc_service." + date + "*"
            logs_flag.append(path)
    
    archive_path = archive_dir + "/" + "pboc_service.tar.gz"

    os.system("tar zcPf %s %s"%(archive_path," ".join(logs_flag)))


class get_logs(object):
    def __init__(self,service,local,last_days,archive_dir_path):
        self.local = local
        self.last_days = last_days
        self.archive_dir_path = archive_dir_path
        fun_obj = getattr(self,service)
        fun_obj()

    def tsp(self):
        get_tsp_logs(self.local,self.last_days,self.archive_dir_path)

    def task(self):
        get_task_logs(self.local,self.last_days,self.archive_dir_path)

    def service(self):
        get_service_logs(self.local,self.last_days,self.archive_dir_path)
        
    def dac(self):
        self.tsp()
        self.task()
        self.service()
        
if __name__ == "__main__":
    #get_tsp_logs("10.19.64.1",2,"/tmp/archive_test_1")
    local = ""
    local_ip = commands.getoutput('hostname -I').strip(" ").split(" ")
    for ip in dac_server:
        if ip in local_ip:
            local = ip
            break
    if local:
        archive_name = "dac_%s_%s"%(local.replace(".",""),int(time.time()))
        archive_tar_name = archive_name + ".tar.gz"
        archive_dir = "/tmp"
        archive_dir_path = archive_dir + "/" + archive_name
        archive_tar_path = archive_dir + "/" + archive_tar_name
        os.system("mkdir -p %s"%archive_dir_path)
        try:
            service_name = sys.argv[1]
        except Exception:
            service_name = default_service_name
        else:
            if service_name not in ["dac","tsp","task","service"]:
                service_name = default_service_name
        try:
            last_days = int(sys.argv[2])
        except Exception:
            last_days = default_last_days
        else:
            if last_days < 0 or last_days > 7:
                last_days = default_last_days
        get_logs(service_name,local,last_days,archive_dir_path)
        os.system("cd %s && tar cf %s %s"%(archive_dir,archive_tar_name,archive_name))
        print("Log package file in %s"%archive_tar_path)
    else:
        print("The server does not have any dac service!")