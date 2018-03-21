-- MySQL dump 10.13  Distrib 5.7.21, for Linux (x86_64)
--
-- Host: localhost    Database: cmdb
-- ------------------------------------------------------
-- Server version	5.7.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cc_ApplicationBase`
--

DROP TABLE IF EXISTS `cc_ApplicationBase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_ApplicationBase` (
  `ApplicationID` int(11) NOT NULL AUTO_INCREMENT,
  `ApplicationName` varchar(64) NOT NULL DEFAULT '',
  `Creator` varchar(16) NOT NULL DEFAULT '',
  `CreateTime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `Default` int(1) NOT NULL DEFAULT '0',
  `DeptName` varchar(64) NOT NULL DEFAULT '',
  `Description` varchar(256) NOT NULL DEFAULT '',
  `Display` int(1) NOT NULL DEFAULT '1',
  `GroupName` varchar(64) NOT NULL DEFAULT '',
  `LifeCycle` varchar(16) NOT NULL DEFAULT '',
  `Maintainers` varchar(512) DEFAULT '',
  `LastTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Level` int(1) NOT NULL DEFAULT '2',
  `Owner` varchar(16) NOT NULL DEFAULT '',
  `ProductPm` varchar(128) NOT NULL DEFAULT '',
  `Type` int(1) NOT NULL DEFAULT '0',
  `Source` varchar(16) NOT NULL DEFAULT '',
  `CompanyID` int(11) NOT NULL DEFAULT '0',
  `BusinessDeptName` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`ApplicationID`),
  KEY `i_ApplicationName` (`ApplicationName`),
  KEY `i_Creator` (`Creator`),
  KEY `i_Owner` (`Owner`),
  KEY `i_Maintainers` (`Maintainers`(255))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='ä¸šåŠ¡åŸºç¡€ä¿¡æ¯è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cc_ApplicationBase`
--

LOCK TABLES `cc_ApplicationBase` WRITE;
/*!40000 ALTER TABLE `cc_ApplicationBase` DISABLE KEYS */;
INSERT INTO `cc_ApplicationBase` VALUES (1,'资源池','公司名称','2018-03-21 22:59:07',1,'','',1,'','','公司名称','2018-03-21 14:59:07',2,'公司名称','',0,'0',0,''),(2,'示例业务','admin','2018-03-21 22:59:07',0,'公司名称','',1,'','公测','_admin_','2018-03-21 22:59:07',3,'公司名称','_admin_',0,'',0,'');
/*!40000 ALTER TABLE `cc_ApplicationBase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cc_BaseParameterData`
--

DROP TABLE IF EXISTS `cc_BaseParameterData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_BaseParameterData` (
  `ParameterID` int(11) NOT NULL AUTO_INCREMENT,
  `CreateTime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `DataType` varchar(50) NOT NULL DEFAULT '',
  `LastTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ParameterCode` varchar(50) NOT NULL DEFAULT '',
  `ParameterName` varchar(50) NOT NULL DEFAULT '',
  `ParentCode` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`ParameterID`),
  KEY `i_DatraType` (`DataType`),
  KEY `i_ParameterCode` (`ParameterCode`),
  KEY `i_ParameterName` (`ParameterName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cc_BaseParameterData`
--

LOCK TABLES `cc_BaseParameterData` WRITE;
/*!40000 ALTER TABLE `cc_BaseParameterData` DISABLE KEYS */;
/*!40000 ALTER TABLE `cc_BaseParameterData` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cc_HostBase`
--

DROP TABLE IF EXISTS `cc_HostBase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_HostBase` (
  `HostID` int(11) NOT NULL AUTO_INCREMENT,
  `AssetID` varchar(64) NOT NULL DEFAULT '',
  `BakOperator` varchar(16) NOT NULL DEFAULT '',
  `Cpu` int(3) NOT NULL DEFAULT '0',
  `CreateTime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `Description` varchar(256) NOT NULL DEFAULT '',
  `DeviceClass` varchar(32) NOT NULL DEFAULT '',
  `HardMemo` varchar(512) NOT NULL DEFAULT '',
  `HostName` varchar(32) NOT NULL DEFAULT '',
  `IdcName` varchar(128) NOT NULL DEFAULT '',
  `InnerIP` varchar(128) NOT NULL DEFAULT '',
  `LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Mem` int(5) NOT NULL DEFAULT '0',
  `Operator` varchar(16) NOT NULL DEFAULT '',
  `OSName` varchar(32) NOT NULL DEFAULT '',
  `OuterIP` varchar(128) NOT NULL DEFAULT '',
  `PosCode` int(3) NOT NULL DEFAULT '0',
  `Region` varchar(8) NOT NULL DEFAULT '',
  `ServerRack` varchar(16) NOT NULL DEFAULT '',
  `SN` varchar(32) NOT NULL DEFAULT '',
  `Source` varchar(16) NOT NULL DEFAULT '',
  `Status` varchar(32) NOT NULL DEFAULT '',
  `ZoneID` int(11) NOT NULL DEFAULT '0',
  `ZoneName` varchar(100) NOT NULL DEFAULT '',
  `GseProxy` int(1) DEFAULT '0',
  `Extend001` varchar(255) NOT NULL DEFAULT '',
  `Extend002` varchar(255) NOT NULL DEFAULT '',
  `Extend003` varchar(255) NOT NULL DEFAULT '',
  `Extend004` varchar(255) NOT NULL DEFAULT '',
  `Extend005` varchar(255) NOT NULL DEFAULT '',
  `Customer001` varchar(255) NOT NULL DEFAULT '',
  `Customer002` varchar(255) NOT NULL DEFAULT '',
  `Customer003` varchar(255) NOT NULL DEFAULT '',
  `Customer004` varchar(255) NOT NULL DEFAULT '',
  `Customer005` varchar(255) NOT NULL DEFAULT '',
  `Customer006` varchar(255) NOT NULL DEFAULT '',
  `Customer007` varchar(255) NOT NULL DEFAULT '',
  `Customer008` varchar(255) NOT NULL DEFAULT '',
  `Customer009` varchar(255) NOT NULL DEFAULT '',
  `Customer010` varchar(255) NOT NULL DEFAULT '',
  `Customer011` varchar(255) NOT NULL DEFAULT '',
  `Customer012` varchar(255) NOT NULL DEFAULT '',
  `Customer013` varchar(255) NOT NULL DEFAULT '',
  `Customer014` varchar(255) NOT NULL DEFAULT '',
  `Customer015` varchar(255) NOT NULL DEFAULT '',
  `Customer016` varchar(255) NOT NULL DEFAULT '',
  `Customer017` varchar(255) NOT NULL DEFAULT '',
  `Customer018` varchar(255) NOT NULL DEFAULT '',
  `Customer019` varchar(255) NOT NULL DEFAULT '',
  `Customer020` varchar(255) NOT NULL DEFAULT '',
  `Customer021` varchar(255) NOT NULL DEFAULT '',
  `Customer022` varchar(255) NOT NULL DEFAULT '',
  `Customer023` varchar(255) NOT NULL DEFAULT '',
  `Customer024` varchar(255) NOT NULL DEFAULT '',
  `Customer025` varchar(255) NOT NULL DEFAULT '',
  `Customer026` varchar(255) NOT NULL DEFAULT '',
  `Customer027` varchar(255) NOT NULL DEFAULT '',
  `Customer028` varchar(255) NOT NULL DEFAULT '',
  `Customer029` varchar(255) NOT NULL DEFAULT '',
  `Customer030` varchar(255) NOT NULL DEFAULT '',
  `Customer031` varchar(255) NOT NULL DEFAULT '',
  `Customer032` varchar(255) NOT NULL DEFAULT '',
  `Customer033` varchar(255) NOT NULL DEFAULT '',
  `Customer034` varchar(255) NOT NULL DEFAULT '',
  `Customer035` varchar(255) NOT NULL DEFAULT '',
  `Customer036` varchar(255) NOT NULL DEFAULT '',
  `Customer037` varchar(255) NOT NULL DEFAULT '',
  `Customer038` varchar(255) NOT NULL DEFAULT '',
  `Customer039` varchar(255) NOT NULL DEFAULT '',
  `Customer040` varchar(255) NOT NULL DEFAULT '',
  `Customer041` varchar(255) NOT NULL DEFAULT '',
  `Customer042` varchar(255) NOT NULL DEFAULT '',
  `Customer043` varchar(255) NOT NULL DEFAULT '',
  `Customer044` varchar(255) NOT NULL DEFAULT '',
  `Customer045` varchar(255) NOT NULL DEFAULT '',
  `Customer046` varchar(255) NOT NULL DEFAULT '',
  `Customer047` varchar(255) NOT NULL DEFAULT '',
  `Customer048` varchar(255) NOT NULL DEFAULT '',
  `Customer049` varchar(255) NOT NULL DEFAULT '',
  `Customer050` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`HostID`),
  KEY `i_AssetID` (`AssetID`),
  KEY `i_BakOperator` (`BakOperator`),
  KEY `i_HostName` (`HostName`),
  KEY `i_InnerIP` (`InnerIP`),
  KEY `i_Operator` (`Operator`),
  KEY `i_OuterIP` (`OuterIP`),
  KEY `i_Source` (`Source`),
  KEY `i_SN` (`SN`),
  KEY `i_CreateTime` (`CreateTime`),
  KEY `i_DeviceClass` (`DeviceClass`),
  KEY `i_OSName` (`OSName`),
  KEY `i_Region` (`Region`),
  KEY `i_Status` (`Status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='ä¸»æœºåŸºç¡€ä¿¡æ¯è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cc_HostBase`
--

LOCK TABLES `cc_HostBase` WRITE;
/*!40000 ALTER TABLE `cc_HostBase` DISABLE KEYS */;
/*!40000 ALTER TABLE `cc_HostBase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cc_HostCustomerProperty`
--

DROP TABLE IF EXISTS `cc_HostCustomerProperty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_HostCustomerProperty` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PropertyKey` varchar(25) NOT NULL,
  `PropertyName` varchar(25) NOT NULL,
  `Group` varchar(16) NOT NULL,
  `HostTableField` varchar(16) NOT NULL,
  `Owner` varchar(16) NOT NULL,
  `CreateTime` datetime NOT NULL,
  `LastTime` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cc_HostCustomerProperty`
--

LOCK TABLES `cc_HostCustomerProperty` WRITE;
/*!40000 ALTER TABLE `cc_HostCustomerProperty` DISABLE KEYS */;
/*!40000 ALTER TABLE `cc_HostCustomerProperty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cc_HostPropertyClassify`
--

DROP TABLE IF EXISTS `cc_HostPropertyClassify`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_HostPropertyClassify` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PropertyKey` varchar(25) NOT NULL,
  `PropertyName` varchar(25) NOT NULL,
  `Group` varchar(16) NOT NULL DEFAULT '',
  `HostTableField` varchar(16) NOT NULL DEFAULT '',
  `Order` int(2) NOT NULL DEFAULT '0',
  `CreateTime` datetime NOT NULL,
  `LastTime` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cc_HostPropertyClassify`
--

LOCK TABLES `cc_HostPropertyClassify` WRITE;
/*!40000 ALTER TABLE `cc_HostPropertyClassify` DISABLE KEYS */;
INSERT INTO `cc_HostPropertyClassify` VALUES (1,'AssetID','固资编号','basic','AssetID',12,'2016-02-24 11:26:57','2016-02-24 18:00:57'),(7,'DeviceClass','设备类型','basic','DeviceClass',11,'2016-02-24 17:24:04','2016-02-24 18:01:24'),(8,'HostName','主机名称','basic','HostName',6,'2016-02-24 17:26:00','2016-02-24 18:01:48'),(9,'Status','运行状态','basic','Status',7,'2016-02-24 18:02:23','2016-02-25 14:45:38'),(10,'Operator','维护人','basic','Operator',3,'2016-02-24 18:02:41','2016-02-24 18:03:14'),(11,'BakOperator','备份维护人','basic','BakOperator',4,'2016-02-24 18:03:37','2016-02-24 18:03:37'),(12,'InnerIP','内网IP','basic','InnerIP',1,'2016-02-24 18:04:01','2016-02-24 18:04:01'),(13,'OuterIP','外网IP','basic','OuterIP',2,'2016-02-24 18:04:31','2016-02-24 18:04:31'),(14,'OSName','操作系统','basic','OSName',7,'2016-02-24 18:04:53','2016-02-24 18:04:53'),(15,'Description','备注','basic','Description',13,'2016-02-24 18:05:10','2016-02-24 18:05:10'),(16,'ZoneName','可用区','basic','ZoneName',15,'2016-02-24 18:05:39','2016-02-24 18:05:39'),(17,'ZoneID','可用区ID','basic','ZoneID',14,'2016-02-24 18:06:07','2016-02-24 18:06:07'),(47,'CreateTime','入库时间','basic','CreateTime',17,'2016-02-24 19:11:25','2016-02-24 19:11:25'),(49,'Region','机房城市','basic','Region',16,'2016-02-24 19:12:21','2016-02-24 19:12:21'),(51,'Cpu','Cpu','basic','Cpu',8,'2016-02-24 19:13:12','2016-02-24 19:13:12'),(52,'Mem','内存','basic','Mem',9,'2016-02-24 19:13:37','2016-02-24 19:13:37'),(60,'HostID','主机ID','basic','HostID',0,'2016-02-24 19:16:54','2016-02-24 19:16:54'),(72,'ModuleName','模块名称','basic','ModuleName',5,'2016-02-24 18:02:41','2016-02-24 18:02:41');
/*!40000 ALTER TABLE `cc_HostPropertyClassify` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cc_HostSource`
--

DROP TABLE IF EXISTS `cc_HostSource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_HostSource` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SourceCode` varchar(32) CHARACTER SET utf8 NOT NULL DEFAULT '''''',
  `SourceName` varchar(128) CHARACTER SET utf8 NOT NULL DEFAULT '''''',
  `IsPublic` int(1) NOT NULL DEFAULT '1',
  `CompanyCode` varchar(16) CHARACTER SET utf8 NOT NULL DEFAULT '''''',
  `CreateTime` datetime NOT NULL,
  `LastTime` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cc_HostSource`
--

LOCK TABLES `cc_HostSource` WRITE;
/*!40000 ALTER TABLE `cc_HostSource` DISABLE KEYS */;
/*!40000 ALTER TABLE `cc_HostSource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cc_ModuleBase`
--

DROP TABLE IF EXISTS `cc_ModuleBase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_ModuleBase` (
  `ModuleID` int(11) NOT NULL AUTO_INCREMENT,
  `ApplicationID` int(11) NOT NULL DEFAULT '0',
  `BakOperator` varchar(16) NOT NULL DEFAULT '',
  `CreateTime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `Default` int(1) NOT NULL DEFAULT '0',
  `Description` varchar(256) NOT NULL DEFAULT '',
  `LastTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ModuleName` varchar(64) NOT NULL DEFAULT '',
  `Operator` varchar(16) NOT NULL DEFAULT '',
  `SetID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ModuleID`),
  KEY `i_ApplicationID` (`ApplicationID`),
  KEY `i_ModuleName` (`ModuleName`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='æ¨¡å—åŸºç¡€ä¿¡æ¯è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cc_ModuleBase`
--

LOCK TABLES `cc_ModuleBase` WRITE;
/*!40000 ALTER TABLE `cc_ModuleBase` DISABLE KEYS */;
INSERT INTO `cc_ModuleBase` VALUES (1,1,'','2018-03-21 22:59:07',1,'','2018-03-21 22:59:07','空闲机','',1),(2,2,'','1970-01-01 00:00:00',1,'','2018-03-21 22:59:07','空闲机','',2),(3,2,'admin','2018-03-21 22:59:07',0,'','2018-03-21 22:59:07','示例模块','admin',3);
/*!40000 ALTER TABLE `cc_ModuleBase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cc_ModuleHostConfig`
--

DROP TABLE IF EXISTS `cc_ModuleHostConfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_ModuleHostConfig` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ApplicationID` int(11) NOT NULL DEFAULT '0',
  `Description` varchar(256) NOT NULL DEFAULT '',
  `HostID` int(11) NOT NULL DEFAULT '0',
  `ModuleID` int(11) NOT NULL DEFAULT '0',
  `SetID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `i_ApplicationID` (`ApplicationID`),
  KEY `i_HostID` (`HostID`),
  KEY `i_ModuleID` (`ModuleID`),
  KEY `i_SetID` (`SetID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='æ¨¡å—ä¸Žä¸»æœºç»‘å®šå…³ç³»è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cc_ModuleHostConfig`
--

LOCK TABLES `cc_ModuleHostConfig` WRITE;
/*!40000 ALTER TABLE `cc_ModuleHostConfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `cc_ModuleHostConfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cc_OperationLog`
--

DROP TABLE IF EXISTS `cc_OperationLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_OperationLog` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ApplicationID` int(11) NOT NULL DEFAULT '0',
  `CompanyCode` varchar(16) NOT NULL DEFAULT '',
  `Description` varchar(256) NOT NULL DEFAULT '',
  `ExecTime` double NOT NULL DEFAULT '0',
  `ClientIP` varchar(16) NOT NULL DEFAULT '',
  `OpContent` text NOT NULL,
  `OpFrom` int(1) NOT NULL DEFAULT '0',
  `Operator` varchar(16) NOT NULL DEFAULT '',
  `OpName` varchar(32) NOT NULL DEFAULT '',
  `OpTarget` varchar(32) NOT NULL DEFAULT '',
  `OpResult` int(1) NOT NULL DEFAULT '0',
  `OpTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `OpType` varchar(16) NOT NULL DEFAULT '',
  `WebSys` varchar(16) NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`),
  KEY `i_OpTime` (`OpTime`),
  KEY `i_Operator` (`Operator`),
  KEY `i_OpName` (`OpName`),
  KEY `i_ApplicationID` (`ApplicationID`),
  KEY `i_OpResult` (`OpResult`),
  KEY `i_OpTarget` (`OpTarget`),
  KEY `i_OpType` (`OpType`),
  KEY `i_WebSys` (`WebSys`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='ç”¨æˆ·æ“ä½œæ—¥å¿—è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cc_OperationLog`
--

LOCK TABLES `cc_OperationLog` WRITE;
/*!40000 ALTER TABLE `cc_OperationLog` DISABLE KEYS */;
INSERT INTO `cc_OperationLog` VALUES (1,1,'','',562.659,'','集群名[空闲机池]',0,'','新增集群','集群',1,'2018-03-21 22:59:07','新增',''),(2,1,'','',15.269,'','模块名:[空闲机]',0,'','新增模块','模块',1,'2018-03-21 22:59:07','新增',''),(3,2,'','',5.236,'','业务名：[示例业务]',0,'','新增业务','业务',1,'2018-03-21 22:59:07','新增',''),(4,2,'','',7.212,'','集群名[空闲机池]',0,'','新增集群','集群',1,'2018-03-21 22:59:07','新增',''),(5,2,'','',5.128,'','模块名:[空闲机]',0,'','新增模块','模块',1,'2018-03-21 22:59:07','新增',''),(6,2,'','',5.243,'','集群名[示例集群]',0,'','新增集群','集群',1,'2018-03-21 22:59:07','新增',''),(7,2,'','',5.013,'','模块名:[示例模块]',0,'','新增模块','模块',1,'2018-03-21 22:59:07','新增','');
/*!40000 ALTER TABLE `cc_OperationLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cc_SetBase`
--

DROP TABLE IF EXISTS `cc_SetBase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_SetBase` (
  `SetID` int(11) NOT NULL AUTO_INCREMENT,
  `ApplicationID` int(11) NOT NULL DEFAULT '0',
  `Default` int(1) NOT NULL DEFAULT '0',
  `Capacity` int(11) unsigned DEFAULT '0',
  `CreateTime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `ChnName` varchar(32) NOT NULL DEFAULT '',
  `Description` varchar(256) NOT NULL DEFAULT '',
  `EnviType` varchar(16) NOT NULL DEFAULT '',
  `LastTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ParentID` int(11) NOT NULL DEFAULT '0',
  `SetName` varchar(64) NOT NULL DEFAULT '',
  `ServiceStatus` varchar(16) NOT NULL DEFAULT '',
  `Openstatus` varchar(16) NOT NULL DEFAULT '',
  PRIMARY KEY (`SetID`),
  KEY `i_ApplicationID` (`ApplicationID`),
  KEY `i_SetID` (`SetID`),
  KEY `i_SetName` (`SetName`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='å¤§åŒºåŸºç¡€ä¿¡æ¯è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cc_SetBase`
--

LOCK TABLES `cc_SetBase` WRITE;
/*!40000 ALTER TABLE `cc_SetBase` DISABLE KEYS */;
INSERT INTO `cc_SetBase` VALUES (1,1,1,0,'2018-03-21 22:59:07','','','','2018-03-21 22:59:07',0,'空闲机池','',''),(2,2,1,0,'1970-01-01 00:00:00','','','','2018-03-21 14:59:07',0,'空闲机池','',''),(3,2,0,0,'2018-03-21 10:59:07','示例集群','','0','2018-03-21 10:59:07',0,'示例集群','0','0');
/*!40000 ALTER TABLE `cc_SetBase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cc_SetProperty`
--

DROP TABLE IF EXISTS `cc_SetProperty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_SetProperty` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PropertyType` varchar(32) NOT NULL DEFAULT '',
  `PropertyCode` varchar(32) NOT NULL DEFAULT '',
  `PropertyName` varchar(128) NOT NULL DEFAULT '',
  `CreateTime` datetime NOT NULL,
  `LastTime` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cc_SetProperty`
--

LOCK TABLES `cc_SetProperty` WRITE;
/*!40000 ALTER TABLE `cc_SetProperty` DISABLE KEYS */;
INSERT INTO `cc_SetProperty` VALUES (1,'SetEnviType','1','测试','2015-12-28 18:19:28','2015-12-28 18:19:28'),(2,'SetEnviType','2','体验','2015-12-28 18:19:38','2015-12-28 18:19:38'),(3,'SetEnviType','3','正式','2015-12-28 18:19:48','2015-12-28 18:19:48'),(4,'SetServiceStatus','0','关闭','2015-12-28 18:20:03','2015-12-28 18:20:03'),(5,'SetServiceStatus','1','开放','2015-12-28 18:20:14','2015-12-28 18:20:14');
/*!40000 ALTER TABLE `cc_SetProperty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cc_SysPermissions`
--

DROP TABLE IF EXISTS `cc_SysPermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_SysPermissions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Action` varchar(32) NOT NULL DEFAULT '',
  `Controller` varchar(32) NOT NULL DEFAULT '',
  `Folder1` varchar(32) NOT NULL DEFAULT '',
  `Folder2` varchar(32) NOT NULL DEFAULT '',
  `Admin` int(1) NOT NULL DEFAULT '1',
  `Qcloud` int(1) NOT NULL DEFAULT '1',
  `Tencent` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ID`),
  KEY `i_Action` (`Action`),
  KEY `i_Controller` (`Controller`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='ç³»ç»Ÿæƒé™è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cc_SysPermissions`
--

LOCK TABLES `cc_SysPermissions` WRITE;
/*!40000 ALTER TABLE `cc_SysPermissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `cc_SysPermissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cc_UrlVisitLog`
--

DROP TABLE IF EXISTS `cc_UrlVisitLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_UrlVisitLog` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Action` varchar(16) NOT NULL DEFAULT '',
  `Controller` varchar(16) NOT NULL DEFAULT '',
  `ClientIP` varchar(16) NOT NULL DEFAULT '',
  `CompanyCode` varchar(16) NOT NULL DEFAULT '',
  `Description` varchar(256) NOT NULL DEFAULT '',
  `Folder1` varchar(16) NOT NULL DEFAULT '',
  `Folder2` varchar(16) NOT NULL DEFAULT '',
  `LastTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ServerIP` varchar(16) NOT NULL DEFAULT '',
  `UserName` varchar(16) NOT NULL DEFAULT '',
  `WebSys` varchar(16) NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`),
  KEY `i_UserName` (`UserName`),
  KEY `i_CompanyCode` (`CompanyCode`),
  KEY `i_Controller` (`Folder1`,`Folder2`,`Controller`,`Action`),
  KEY `i_LastTime` (`LastTime`),
  KEY `i_WebSys` (`WebSys`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='urlè®¿é—®æ—¥å¿—è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cc_UrlVisitLog`
--

LOCK TABLES `cc_UrlVisitLog` WRITE;
/*!40000 ALTER TABLE `cc_UrlVisitLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `cc_UrlVisitLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cc_User`
--

DROP TABLE IF EXISTS `cc_User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_User` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `UserName` varchar(128) NOT NULL DEFAULT '',
  `Password` varchar(128) NOT NULL DEFAULT '',
  `ChName` varchar(256) NOT NULL DEFAULT '',
  `Company` varchar(128) NOT NULL DEFAULT '',
  `Tel` varchar(45) NOT NULL,
  `QQ` varchar(45) NOT NULL DEFAULT '',
  `Email` varchar(128) NOT NULL DEFAULT '',
  `Role` enum('admin','user') NOT NULL DEFAULT 'user',
  `Status` enum('ok','disabled') NOT NULL DEFAULT 'ok',
  `TokenExpire` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UserName_UNIQUE` (`UserName`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cc_User`
--

LOCK TABLES `cc_User` WRITE;
/*!40000 ALTER TABLE `cc_User` DISABLE KEYS */;
INSERT INTO `cc_User` VALUES (1,'admin','$2y$10$dBv5y.ArJAMkzJQ4f4X7Pe40thyfJujNYIcXhPpPrwn6rPRJzMNDy','公司管理员','公司名称','13111112222','12345','admin@sample.com','admin','ok',1521734547),(2,'opadmin','$2y$10$qLcQKm/UndQ8pp17PtCPx.abdIpFOAlOJ/MHy4ImgWKBeTN5K.rY.','justtest','公司名称','15992754590','15992754590','90@qq.com','admin','ok',0);
/*!40000 ALTER TABLE `cc_User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cc_UserCustom`
--

DROP TABLE IF EXISTS `cc_UserCustom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_UserCustom` (
  `UserName` varchar(16) NOT NULL DEFAULT '',
  `DefaultApplication` int(11) NOT NULL DEFAULT '0',
  `DefaultColumn` text NOT NULL,
  `DefaultPageSize` int(2) NOT NULL DEFAULT '20',
  `DefaultField` varchar(512) NOT NULL DEFAULT '' COMMENT 'ä¸»æœºæŸ¥è¯¢å­—æ®µ',
  `DefaultCon` text NOT NULL COMMENT 'ä¸»æœºæŸ¥è¯¢æ¡ä»¶',
  `Description` varchar(256) NOT NULL DEFAULT '',
  `SetGseCol` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`UserName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='ç”¨æˆ·å®šåˆ¶è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cc_UserCustom`
--

LOCK TABLES `cc_UserCustom` WRITE;
/*!40000 ALTER TABLE `cc_UserCustom` DISABLE KEYS */;
/*!40000 ALTER TABLE `cc_UserCustom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cc_UserLoginLog`
--

DROP TABLE IF EXISTS `cc_UserLoginLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_UserLoginLog` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ClientIP` varchar(16) NOT NULL DEFAULT '',
  `Description` varchar(256) NOT NULL DEFAULT '',
  `LastTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ServerIP` varchar(16) NOT NULL DEFAULT '',
  `UserName` varchar(16) NOT NULL DEFAULT '',
  `UserAgent` varchar(512) NOT NULL DEFAULT '',
  `WebSys` varchar(16) NOT NULL DEFAULT '',
  `CompanyCode` varchar(16) NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`),
  KEY `i_CompanyCode` (`WebSys`),
  KEY `i_UserName` (`UserName`),
  KEY `i_LastTime` (`LastTime`),
  KEY `i_WebSys` (`WebSys`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='ç”¨æˆ·ç™»å½•æ—¥å¿—è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cc_UserLoginLog`
--

LOCK TABLES `cc_UserLoginLog` WRITE;
/*!40000 ALTER TABLE `cc_UserLoginLog` DISABLE KEYS */;
INSERT INTO `cc_UserLoginLog` VALUES (1,'10.10.1.124','','2018-03-21 23:03:57','172.24.0.4','','Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:59.0) Gecko/20100101 Firefox/59.0','',''),(2,'10.10.1.124','','2018-03-22 00:02:41','172.24.0.4','','Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:59.0) Gecko/20100101 Firefox/59.0','','');
/*!40000 ALTER TABLE `cc_UserLoginLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cc_UserPermissions`
--

DROP TABLE IF EXISTS `cc_UserPermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cc_UserPermissions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ChName` varchar(32) NOT NULL DEFAULT '',
  `CreateTime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `Description` varchar(256) NOT NULL DEFAULT '',
  `GroupID` int(1) NOT NULL DEFAULT '2',
  `GroupName` varchar(16) NOT NULL DEFAULT 'ä¸šåŠ¡è¿ç»´',
  `LastTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `OwnerName` varchar(64) NOT NULL DEFAULT '',
  `OwnerUin` varchar(16) NOT NULL DEFAULT '',
  `ParentUin` varchar(16) NOT NULL DEFAULT '',
  `UserName` varchar(16) NOT NULL DEFAULT '',
  `UserType` varchar(16) NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`),
  KEY `i_GroupID` (`GroupID`),
  KEY `i_OwnerUin` (`OwnerUin`),
  KEY `i_ParentUin` (`ParentUin`),
  KEY `i_UserName` (`UserName`),
  KEY `i_UserType` (`UserType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='ç”¨æˆ·ä¿¡æ¯è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cc_UserPermissions`
--

LOCK TABLES `cc_UserPermissions` WRITE;
/*!40000 ALTER TABLE `cc_UserPermissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `cc_UserPermissions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-03-21 16:15:03
