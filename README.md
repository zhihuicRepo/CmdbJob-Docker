A、开发原理介绍：   
这是一个简单的cmdb、job项目，涉及到以下组件：  
1、job:利用salt、Django 进行开发，job依赖salt-minion指向job对应的ip即可；  
2、cmdb 基于blueking cmdb进行简单开发；  
3、mysql 提供基础数据服务（初始脚本放置于mysql/init）；  
4、ldap 用于账户认证(初始数据可放置于ldap目录)；  
5、nginx用于文件服务器、服务转发和负载均衡；  
6、redis用于提供单点登录，session保存；  
7、安装这个服务需要具备docker-compose和docker环境，具体不在详细描述；  
```bash
.
├── job
│   └── django_cmdb_project
│       ├── django_cmdb_project
│       ├── jobapp
│       │   └── migrations
│       ├── static
│       │   ├── codemirror-5.14.2
│       │   │   ├── addon
│       └── templates
│           └── jobapp
├── ldap提供认证服务（初始化ldif可放于此处）
├── mysql
│   └── init（初始化sql可放置这里）
├── nginx
│   ├── conf.d（ng配置文件目录）
│   ├── ssl（加密证书服务）
│   └── www （ng的前端网页挂载路径）
│       ├── bk-cmdb-master cmdb源文件
│       │   ├── application
│       │   │   ├── cache
│       │   │   ├── config
│       │   │   │   ├── development
│       │   │   │   ├── production
│       │   │   │   └── testing
│       │   │   ├── controllers
│       │   │   │   ├── api
│       │   │   │   └── cli
│       │   │   ├── core
│       │   │   ├── hooks
│       │   │   ├── language
│       │   │   │   └── english
│       │   │   ├── libraries
│       ├── download 执行脚本和简单的文件服务放于这里
│       └── static提供job的静态文件
├── php和cmdb相关phpfpm模块初始化参数
└── redis提供cmdb和job之间的单点登录
```
B、使用介绍  
1.请自行配置本机host或者dns指定至对应主机  
2.cmdb: cmdb.qk.com opadmin blueking  
3.cmdb中填入主机，并在主机上执行curl -s http://job.qk.com/download/salt_install.sh|sudo bash  
4.job: job.qk.com   opadmin blueking即可执行批量操作  


