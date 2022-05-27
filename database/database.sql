-- MySQL dump 10.13  Distrib 5.6.50, for Linux (x86_64)
--
-- Host: localhost    Database: codemiracle
-- ------------------------------------------------------
-- Server version	5.6.50-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ea_mall_cate`
--

DROP TABLE IF EXISTS `ea_mall_cate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ea_mall_cate` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(20) NOT NULL COMMENT '分类名',
  `image` varchar(500) DEFAULT NULL COMMENT '分类图片',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '状态(1:禁用,2:启用)',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注说明',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(11) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商品分类';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ea_mall_cate`
--

LOCK TABLES `ea_mall_cate` WRITE;
/*!40000 ALTER TABLE `ea_mall_cate` DISABLE KEYS */;
INSERT INTO `ea_mall_cate` VALUES (9,'手机','http://admin.host/upload/20200514/98fc09b0c4ad4d793a6f04bef79a0edc.jpg',0,1,'',1589440437,1589440437,NULL);
/*!40000 ALTER TABLE `ea_mall_cate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ea_mall_goods`
--

DROP TABLE IF EXISTS `ea_mall_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ea_mall_goods` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cate_id` int(11) DEFAULT NULL COMMENT '分类ID',
  `title` varchar(20) NOT NULL COMMENT '商品名称',
  `logo` varchar(500) DEFAULT NULL COMMENT '商品logo',
  `images` text COMMENT '商品图片 以 | 做分割符号',
  `describe` text COMMENT '商品描述',
  `market_price` decimal(10,2) DEFAULT '0.00' COMMENT '市场价',
  `discount_price` decimal(10,2) DEFAULT '0.00' COMMENT '折扣价',
  `sales` int(11) DEFAULT '0' COMMENT '销量',
  `virtual_sales` int(11) DEFAULT '0' COMMENT '虚拟销量',
  `stock` int(11) DEFAULT '0' COMMENT '库存',
  `total_stock` int(11) DEFAULT '0' COMMENT '总库存',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '状态(1:禁用,2:启用)',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注说明',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(11) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `cate_id` (`cate_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商品列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ea_mall_goods`
--

LOCK TABLES `ea_mall_goods` WRITE;
/*!40000 ALTER TABLE `ea_mall_goods` DISABLE KEYS */;
INSERT INTO `ea_mall_goods` VALUES (8,10,'落地-风扇','http://admin.host/upload/20200514/a0f7fe9637abd219f7e93ceb2820df9b.jpg','http://admin.host/upload/20200514/95496713918290f6315ea3f87efa6bf2.jpg|http://admin.host/upload/20200514/ae29fa9cba4fc02defb7daed41cb2b13.jpg|http://admin.host/upload/20200514/f0a104d88ec7dc6fb42d2f87cbc71b76.jpg|http://admin.host/upload/20200514/3b88be4b1934690e5c1bd6b54b9ab5c8.jpg','<p>76654757</p>\n\n<p><img alt=\"\" src=\"http://admin.host/upload/20200515/198070421110fa01f2c2ac2f52481647.jpg\" style=\"height:689px; width:790px\" /></p>\n\n<p><img alt=\"\" src=\"http://admin.host/upload/20200515/a07a742c15a78781e79f8a3317006c1d.jpg\" style=\"height:877px; width:790px\" /></p>\n',599.00,368.00,0,594,0,0,675,1,'',1589454309,1589567016,NULL),(9,9,'电脑','http://admin.host/upload/20200514/bbf858d469dec2e12a89460110068d3d.jpg','http://admin.host/upload/20200514/f0a104d88ec7dc6fb42d2f87cbc71b76.jpg','<p>477</p>\n',0.00,0.00,0,0,115,320,0,1,'',1589465215,1589476345,NULL);
/*!40000 ALTER TABLE `ea_mall_goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ea_system_admin`
--

DROP TABLE IF EXISTS `ea_system_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ea_system_admin` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `auth_ids` varchar(255) DEFAULT NULL COMMENT '角色权限ID',
  `head_img` varchar(255) DEFAULT NULL COMMENT '头像',
  `username` varchar(50) NOT NULL DEFAULT '' COMMENT '用户登录名',
  `password` char(40) NOT NULL DEFAULT '' COMMENT '用户登录密码',
  `phone` varchar(16) DEFAULT NULL COMMENT '联系手机号',
  `remark` varchar(255) DEFAULT '' COMMENT '备注说明',
  `login_num` bigint(20) unsigned DEFAULT '0' COMMENT '登录次数',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态(0:禁用,1:启用,)',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(11) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE,
  KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ea_system_admin`
--

LOCK TABLES `ea_system_admin` WRITE;
/*!40000 ALTER TABLE `ea_system_admin` DISABLE KEYS */;
INSERT INTO `ea_system_admin` VALUES (1,NULL,'/static/admin/images/head.jpg','codemiracle','fab488c26ebf193f008f55e660bba193dce8c767',NULL,'',8,0,1,1640445007,1641722912,NULL),(7,'7','http://39.98.246.248/upload/20220109/d45e8ea945534fbcc743b867057e3fe9.jpg','uuht','ed696eb5bba1f7460585cc6975e6cf9bf24903dd','19180731353','',1,0,1,1641722768,1641722879,NULL);
/*!40000 ALTER TABLE `ea_system_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ea_system_auth`
--

DROP TABLE IF EXISTS `ea_system_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ea_system_auth` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(20) NOT NULL COMMENT '权限名称',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '状态(1:禁用,2:启用)',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注说明',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(11) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ea_system_auth`
--

LOCK TABLES `ea_system_auth` WRITE;
/*!40000 ALTER TABLE `ea_system_auth` DISABLE KEYS */;
INSERT INTO `ea_system_auth` VALUES (1,'管理员',1,1,'测试管理员',1588921753,1589614331,NULL),(6,'游客权限',0,1,'',1588227513,1589591751,1589591751),(7,'test',0,1,'test',1641722407,1641722407,NULL);
/*!40000 ALTER TABLE `ea_system_auth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ea_system_auth_node`
--

DROP TABLE IF EXISTS `ea_system_auth_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ea_system_auth_node` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `auth_id` bigint(20) unsigned DEFAULT NULL COMMENT '角色ID',
  `node_id` bigint(20) DEFAULT NULL COMMENT '节点ID',
  PRIMARY KEY (`id`),
  KEY `index_system_auth_auth` (`auth_id`) USING BTREE,
  KEY `index_system_auth_node` (`node_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='角色与节点关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ea_system_auth_node`
--

LOCK TABLES `ea_system_auth_node` WRITE;
/*!40000 ALTER TABLE `ea_system_auth_node` DISABLE KEYS */;
INSERT INTO `ea_system_auth_node` VALUES (1,6,1),(2,6,2),(3,6,9),(4,6,12),(5,6,18),(6,6,19),(7,6,21),(8,6,22),(9,6,29),(10,6,30),(11,6,38),(12,6,39),(13,6,45),(14,6,46),(15,6,52),(16,6,53),(17,7,67),(18,7,68);
/*!40000 ALTER TABLE `ea_system_auth_node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ea_system_config`
--

DROP TABLE IF EXISTS `ea_system_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ea_system_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group` varchar(30) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '分组',
  `gname` varchar(30) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '变量名',
  `value` text CHARACTER SET utf8mb4 COMMENT '变量值',
  `remark` varchar(100) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '备注信息',
  `sort` int(10) DEFAULT '0',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `delete_time` timestamp NULL DEFAULT NULL COMMENT '软删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`gname`) USING BTREE,
  KEY `group` (`group`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8 COMMENT='系统配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ea_system_config`
--

LOCK TABLES `ea_system_config` WRITE;
/*!40000 ALTER TABLE `ea_system_config` DISABLE KEYS */;
INSERT INTO `ea_system_config` VALUES (93,'site','logo','{\"logo_title\":\"chialoop\",\"logo_coin\":\"111\",\"logo_image\":\"http:\\/\\/newadmin.apper.vip\\/upload\\/20210623\\/870c1411fd95976bf8d8fa6f8c2b651f.jpg\",\"file\":\"\"}','',0,'2021-01-25 19:58:37','2022-01-09 09:43:58',NULL),(95,'upload','default','{\"upload_type\":\"local\",\"upload_allow_ext\":\"doc,gif,ico,icon,jpg,jpeg,png.webp,mp3,mp4,p12,pem,png,rar\",\"upload_allow_size\":\"1024000000\"}','',0,'2021-01-25 23:44:14','2022-01-09 09:50:05',NULL),(105,'site','site','{\"site_name\":\"\\u51ef\\u76fe\\u7f51\\u7edc\",\"site_ico\":\"http:\\/\\/39.98.246.248\\/upload\\/20220109\\/d136700eb0450db002e2d0712c551b4f.jpg\",\"file\":\"\",\"site_version\":\"1.0.0\",\"site_beian\":\"\\u7ca4ICP\\u590716006642\\u53f7\",\"site_copyright\":\"\\u00a9\\u7248\\u6743\\u6240\\u6709 2014-2022 codeShop\\u5b98\\u7f51\"}','',0,'2022-01-09 09:43:11','2022-01-09 09:43:42',NULL);
/*!40000 ALTER TABLE `ea_system_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ea_system_log_202105`
--

DROP TABLE IF EXISTS `ea_system_log_202105`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ea_system_log_202105` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) unsigned DEFAULT '0' COMMENT '管理员ID',
  `url` varchar(1500) NOT NULL DEFAULT '' COMMENT '操作页面',
  `method` varchar(50) NOT NULL COMMENT '请求方法',
  `title` varchar(100) DEFAULT '' COMMENT '日志标题',
  `content` text NOT NULL COMMENT '内容',
  `ip` varchar(50) NOT NULL DEFAULT '' COMMENT 'IP',
  `useragent` varchar(255) DEFAULT '' COMMENT 'User-Agent',
  `create_time` int(10) DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=633 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='后台操作日志表 - 202105';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ea_system_log_202105`
--

LOCK TABLES `ea_system_log_202105` WRITE;
/*!40000 ALTER TABLE `ea_system_log_202105` DISABLE KEYS */;
INSERT INTO `ea_system_log_202105` VALUES (630,NULL,'/admin/login/index.html','post','','{\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"captcha\":\"bv2i\",\"keep_login\":\"1\"}','1.83.129.82','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36',1621714962),(631,1,'/admin/system.node/refreshNode?force=1','post','','{\"force\":\"1\"}','1.83.129.82','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36',1621717464),(632,1,'/admin/system.node/clearNode','post','','[]','1.83.129.82','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36',1621717468);
/*!40000 ALTER TABLE `ea_system_log_202105` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ea_system_log_202106`
--

DROP TABLE IF EXISTS `ea_system_log_202106`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ea_system_log_202106` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) unsigned DEFAULT '0' COMMENT '管理员ID',
  `url` varchar(1500) NOT NULL DEFAULT '' COMMENT '操作页面',
  `method` varchar(50) NOT NULL COMMENT '请求方法',
  `title` varchar(100) DEFAULT '' COMMENT '日志标题',
  `content` text NOT NULL COMMENT '内容',
  `ip` varchar(50) NOT NULL DEFAULT '' COMMENT 'IP',
  `useragent` varchar(255) DEFAULT '' COMMENT 'User-Agent',
  `create_time` int(10) DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=679 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='后台操作日志表 - 202106';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ea_system_log_202106`
--

LOCK TABLES `ea_system_log_202106` WRITE;
/*!40000 ALTER TABLE `ea_system_log_202106` DISABLE KEYS */;
INSERT INTO `ea_system_log_202106` VALUES (630,NULL,'/admin/login/index.html','post','','{\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"captcha\":\"mxc3\",\"keep_login\":\"0\"}','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.90 Safari/537.36',1623025652),(631,NULL,'/admin/login/index.html','post','','{\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"captcha\":\"beav\",\"keep_login\":\"0\"}','36.44.25.118','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624263459),(632,NULL,'/admin/login/index.html','post','','{\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"captcha\":\"naek\",\"keep_login\":\"0\"}','36.44.25.118','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624263466),(633,1,'/admin/system.uploadfile/delete','post','','{\"id\":[\"302\",\"301\",\"300\",\"299\",\"298\",\"297\",\"296\",\"291\",\"290\",\"289\",\"288\",\"287\",\"286\"]}','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624264950),(634,NULL,'/admin/login/index.html','post','','{\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"captcha\":\"CUJ2\",\"keep_login\":\"0\"}','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624375463),(635,1,'/admin/system.config/save','post','','{\"upload_type\":\"local\",\"upload_allow_ext\":\"doc,gif,ico,icon,jpg,mp3,mp4,p12,pem,png,rar,jpeg,DSDS\",\"upload_allow_size\":\"1024000\"}','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624375483),(636,1,'/admin/system.config/save','post','','{\"upload_type\":\"local\",\"upload_allow_ext\":\"doc,gif,ico,icon,jpg,mp3,mp4,p12,pem,png,rar,jpeg,DSDS\",\"upload_allow_size\":\"1024000\"}','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624375500),(637,1,'/admin/ajax/upload','post','','[]','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624377783),(638,1,'/admin/ajax/upload','post','','[]','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624377804),(639,1,'/admin/ajax/upload','post','','[]','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624377858),(640,1,'/admin/system.config/save','post','','{\"group\":\"upload\",\"name\":\"default\",\"upload-type\":\"local\",\"upload_allow_ext\":\"doc,gif,ico,icon,jpg,jpeg,png.webp,mp3,mp4,p12,pem,png,rar,aaa\",\"upload_allow_size\":\"1024000000\"}','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624378377),(641,1,'/admin/system.config/save','post','','{\"group\":\"site\",\"name\":\"logo\",\"logo_title\":\"chialoop\",\"logo_coin\":\"111\",\"logo_image\":\"http:\\/\\/39.98.246.248:8111\\/upload\\/20210602\\/804a87d2da8fde3a0162461da9472a1b.jpg\",\"file\":\"\"}','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624378401),(642,1,'/admin/system.config/save','post','','{\"group\":\"site\",\"name\":\"site\",\"site_name\":\"chiapool\",\"site_ico\":\"https:\\/\\/kaida.apper.vip\\/upload\\/20210318\\/1d67cb3cd44ebb6e9f10bb9ac2de2991.jpg\",\"file\":\"\",\"site_version\":\"2.0.0\",\"site_beian\":\"粤ICP备16006642号1\",\"site_copyright\":\"©版权所有 2014-2020 KIDC官网\"}','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624378405),(643,1,'/admin/system.config/save','post','','{\"group\":\"site\",\"name\":\"site\",\"site_name\":\"chiapool\",\"site_ico\":\"https:\\/\\/kaida.apper.vip\\/upload\\/20210318\\/1d67cb3cd44ebb6e9f10bb9ac2de2991.jpg\",\"file\":\"\",\"site_version\":\"2.0.0\",\"site_beian\":\"粤ICP备16006642号1\",\"site_copyright\":\"©版权所有 2014-2020 KIDC官网\"}','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624378408),(644,1,'/admin/system.config/save','post','','{\"group\":\"site\",\"name\":\"site\",\"site_name\":\"chiapool\",\"site_ico\":\"https:\\/\\/kaida.apper.vip\\/upload\\/20210318\\/1d67cb3cd44ebb6e9f10bb9ac2de2991.jpg\",\"file\":\"\",\"site_version\":\"2.0.0\",\"site_beian\":\"粤ICP备16006642号1\",\"site_copyright\":\"©版权所有 2014-2020 KIDC官网\"}','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624378568),(645,1,'/admin/system.config/save','post','','{\"group\":\"site\",\"name\":\"site\",\"site_name\":\"chiapool\",\"site_ico\":\"https:\\/\\/kaida.apper.vip\\/upload\\/20210318\\/1d67cb3cd44ebb6e9f10bb9ac2de2991.jpg\",\"file\":\"\",\"site_version\":\"2.0.0\",\"site_beian\":\"粤ICP备16006642号1\",\"site_copyright\":\"©版权所有 2014-2020 KIDC官网\"}','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624378691),(646,1,'/admin/system.config/save','post','','{\"group\":\"site\",\"name\":\"site\",\"site_name\":\"chiapool\",\"site_ico\":\"https:\\/\\/kaida.apper.vip\\/upload\\/20210318\\/1d67cb3cd44ebb6e9f10bb9ac2de2991.jpg\",\"file\":\"\",\"site_version\":\"2.0.0\",\"site_beian\":\"粤ICP备16006642号1\",\"site_copyright\":\"©版权所有 2014-2020 KIDC官网\"}','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624378716),(647,1,'/admin/system.config/save','post','','{\"group\":\"site\",\"name\":\"site\",\"site_name\":\"chiapool\",\"site_ico\":\"https:\\/\\/kaida.apper.vip\\/upload\\/20210318\\/1d67cb3cd44ebb6e9f10bb9ac2de2991.jpg\",\"file\":\"\",\"site_version\":\"2.0.0\",\"site_beian\":\"粤ICP备16006642号1\",\"site_copyright\":\"©版权所有 2014-2020 KIDC官网\"}','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624378726),(648,1,'/admin/system.config/save','post','','{\"group\":\"site\",\"name\":\"site\",\"site_name\":\"chiapool\",\"site_ico\":\"https:\\/\\/kaida.apper.vip\\/upload\\/20210318\\/1d67cb3cd44ebb6e9f10bb9ac2de2991.jpg\",\"file\":\"\",\"site_version\":\"2.0.0\",\"site_beian\":\"粤ICP备16006642号1\",\"site_copyright\":\"©版权所有 2014-2020 KIDC官网\"}','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624378727),(649,1,'/admin/system.config/save','post','','{\"group\":\"site\",\"name\":\"site\",\"site_name\":\"chiapool\",\"site_ico\":\"https:\\/\\/kaida.apper.vip\\/upload\\/20210318\\/1d67cb3cd44ebb6e9f10bb9ac2de2991.jpg\",\"file\":\"\",\"site_version\":\"2.0.0\",\"site_beian\":\"粤ICP备16006642号1\",\"site_copyright\":\"©版权所有 2014-2020 KIDC官网\"}','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624378744),(650,1,'/admin/system.config/save','post','','{\"group\":\"site\",\"name\":\"logo\",\"logo_title\":\"chialoop\",\"logo_coin\":\"111\",\"logo_image\":\"http:\\/\\/39.98.246.248:8111\\/upload\\/20210602\\/804a87d2da8fde3a0162461da9472a1b.jpg\",\"file\":\"\"}','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624378750),(651,1,'/admin/system.config/save','post','','{\"group\":\"site\",\"name\":\"site\",\"site_name\":\"chiapool\",\"site_ico\":\"https:\\/\\/kaida.apper.vip\\/upload\\/20210318\\/1d67cb3cd44ebb6e9f10bb9ac2de2991.jpg\",\"file\":\"\",\"site_version\":\"2.0.0\",\"site_beian\":\"粤ICP备16006642号1\",\"site_copyright\":\"©版权所有 2014-2020 KIDC官网\"}','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624378819),(652,1,'/admin/system.config/save','post','','{\"group\":\"site\",\"name\":\"site\",\"site_name\":\"chiapool\",\"site_ico\":\"https:\\/\\/kaida.apper.vip\\/upload\\/20210318\\/1d67cb3cd44ebb6e9f10bb9ac2de2991.jpg\",\"file\":\"\",\"site_version\":\"2.0.0\",\"site_beian\":\"粤ICP备16006642号1\",\"site_copyright\":\"©版权所有 2014-2020 KIDC官网\"}','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624379007),(653,1,'/admin/system.config/save','post','','{\"group\":\"site\",\"name\":\"site\",\"site_name\":\"凯盾网络\",\"site_ico\":\"https:\\/\\/kaida.apper.vip\\/upload\\/20210318\\/1d67cb3cd44ebb6e9f10bb9ac2de2991.jpg\",\"file\":\"\",\"site_version\":\"2.0.0\",\"site_beian\":\"粤ICP备16006642号1\",\"site_copyright\":\"©版权所有 2014-2020 KIDC官网\"}','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624379028),(654,1,'/admin/ajax/upload','post','','[]','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624379531),(655,1,'/admin/ajax/upload','post','','[]','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624379648),(656,1,'/admin/ajax/upload','post','','[]','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624379705),(657,1,'/admin/ajax/upload','post','','[]','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624379720),(658,1,'/admin/ajax/upload','post','','[]','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624379896),(659,1,'/admin/ajax/upload','post','','[]','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624380020),(660,1,'/admin/ajax/upload','post','','[]','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624380283),(661,1,'/admin/ajax/upload','post','','[]','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624380311),(662,1,'/admin/ajax/upload','post','','[]','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624380463),(663,1,'/admin/ajax/upload','post','','[]','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624380502),(664,1,'/admin/ajax/upload','post','','[]','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624380615),(665,1,'/admin/ajax/upload','post','','[]','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624380746),(666,1,'/admin/ajax/upload','post','','[]','36.44.26.172','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624380945),(667,1,'/admin/system.admin/edit?id=1','post','','{\"id\":\"1\",\"head_img\":\"http:\\/\\/newadmin.apper.vip\",\"file\":\"\",\"username\":\"admin\",\"phone\":\"admin\",\"remark\":\"admin\"}','36.44.26.172','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624381186),(668,1,'/admin/system.config/save','post','','{\"group\":\"site\",\"name\":\"site\",\"site_name\":\"凯盾网络\",\"site_ico\":\"https:\\/\\/kaida.apper.vip\\/upload\\/20210318\\/1d67cb3cd44ebb6e9f10bb9ac2de2991.jpg\",\"file\":\"\",\"site_version\":\"2.0.0\",\"site_beian\":\"粤ICP备16006642号1\",\"site_copyright\":\"©版权所有 2014-2020 KIDC官网\"}','36.44.26.172','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624381395),(669,1,'/admin/ajax/upload','post','','[]','36.44.26.172','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624381973),(670,1,'/admin/system.config/save','post','','{\"group\":\"site\",\"name\":\"site\",\"site_name\":\"凯盾网络\",\"site_ico\":\"http:\\/\\/newadmin.apper.vip\\/upload\\/20210623\\/71f0421c44d17d4775174f72c2f679c2.jpeg\",\"file\":\"\",\"site_version\":\"2.0.0\",\"site_beian\":\"粤ICP备16006642号1\",\"site_copyright\":\"©版权所有 2014-2020 KIDC官网\"}','36.44.26.172','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624382040),(671,1,'/admin/system.config/save','post','','{\"group\":\"site\",\"name\":\"site\",\"site_name\":\"凯盾网络\",\"site_ico\":\"http:\\/\\/newadmin.apper.vip\\/upload\\/20210623\\/71f0421c44d17d4775174f72c2f679c2.jpeg\",\"file\":\"\",\"site_version\":\"2.0.0\",\"site_beian\":\"粤ICP备16006642号1\",\"site_copyright\":\"©版权所有 2014-2020 KIDC官网\"}','36.44.26.172','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624382074),(672,NULL,'/admin/login/index.html','post','','{\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"captcha\":\"btnv\",\"keep_login\":\"0\"}','36.44.26.172','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624413269),(673,1,'/admin/ajax/upload','post','','[]','36.44.26.172','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624414209),(674,1,'/admin/ajax/upload','post','','[]','36.44.26.172','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624414425),(675,1,'/admin/ajax/upload','post','','[]','36.44.26.172','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624414572),(676,1,'/admin/system.config/save','post','','{\"group\":\"site\",\"name\":\"logo\",\"logo_title\":\"chialoop\",\"logo_coin\":\"111\",\"logo_image\":\"http:\\/\\/newadmin.apper.vip\\/upload\\/20210623\\/870c1411fd95976bf8d8fa6f8c2b651f.jpg\",\"file\":\"\"}','36.44.26.172','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624414575),(677,1,'/admin/system.admin/edit?id=1','post','','{\"id\":\"1\",\"head_img\":\"http:\\/\\/newadmin.apper.vip\",\"file\":\"\",\"username\":\"admin\",\"phone\":\"admin\",\"remark\":\"admin\"}','36.44.26.172','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624414624),(678,1,'/admin/system.config/save','post','','{\"group\":\"site\",\"name\":\"site\",\"site_name\":\"凯盾网络\",\"site_ico\":\"http:\\/\\/newadmin.apper.vip\\/upload\\/20210623\\/e8a89b2ac48333ec1294d40bdc6bc5f9.jpg\",\"file\":\"\",\"site_version\":\"2.0.0\",\"site_beian\":\"粤ICP备16006642号1\",\"site_copyright\":\"©版权所有 2014-2020 KIDC官网\"}','36.44.26.172','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36',1624414709);
/*!40000 ALTER TABLE `ea_system_log_202106` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ea_system_log_202112`
--

DROP TABLE IF EXISTS `ea_system_log_202112`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ea_system_log_202112` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) unsigned DEFAULT '0' COMMENT '管理员ID',
  `url` varchar(1500) NOT NULL DEFAULT '' COMMENT '操作页面',
  `method` varchar(50) NOT NULL COMMENT '请求方法',
  `title` varchar(100) DEFAULT '' COMMENT '日志标题',
  `content` text NOT NULL COMMENT '内容',
  `ip` varchar(50) NOT NULL DEFAULT '' COMMENT 'IP',
  `useragent` varchar(255) DEFAULT '' COMMENT 'User-Agent',
  `create_time` int(10) DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=641 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='后台操作日志表 - 202112';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ea_system_log_202112`
--

LOCK TABLES `ea_system_log_202112` WRITE;
/*!40000 ALTER TABLE `ea_system_log_202112` DISABLE KEYS */;
INSERT INTO `ea_system_log_202112` VALUES (630,NULL,'/admin/login/index.html','post','','{\"username\":\"admin\",\"password\":\"ed696eb5bba1f7460585cc6975e6cf9bf24903dd\",\"captcha\":\"c5st\",\"keep_login\":\"0\"}','117.39.0.28','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1639921530),(631,1,'/admin/ajax/upload','post','','[]','117.39.0.28','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1639921553),(632,1,'/admin/ajax/upload','post','','[]','117.39.0.28','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1639921896),(633,1,'/admin/ajax/upload','post','','[]','117.39.0.28','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1639922747),(634,NULL,'/admin/login/index.html','post','','{\"username\":\"admin\",\"password\":\"***********\",\"keep_login\":\"0\"}','36.44.36.237','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1640445075),(635,NULL,'/admin/login/index.html','post','','{\"username\":\"codemiracle\",\"password\":\"***********\",\"keep_login\":\"0\"}','36.44.36.237','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1640445079),(636,NULL,'/admin/login/index.html','post','','{\"username\":\"codemiracle\",\"password\":\"***********\",\"keep_login\":\"0\"}','36.44.36.237','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1640445084),(637,NULL,'/admin/login/index.html','post','','{\"username\":\"codemiracle\",\"password\":\"***********\",\"keep_login\":\"1\"}','36.44.36.237','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1640445095),(638,NULL,'/admin/login/index.html','post','','{\"username\":\"codemiracle\",\"password\":\"***********\",\"keep_login\":\"0\"}','36.44.36.237','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',1640445102),(639,NULL,'/admin/login/index.html','post','','{\"username\":\"codemiracle\",\"password\":\"***********\",\"keep_login\":\"0\"}','36.44.36.237','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',1640445109),(640,NULL,'/admin/login/index.html','post','','{\"username\":\"codemiracle\",\"password\":\"***********\",\"keep_login\":\"0\"}','36.44.36.237','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',1640445116);
/*!40000 ALTER TABLE `ea_system_log_202112` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ea_system_log_202201`
--

DROP TABLE IF EXISTS `ea_system_log_202201`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ea_system_log_202201` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) unsigned DEFAULT '0' COMMENT '管理员ID',
  `url` varchar(1500) NOT NULL DEFAULT '' COMMENT '操作页面',
  `method` varchar(50) NOT NULL COMMENT '请求方法',
  `title` varchar(100) DEFAULT '' COMMENT '日志标题',
  `content` text NOT NULL COMMENT '内容',
  `ip` varchar(50) NOT NULL DEFAULT '' COMMENT 'IP',
  `useragent` varchar(255) DEFAULT '' COMMENT 'User-Agent',
  `create_time` int(10) DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=707 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='后台操作日志表 - 202201';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ea_system_log_202201`
--

LOCK TABLES `ea_system_log_202201` WRITE;
/*!40000 ALTER TABLE `ea_system_log_202201` DISABLE KEYS */;
INSERT INTO `ea_system_log_202201` VALUES (630,NULL,'/admin/login/index.html','post','','{\"username\":\"admin\",\"password\":\"***********\",\"keep_login\":\"1\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641674213),(631,NULL,'/admin/login/index.html','post','','{\"username\":\"admin\",\"password\":\"***********\",\"keep_login\":\"1\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641674226),(632,NULL,'/admin/login/index.html','post','','{\"username\":\"codemiracle\",\"password\":\"***********\",\"keep_login\":\"1\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641674234),(633,NULL,'/admin/login/index.html','post','','{\"username\":\"codemiracle\",\"password\":\"***********\",\"keep_login\":\"1\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641674241),(634,NULL,'/admin/login/index.html','post','','{\"username\":\"codemiracle\",\"password\":\"***********\",\"keep_login\":\"1\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641674270),(635,1,'/codemiracle/system.node/clearNode','post','','[]','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641674350),(636,1,'/codemiracle/system.node/refreshNode?force=1','post','','{\"force\":\"1\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641674355),(637,1,'/codemiracle/system.node/refreshNode?force=0','post','','{\"force\":\"0\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641674370),(638,1,'/codemiracle/system.menu/modify','post','','{\"id\":\"227\",\"field\":\"status\",\"value\":\"0\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641674479),(639,NULL,'/codemiracle/login/index.html','post','','{\"username\":\"codemiracle\",\"password\":\"***********\",\"keep_login\":\"0\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641676039),(640,1,'/codemiracle/system.uploadfile/delete','post','','{\"id\":[\"302\",\"301\",\"300\",\"299\",\"298\",\"297\",\"296\",\"291\",\"290\",\"289\",\"288\",\"287\",\"286\"]}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641676299),(641,1,'/codemiracle/ajax/upload','post','','[]','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641676315),(642,1,'/codemiracle/system.config/save','post','','{\"upload_type\":\"local\",\"upload_allow_ext\":\"doc,gif,ico,icon,jpg,mp3,mp4,p12,pem,png,rar,jpeg\",\"upload_allow_size\":\"1024000\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641676381),(643,1,'/codemiracle/system.config/save','post','','{\"upload_type\":\"local\",\"upload_allow_ext\":\"doc,gif,ico,icon,jpg,mp3,mp4,p12,pem,png,rar,jpeg\",\"upload_allow_size\":\"1024000\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641676387),(644,1,'/codemiracle/system.config/save','post','','{\"site_name\":\"EasyAdmin后台系统\",\"site_ico\":\"填你的\",\"file\":\"\",\"site_version\":\"2.0.0\",\"site_beian\":\"填你的\",\"site_copyright\":\"填你的\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641676395),(645,1,'/codemiracle/system.config/save','post','','{\"upload_type\":\"local\",\"upload_allow_ext\":\"doc,gif,ico,icon,jpg,mp3,mp4,p12,pem,png,rar,jpeg\",\"upload_allow_size\":\"1024000\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641676399),(646,1,'/codemiracle/system.config/save','post','','{\"upload_type\":\"local\",\"upload_allow_ext\":\"doc,gif,ico,icon,jpg,mp3,mp4,p12,pem,png,rar,jpeg\",\"upload_allow_size\":\"1024000\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641676404),(647,1,'/codemiracle/system.config/save','post','','{\"logo_title\":\"EasyAdmin\",\"logo_image\":\"\\/favicon.ico\",\"file\":\"\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641676408),(648,1,'/codemiracle/system.config/save','post','','{\"logo_title\":\"EasyAdmin\",\"logo_image\":\"\\/favicon.ico\",\"file\":\"\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641676500),(649,1,'/codemiracle/system.config/save','post','','{\"upload_type\":\"local\",\"upload_allow_ext\":\"doc,gif,ico,icon,jpg,mp3,mp4,p12,pem,png,rar,jpeg\",\"upload_allow_size\":\"1024000\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641676503),(650,1,'/codemiracle/system.config/save','post','','{\"site_name\":\"EasyAdmin后台系统\",\"site_ico\":\"填你的\",\"file\":\"\",\"site_version\":\"2.0.0\",\"site_beian\":\"填你的\",\"site_copyright\":\"填你的\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641676507),(651,1,'/codemiracle/system.config/save','post','','{\"upload_type\":\"local\",\"upload_allow_ext\":\"doc,gif,ico,icon,jpg,mp3,mp4,p12,pem,png,rar,jpeg\",\"upload_allow_size\":\"1024000\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641676532),(652,1,'/codemiracle/system.config/save','post','','{\"upload_type\":\"local\",\"upload_allow_ext\":\"doc,gif,ico,icon,jpg,mp3,mp4,p12,pem,png,rar,jpeg\",\"upload_allow_size\":\"1024000\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641676535),(653,1,'/codemiracle/system.config/save','post','','{\"upload_type\":\"local\",\"upload_allow_ext\":\"doc,gif,ico,icon,jpg,mp3,mp4,p12,pem,png,rar,jpeg\",\"upload_allow_size\":\"102400000000\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641676911),(654,NULL,'/codemiracle/login/index.html','post','','{\"username\":\"codemiracle\",\"password\":\"***********\",\"keep_login\":\"0\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641707728),(655,NULL,'/codemiracle/login/index.html','post','','{\"username\":\"codemiracle\",\"password\":\"***********\",\"keep_login\":\"0\"}','103.86.45.35','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641715290),(656,1,'/codemiracle/ajax/upload','post','','[]','103.86.45.35','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641715566),(657,1,'/codemiracle/system.config/save','post','','{\"group\":\"upload\",\"name\":\"default\",\"upload-type\":\"local\",\"upload_allow_ext\":\"doc,gif,ico,icon,jpg,jpeg,png.webp,mp3,mp4,p12,pem,rar,apk,wgt,ipa,mobileconfig,mobileprovision,plist\",\"upload_allow_size\":\"1024000000\"}','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641719743),(658,1,'/codemiracle/system.config/save','post','','{\"group\":\"upload\",\"name\":\"default\",\"upload-type\":\"local\",\"upload_allow_ext\":\"doc,gif,ico,icon,jpg,jpeg,png.webp,mp3,mp4,p12,pem,rar,apk,wgt,ipa,mobileconfig,mobileprovision,plist\",\"upload_allow_size\":\"1024000000\"}','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641719751),(659,1,'/codemiracle/system.config/save','post','','{\"group\":\"upload\",\"name\":\"default\",\"upload-type\":\"local\",\"upload_allow_ext\":\"doc,gif,ico,icon,jpg,jpeg,png.webp,mp3,mp4,p12,pem,rar,apk,wgt,ipa,mobileconfig,mobileprovision,plist\",\"upload_allow_size\":\"1024000000\"}','103.86.47.17','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641719873),(660,1,'/codemiracle/system.config/save','post','','{\"group\":\"site\",\"name\":\"site\",\"site_name\":\"凯盾网络\",\"site_ico\":\"http:\\/\\/newadmin.apper.vip\\/upload\\/20210623\\/e8a89b2ac48333ec1294d40bdc6bc5f9.jpg\",\"file\":\"\",\"site_version\":\"1.0.0\",\"site_beian\":\"粤ICP备16006642号1\",\"site_copyright\":\"©版权所有 2014-2022 codeShop官网\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641720400),(661,1,'/codemiracle/system.config/save','post','','{\"group\":\"upload\",\"name\":\"default\",\"upload-type\":\"local\",\"upload_allow_ext\":\"doc,gif,ico,icon,jpg,jpeg,png.webp,mp3,mp4,p12,pem,png,rar\",\"upload_allow_size\":\"1024000000\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641720403),(662,NULL,'/codemiracle/login/index.html','post','','{\"username\":\"admin\",\"password\":\"***********\",\"keep_login\":\"1\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641720648),(663,NULL,'/codemiracle/login/index.html','post','','{\"username\":\"codemiracle\",\"password\":\"***********\",\"keep_login\":\"1\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641720655),(664,1,'/codemiracle/system.config/save','post','','{\"group\":\"upload\",\"name\":\"default\",\"upload-type\":\"local\",\"upload_allow_ext\":\"doc,gif,ico,icon,jpg,jpeg,png.webp,mp3,mp4,p12,pem,png,rar\",\"upload_allow_size\":\"1024000000\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641720714),(665,1,'/codemiracle/system.config/save','post','','{\"group\":\"site\",\"name\":\"site\",\"site_name\":\"凯盾网络11\",\"site_ico\":\"http:\\/\\/newadmin.apper.vip\\/upload\\/20210623\\/e8a89b2ac48333ec1294d40bdc6bc5f9.jpg\",\"file\":\"\",\"site_version\":\"1.0.0\",\"site_beian\":\"粤ICP备16006642号1\",\"site_copyright\":\"©版权所有 2014-2022 codeShop官网\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641720729),(666,1,'/codemiracle/system.config/save','post','','{\"group\":\"site\",\"name\":\"site\",\"site_name\":\"凯盾网络\",\"site_ico\":\"http:\\/\\/39.98.246.248\\/upload\\/20220109\\/d136700eb0450db002e2d0712c551b4f.jpg\",\"file\":\"\",\"site_version\":\"1.0.0\",\"site_beian\":\"粤ICP备16006642号\",\"site_copyright\":\"©版权所有 2014-2022 codeShop官网\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641720772),(667,1,'/codemiracle/system.config/save','post','','{\"group\":\"site\",\"name\":\"site\",\"site_name\":\"凯盾网络\",\"site_ico\":\"http:\\/\\/39.98.246.248\\/upload\\/20220109\\/d136700eb0450db002e2d0712c551b4f.jpg\",\"file\":\"\",\"site_version\":\"1.0.0\",\"site_beian\":\"粤ICP备16006642号\",\"site_copyright\":\"©版权所有 2014-2022 codeShop官网\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641720869),(668,1,'/codemiracle/system.config/save','post','','{\"group\":\"site\",\"name\":\"site\",\"site_name\":\"凯盾网络\",\"site_ico\":\"http:\\/\\/39.98.246.248\\/upload\\/20220109\\/d136700eb0450db002e2d0712c551b4f.jpg\",\"file\":\"\",\"site_version\":\"1.0.0\",\"site_beian\":\"粤ICP备16006642号\",\"site_copyright\":\"©版权所有 2014-2022 codeShop官网\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641721001),(669,1,'/codemiracle/system.config/save','post','','{\"group\":\"site\",\"name\":\"site\",\"site_name\":\"凯盾网络\",\"site_ico\":\"http:\\/\\/39.98.246.248\\/upload\\/20220109\\/d136700eb0450db002e2d0712c551b4f.jpg\",\"file\":\"\",\"site_version\":\"1.0.0\",\"site_beian\":\"粤ICP备16006642号\",\"site_copyright\":\"©版权所有 2014-2022 codeShop官网\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641721016),(670,1,'/codemiracle/system.config/save','post','','{\"group\":\"site\",\"name\":\"site\",\"site_name\":\"凯盾网络\",\"site_ico\":\"http:\\/\\/39.98.246.248\\/upload\\/20220109\\/d136700eb0450db002e2d0712c551b4f.jpg\",\"file\":\"\",\"site_version\":\"1.0.0\",\"site_beian\":\"粤ICP备16006642号\",\"site_copyright\":\"©版权所有 2014-2022 codeShop官网\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641721112),(671,1,'/codemiracle/system.config/save','post','','{\"group\":\"site\",\"name\":\"site\",\"site_name\":\"凯盾网络\",\"site_ico\":\"http:\\/\\/39.98.246.248\\/upload\\/20220109\\/d136700eb0450db002e2d0712c551b4f.jpg\",\"file\":\"\",\"site_version\":\"1.0.0\",\"site_beian\":\"粤ICP备16006642号\",\"site_copyright\":\"©版权所有 2014-2022 codeShop官网\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641721179),(672,1,'/codemiracle/system.config/save','post','','{\"group\":\"site\",\"name\":\"site\",\"site_name\":\"凯盾网络\",\"site_ico\":\"http:\\/\\/39.98.246.248\\/upload\\/20220109\\/d136700eb0450db002e2d0712c551b4f.jpg\",\"file\":\"\",\"site_version\":\"1.0.0\",\"site_beian\":\"粤ICP备16006642号\",\"site_copyright\":\"©版权所有 2014-2022 codeShop官网\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641721328),(673,1,'/codemiracle/system.config/save','post','','{\"group\":\"site\",\"name\":\"site\",\"site_name\":\"凯盾网络\",\"site_ico\":\"http:\\/\\/39.98.246.248\\/upload\\/20220109\\/d136700eb0450db002e2d0712c551b4f.jpg\",\"file\":\"\",\"site_version\":\"1.0.0\",\"site_beian\":\"粤ICP备16006642号\",\"site_copyright\":\"©版权所有 2014-2022 codeShop官网\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641721391),(674,1,'/codemiracle/system.config/save','post','','{\"group\":\"site\",\"name\":\"site\",\"site_name\":\"凯盾网络\",\"site_ico\":\"http:\\/\\/39.98.246.248\\/upload\\/20220109\\/d136700eb0450db002e2d0712c551b4f.jpg\",\"file\":\"\",\"site_version\":\"1.0.0\",\"site_beian\":\"粤ICP备16006642号\",\"site_copyright\":\"©版权所有 2014-2022 codeShop官网\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641721422),(675,1,'/codemiracle/system.config/save','post','','{\"group\":\"site\",\"name\":\"logo\",\"logo_title\":\"chialoop\",\"logo_coin\":\"111\",\"logo_image\":\"http:\\/\\/newadmin.apper.vip\\/upload\\/20210623\\/870c1411fd95976bf8d8fa6f8c2b651f.jpg\",\"file\":\"\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641721438),(676,1,'/codemiracle/system.config/save','post','','{\"group\":\"upload\",\"name\":\"default\",\"upload-type\":\"local\",\"upload_allow_ext\":\"doc,gif,ico,icon,jpg,jpeg,png.webp,mp3,mp4,p12,pem,png,rar,apk,ipa,wgt\",\"upload_allow_size\":\"1024000000\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641721453),(677,1,'/codemiracle/ajax/upload','post','','[]','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641721475),(678,1,'/codemiracle/ajax/upload','post','','[]','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641721595),(679,1,'/codemiracle/system.config/save','post','','{\"group\":\"upload\",\"name\":\"default\",\"upload-type\":\"local\",\"upload_allow_ext\":\"doc,gif,ico,icon,jpg,jpeg,png.webp,mp3,mp4,p12,pem,png,rar,apk,ipa,wgt\",\"upload_allow_size\":\"1024000000\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641721674),(680,1,'/codemiracle/ajax/upload','post','','[]','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641721682),(681,1,'/codemiracle/system.config/save','post','','{\"group\":\"upload\",\"name\":\"default\",\"upload-type\":\"local\",\"upload_allow_ext\":\"doc,gif,ico,icon,jpg,jpeg,png.webp,mp3,mp4,p12,pem,png,rar,apk,ipa,wgt\",\"upload_allow_size\":\"1024000000\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641721737),(682,NULL,'/codemiracle/login/index.html','post','','{\"username\":\"codemiracle\",\"password\":\"***********\",\"keep_login\":\"0\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641721796),(683,1,'/codemiracle/system.config/save','post','','{\"group\":\"upload\",\"name\":\"default\",\"upload_type\":\"local\",\"upload_allow_ext\":\"doc,gif,ico,icon,jpg,jpeg,png.webp,mp3,mp4,p12,pem,png,rar\",\"upload_allow_size\":\"1024000000\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641721805),(684,1,'/codemiracle/ajax/upload','post','','[]','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641721815),(685,1,'/codemiracle/ajax/upload','post','','[]','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641722111),(686,1,'/codemiracle/ajax/upload','post','','[]','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641722178),(687,1,'/codemiracle/ajax/upload','post','','[]','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641722221),(688,1,'/codemiracle/ajax/upload','post','','[]','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641722316),(689,1,'/codemiracle/ajax/upload','post','','[]','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641722335),(690,1,'/codemiracle/system.auth/add','post','','{\"title\":\"test\",\"remark\":\"test\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641722407),(691,1,'/codemiracle/system.auth/saveAuthorize','post','','{\"title\":\"test\",\"node\":\"[67,68]\",\"id\":\"7\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641722429),(692,1,'/codemiracle/system.admin/add','post','','{\"head_img\":\"http:\\/\\/39.98.246.248\\/upload\\/20220109\\/d45e8ea945534fbcc743b867057e3fe9.jpg\",\"file\":\"\",\"username\":\"test\",\"phone\":\"***********\",\"auth_ids\":{\"7\":\"on\"},\"remark\":\"test\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641722474),(693,1,'/codemiracle/system.admin/delete?id=1','post','','{\"id\":\"1\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641722657),(694,1,'/codemiracle/system.admin/delete?id=2','post','','{\"id\":\"2\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641722667),(695,1,'/codemiracle/system.admin/add','post','','{\"head_img\":\"http:\\/\\/39.98.246.248\\/upload\\/20220109\\/d45e8ea945534fbcc743b867057e3fe9.jpg\",\"file\":\"\",\"username\":\"test\",\"phone\":\"***********\",\"remark\":\"\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641722687),(696,1,'/codemiracle/system.admin/add','post','','{\"head_img\":\"http:\\/\\/39.98.246.248\\/upload\\/20220109\\/d45e8ea945534fbcc743b867057e3fe9.jpg\",\"file\":\"\",\"username\":\"test\",\"phone\":\"***********\",\"auth_ids\":{\"7\":\"on\"},\"remark\":\"test\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641722694),(697,1,'/codemiracle/system.admin/add','post','','{\"head_img\":\"http:\\/\\/39.98.246.248\\/upload\\/20220109\\/d45e8ea945534fbcc743b867057e3fe9.jpg\",\"file\":\"\",\"username\":\"test\",\"phone\":\"***********\",\"auth_ids\":{\"7\":\"on\"},\"remark\":\"test\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641722701),(698,1,'/codemiracle/system.admin/add','post','','{\"head_img\":\"http:\\/\\/39.98.246.248\\/upload\\/20220109\\/d45e8ea945534fbcc743b867057e3fe9.jpg\",\"file\":\"\",\"username\":\"test1\",\"phone\":\"***********\",\"auth_ids\":{\"7\":\"on\"},\"remark\":\"test\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641722708),(699,1,'/codemiracle/system.admin/add','post','','{\"head_img\":\"http:\\/\\/39.98.246.248\\/upload\\/20220109\\/d45e8ea945534fbcc743b867057e3fe9.jpg\",\"file\":\"\",\"username\":\"uuht\",\"phone\":\"***********\",\"auth_ids\":{\"7\":\"on\"},\"remark\":\"\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641722768),(700,1,'/codemiracle/system.admin/password?id=7','post','','{\"id\":\"7\",\"username\":\"uuht\",\"password\":\"***********\",\"password_again\":\"***********\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641722864),(701,NULL,'/codemiracle/login/index','post','','{\"username\":\"uuht\",\"password\":\"***********\",\"keep_login\":\"0\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641722879),(702,NULL,'/codemiracle/login/index','post','','{\"username\":\"codemiracle\",\"password\":\"***********\",\"keep_login\":\"0\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641722897),(703,1,'/codemiracle/system.admin/password?id=1','post','','{\"id\":\"1\",\"username\":\"codemiracle\",\"password\":\"***********\",\"password_again\":\"***********\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641722912),(704,1,'/codemiracle/ajax/upload','post','','{\"info\":\"\",\"type\":\"\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641723643),(705,1,'/codemiracle/ajax/upload','post','','{\"info\":\"\",\"type\":\"\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641723728),(706,1,'/codemiracle/ajax/upload','post','','{\"info\":\"\",\"type\":\"\"}','36.44.36.12','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36',1641723839);
/*!40000 ALTER TABLE `ea_system_log_202201` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ea_system_menu`
--

DROP TABLE IF EXISTS `ea_system_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ea_system_menu` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '父id',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '名称',
  `icon` varchar(100) NOT NULL DEFAULT '' COMMENT '菜单图标',
  `href` varchar(100) NOT NULL DEFAULT '' COMMENT '链接',
  `params` varchar(500) DEFAULT '' COMMENT '链接参数',
  `target` varchar(20) NOT NULL DEFAULT '_self' COMMENT '链接打开方式',
  `sort` int(11) DEFAULT '0' COMMENT '菜单排序',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态(0:禁用,1:启用)',
  `remark` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(11) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `title` (`title`),
  KEY `href` (`href`)
) ENGINE=InnoDB AUTO_INCREMENT=254 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统菜单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ea_system_menu`
--

LOCK TABLES `ea_system_menu` WRITE;
/*!40000 ALTER TABLE `ea_system_menu` DISABLE KEYS */;
INSERT INTO `ea_system_menu` VALUES (227,99999999,'后台首页','fa fa-home','index/welcome','','_self',0,1,NULL,NULL,1573120497,NULL),(228,0,'系统管理','fa fa-cog','','','_self',0,1,'',NULL,1588999529,NULL),(234,228,'菜单管理','fa fa-tree','system.menu/index','','_self',10,1,'',NULL,1588228555,NULL),(244,228,'管理员管理','fa fa-user','system.admin/index','','_self',12,1,'',1573185011,1588228573,NULL),(245,228,'角色管理','fa fa-bitbucket-square','system.auth/index','','_self',11,1,'',1573435877,1588228634,NULL),(246,228,'节点管理','fa fa-list','system.node/index','','_self',9,1,'',1573435919,1588228648,NULL),(247,228,'配置管理','fa fa-asterisk','system.config/index','','_self',8,1,'',1573457448,1588228566,NULL),(248,228,'上传管理','fa fa-arrow-up','system.uploadfile/index','','_self',0,1,'',1573542953,1588228043,NULL),(249,0,'商城管理','fa fa-list','','','_self',0,1,'',1589439884,1589439884,NULL),(250,249,'商品分类','fa fa-calendar-check-o','mall.cate/index','','_self',0,1,'',1589439910,1589439966,NULL),(251,249,'商品管理','fa fa-list','mall.goods/index','','_self',0,1,'',1589439931,1589439942,NULL),(252,228,'快捷入口','fa fa-list','system.quick/index','','_self',0,1,'',1589623683,1589623683,NULL),(253,228,'日志管理','fa fa-connectdevelop','system.log/index','','_self',0,1,'',1589623684,1589623684,NULL);
/*!40000 ALTER TABLE `ea_system_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ea_system_node`
--

DROP TABLE IF EXISTS `ea_system_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ea_system_node` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `node` varchar(100) DEFAULT NULL COMMENT '节点代码',
  `title` varchar(500) DEFAULT NULL COMMENT '节点标题',
  `type` tinyint(1) DEFAULT '3' COMMENT '节点类型（1：控制器，2：节点）',
  `is_auth` tinyint(1) unsigned DEFAULT '1' COMMENT '是否启动RBAC权限控制',
  `create_time` int(10) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `node` (`node`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统节点表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ea_system_node`
--

LOCK TABLES `ea_system_node` WRITE;
/*!40000 ALTER TABLE `ea_system_node` DISABLE KEYS */;
INSERT INTO `ea_system_node` VALUES (1,'system.admin','管理员管理',1,1,1589580432,1589580432),(2,'system.admin/index','列表',2,1,1589580432,1589580432),(3,'system.admin/add','添加',2,1,1589580432,1589580432),(4,'system.admin/edit','编辑',2,1,1589580432,1589580432),(5,'system.admin/password','编辑',2,1,1589580432,1589580432),(6,'system.admin/delete','删除',2,1,1589580432,1589580432),(7,'system.admin/modify','属性修改',2,1,1589580432,1589580432),(8,'system.admin/export','导出',2,1,1589580432,1589580432),(9,'system.auth','角色权限管理',1,1,1589580432,1589580432),(10,'system.auth/authorize','授权',2,1,1589580432,1589580432),(11,'system.auth/saveAuthorize','授权保存',2,1,1589580432,1589580432),(12,'system.auth/index','列表',2,1,1589580432,1589580432),(13,'system.auth/add','添加',2,1,1589580432,1589580432),(14,'system.auth/edit','编辑',2,1,1589580432,1589580432),(15,'system.auth/delete','删除',2,1,1589580432,1589580432),(16,'system.auth/export','导出',2,1,1589580432,1589580432),(17,'system.auth/modify','属性修改',2,1,1589580432,1589580432),(18,'system.config','系统配置管理',1,1,1589580432,1589580432),(19,'system.config/index','列表',2,1,1589580432,1589580432),(20,'system.config/save','保存',2,1,1589580432,1589580432),(21,'system.menu','菜单管理',1,1,1589580432,1589580432),(22,'system.menu/index','列表',2,1,1589580432,1589580432),(23,'system.menu/add','添加',2,1,1589580432,1589580432),(24,'system.menu/edit','编辑',2,1,1589580432,1589580432),(25,'system.menu/delete','删除',2,1,1589580432,1589580432),(26,'system.menu/modify','属性修改',2,1,1589580432,1589580432),(27,'system.menu/getMenuTips','添加菜单提示',2,1,1589580432,1589580432),(28,'system.menu/export','导出',2,1,1589580432,1589580432),(29,'system.node','系统节点管理',1,1,1589580432,1589580432),(30,'system.node/index','列表',2,1,1589580432,1589580432),(31,'system.node/refreshNode','系统节点更新',2,1,1589580432,1589580432),(32,'system.node/clearNode','清除失效节点',2,1,1589580432,1589580432),(33,'system.node/add','添加',2,1,1589580432,1589580432),(34,'system.node/edit','编辑',2,1,1589580432,1589580432),(35,'system.node/delete','删除',2,1,1589580432,1589580432),(36,'system.node/export','导出',2,1,1589580432,1589580432),(37,'system.node/modify','属性修改',2,1,1589580432,1589580432),(38,'system.uploadfile','上传文件管理',1,1,1589580432,1589580432),(39,'system.uploadfile/index','列表',2,1,1589580432,1589580432),(40,'system.uploadfile/add','添加',2,1,1589580432,1589580432),(41,'system.uploadfile/edit','编辑',2,1,1589580432,1589580432),(42,'system.uploadfile/delete','删除',2,1,1589580432,1589580432),(43,'system.uploadfile/export','导出',2,1,1589580432,1589580432),(44,'system.uploadfile/modify','属性修改',2,1,1589580432,1589580432),(45,'mall.cate','商品分类管理',1,1,1589580432,1589580432),(46,'mall.cate/index','列表',2,1,1589580432,1589580432),(47,'mall.cate/add','添加',2,1,1589580432,1589580432),(48,'mall.cate/edit','编辑',2,1,1589580432,1589580432),(49,'mall.cate/delete','删除',2,1,1589580432,1589580432),(50,'mall.cate/export','导出',2,1,1589580432,1589580432),(51,'mall.cate/modify','属性修改',2,1,1589580432,1589580432),(52,'mall.goods','商城商品管理',1,1,1589580432,1589580432),(53,'mall.goods/index','列表',2,1,1589580432,1589580432),(54,'mall.goods/stock','入库',2,1,1589580432,1589580432),(55,'mall.goods/add','添加',2,1,1589580432,1589580432),(56,'mall.goods/edit','编辑',2,1,1589580432,1589580432),(57,'mall.goods/delete','删除',2,1,1589580432,1589580432),(58,'mall.goods/export','导出',2,1,1589580432,1589580432),(59,'mall.goods/modify','属性修改',2,1,1589580432,1589580432),(60,'system.quick','快捷入口管理',1,1,1589623188,1589623188),(61,'system.quick/index','列表',2,1,1589623188,1589623188),(62,'system.quick/add','添加',2,1,1589623188,1589623188),(63,'system.quick/edit','编辑',2,1,1589623188,1589623188),(64,'system.quick/delete','删除',2,1,1589623188,1589623188),(65,'system.quick/export','导出',2,1,1589623188,1589623188),(66,'system.quick/modify','属性修改',2,1,1589623188,1589623188),(67,'system.log','操作日志管理',1,1,1589623188,1589623188),(68,'system.log/index','列表',2,1,1589623188,1589623188);
/*!40000 ALTER TABLE `ea_system_node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ea_system_quick`
--

DROP TABLE IF EXISTS `ea_system_quick`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ea_system_quick` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(20) NOT NULL COMMENT '快捷入口名称',
  `icon` varchar(100) DEFAULT NULL COMMENT '图标',
  `href` varchar(255) DEFAULT NULL COMMENT '快捷链接',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '状态(1:禁用,2:启用)',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注说明',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(11) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统快捷入口表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ea_system_quick`
--

LOCK TABLES `ea_system_quick` WRITE;
/*!40000 ALTER TABLE `ea_system_quick` DISABLE KEYS */;
INSERT INTO `ea_system_quick` VALUES (1,'管理员管理','fa fa-user','system.admin/index',0,1,'',1589624097,1589624792,NULL),(2,'角色管理','fa fa-bitbucket-square','system.auth/index',0,1,'',1589624772,1589624781,NULL),(3,'菜单管理','fa fa-tree','system.menu/index',0,1,NULL,1589624097,1589624792,NULL),(6,'节点管理','fa fa-list','system.node/index',0,1,NULL,1589624772,1589624781,NULL),(7,'配置管理','fa fa-asterisk','system.config/index',0,1,NULL,1589624097,1589624792,NULL),(8,'上传管理','fa fa-arrow-up','system.uploadfile/index',0,1,NULL,1589624772,1589624781,NULL),(10,'商品分类','fa fa-calendar-check-o','mall.cate/index',0,1,NULL,1589624097,1589624792,NULL),(11,'商品管理','fa fa-list','mall.goods/index',0,1,NULL,1589624772,1589624781,NULL);
/*!40000 ALTER TABLE `ea_system_quick` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ea_system_uploadfile`
--

DROP TABLE IF EXISTS `ea_system_uploadfile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ea_system_uploadfile` (
  `id` int(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `upload_type` varchar(20) NOT NULL DEFAULT 'local' COMMENT '存储位置',
  `original_name` varchar(255) DEFAULT NULL COMMENT '文件原名',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '物理路径',
  `image_width` varchar(30) NOT NULL DEFAULT '' COMMENT '宽度',
  `image_height` varchar(30) NOT NULL DEFAULT '' COMMENT '高度',
  `image_type` varchar(30) NOT NULL DEFAULT '' COMMENT '图片类型',
  `image_frames` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图片帧数',
  `mime_type` varchar(100) NOT NULL DEFAULT '' COMMENT 'mime类型',
  `file_size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `file_ext` varchar(100) DEFAULT NULL,
  `sha1` varchar(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `create_time` int(10) DEFAULT NULL COMMENT '创建日期',
  `update_time` int(10) DEFAULT NULL COMMENT '更新时间',
  `upload_time` int(10) DEFAULT NULL COMMENT '上传时间',
  PRIMARY KEY (`id`),
  KEY `upload_type` (`upload_type`),
  KEY `original_name` (`original_name`)
) ENGINE=InnoDB AUTO_INCREMENT=325 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='上传文件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ea_system_uploadfile`
--

LOCK TABLES `ea_system_uploadfile` WRITE;
/*!40000 ALTER TABLE `ea_system_uploadfile` DISABLE KEYS */;
INSERT INTO `ea_system_uploadfile` VALUES (316,'local','越南女孩,美女,晴朗,荷花,4K美女壁纸_千叶网.jpg','http://39.98.246.248/upload/20220109/9270b1a9f806fcc202732d18876b95be.jpg','','','',0,'image/jpeg',0,'jpg','',1641676315,NULL,NULL),(317,'local','性感身材美女,手势,4K美女壁纸_千叶网.jpg','http://39.98.246.248/upload/20220109/dd3414ecf8a2e05110075d14cb6d5f05.jpg','','','',0,'image/jpeg',0,'jpg','',1641676926,NULL,NULL),(318,'local','卷发,黑色衣服,美女4K壁纸_千叶网.jpg','http://39.98.246.248/upload/20220109/d136700eb0450db002e2d0712c551b4f.jpg','','','',0,'image/jpeg',0,'jpg','',1641715566,NULL,NULL),(319,'local','非主流装另类美女4K壁纸_千叶网.jpg','http://39.98.246.248/upload/20220109/c4d56b79015c0cb1a6fbffb8dd453abe.jpg','','','',0,'image/jpeg',0,'jpg','',1641722221,NULL,NULL),(320,'local','棕色头发模特,黄色的衣服,4k美女图片壁纸_千叶网.jpg','http://39.98.246.248/upload/20220109/921f1112ba2c656cc3862bbb2048f381.jpg','','','',0,'image/jpeg',0,'jpg','',1641722316,NULL,NULL),(321,'local','钢管舞的美女4K图片_千叶网.jpg','http://39.98.246.248/upload/20220109/d45e8ea945534fbcc743b867057e3fe9.jpg','','','',0,'image/jpeg',0,'jpg','',1641722335,NULL,NULL),(322,'local','晚上,汽车,女孩,脸,方向盘,4k美女壁纸图片_千叶网.jpg','http://39.98.246.248/upload/20220109/6b66587b1d21567283073c18fa4dcf3d.jpg','','','',0,'image/jpeg',0,'jpg','',1641723643,NULL,NULL),(323,'local','钢管舞的美女4K图片_千叶网.jpg','http://39.98.246.248/upload/20220109/647a0698a9c9807dca5ddaa9a3db7ab1.jpg','','','',0,'image/jpeg',0,'jpg','',1641723728,NULL,NULL),(324,'local','性感身材美女,手势,4K美女壁纸_千叶网.jpg','http://39.98.246.248/upload/20220109/e70083a51dacb07cce3ad9424ec4ec82.jpg','','','',0,'image/jpeg',0,'jpg','',1641723839,NULL,NULL);
/*!40000 ALTER TABLE `ea_system_uploadfile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kaadon_mall_cate`
--

DROP TABLE IF EXISTS `kaadon_mall_cate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kaadon_mall_cate` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(20) NOT NULL COMMENT '分类名',
  `image` varchar(500) DEFAULT NULL COMMENT '分类图片',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '状态(1:禁用,2:启用)',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注说明',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(11) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商品分类';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kaadon_mall_cate`
--

LOCK TABLES `kaadon_mall_cate` WRITE;
/*!40000 ALTER TABLE `kaadon_mall_cate` DISABLE KEYS */;
INSERT INTO `kaadon_mall_cate` VALUES (9,'手机','http://admin.host/upload/20200514/98fc09b0c4ad4d793a6f04bef79a0edc.jpg',0,1,'',1589440437,1589440437,NULL);
/*!40000 ALTER TABLE `kaadon_mall_cate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kaadon_mall_goods`
--

DROP TABLE IF EXISTS `kaadon_mall_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kaadon_mall_goods` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cate_id` int(11) DEFAULT NULL COMMENT '分类ID',
  `title` varchar(20) NOT NULL COMMENT '商品名称',
  `logo` varchar(500) DEFAULT NULL COMMENT '商品logo',
  `images` text COMMENT '商品图片 以 | 做分割符号',
  `describe` text COMMENT '商品描述',
  `market_price` decimal(10,2) DEFAULT '0.00' COMMENT '市场价',
  `discount_price` decimal(10,2) DEFAULT '0.00' COMMENT '折扣价',
  `sales` int(11) DEFAULT '0' COMMENT '销量',
  `virtual_sales` int(11) DEFAULT '0' COMMENT '虚拟销量',
  `stock` int(11) DEFAULT '0' COMMENT '库存',
  `total_stock` int(11) DEFAULT '0' COMMENT '总库存',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '状态(1:禁用,2:启用)',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注说明',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(11) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `cate_id` (`cate_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商品列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kaadon_mall_goods`
--

LOCK TABLES `kaadon_mall_goods` WRITE;
/*!40000 ALTER TABLE `kaadon_mall_goods` DISABLE KEYS */;
INSERT INTO `kaadon_mall_goods` VALUES (8,10,'落地-风扇','http://admin.host/upload/20200514/a0f7fe9637abd219f7e93ceb2820df9b.jpg','http://admin.host/upload/20200514/95496713918290f6315ea3f87efa6bf2.jpg|http://admin.host/upload/20200514/ae29fa9cba4fc02defb7daed41cb2b13.jpg|http://admin.host/upload/20200514/f0a104d88ec7dc6fb42d2f87cbc71b76.jpg|http://admin.host/upload/20200514/3b88be4b1934690e5c1bd6b54b9ab5c8.jpg','<p>76654757</p>\n\n<p><img alt=\"\" src=\"http://admin.host/upload/20200515/198070421110fa01f2c2ac2f52481647.jpg\" style=\"height:689px; width:790px\" /></p>\n\n<p><img alt=\"\" src=\"http://admin.host/upload/20200515/a07a742c15a78781e79f8a3317006c1d.jpg\" style=\"height:877px; width:790px\" /></p>\n',599.00,368.00,0,594,0,0,675,1,'',1589454309,1589567016,NULL),(9,9,'电脑','http://admin.host/upload/20200514/bbf858d469dec2e12a89460110068d3d.jpg','http://admin.host/upload/20200514/f0a104d88ec7dc6fb42d2f87cbc71b76.jpg','<p>477</p>\n',0.00,0.00,0,0,115,320,0,1,'',1589465215,1589476345,NULL);
/*!40000 ALTER TABLE `kaadon_mall_goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kaadon_system_admin`
--

DROP TABLE IF EXISTS `kaadon_system_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kaadon_system_admin` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `auth_ids` varchar(255) DEFAULT NULL COMMENT '角色权限ID',
  `head_img` varchar(255) DEFAULT NULL COMMENT '头像',
  `username` varchar(50) NOT NULL DEFAULT '' COMMENT '用户登录名',
  `password` char(40) NOT NULL DEFAULT '' COMMENT '用户登录密码',
  `phone` varchar(16) DEFAULT NULL COMMENT '联系手机号',
  `remark` varchar(255) DEFAULT '' COMMENT '备注说明',
  `login_num` bigint(20) unsigned DEFAULT '0' COMMENT '登录次数',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态(0:禁用,1:启用,)',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(11) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE,
  KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kaadon_system_admin`
--

LOCK TABLES `kaadon_system_admin` WRITE;
/*!40000 ALTER TABLE `kaadon_system_admin` DISABLE KEYS */;
INSERT INTO `kaadon_system_admin` VALUES (1,NULL,'/static/admin/images/head.jpg','admin','a33b679d5581a8692988ec9f92ad2d6a2259eaa7',NULL,'',1,0,1,1620317786,1620317820,NULL);
/*!40000 ALTER TABLE `kaadon_system_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kaadon_system_auth`
--

DROP TABLE IF EXISTS `kaadon_system_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kaadon_system_auth` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(20) NOT NULL COMMENT '权限名称',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '状态(1:禁用,2:启用)',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注说明',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(11) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kaadon_system_auth`
--

LOCK TABLES `kaadon_system_auth` WRITE;
/*!40000 ALTER TABLE `kaadon_system_auth` DISABLE KEYS */;
INSERT INTO `kaadon_system_auth` VALUES (1,'管理员',1,1,'测试管理员',1588921753,1589614331,NULL),(6,'游客权限',0,1,'',1588227513,1589591751,1589591751);
/*!40000 ALTER TABLE `kaadon_system_auth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kaadon_system_auth_node`
--

DROP TABLE IF EXISTS `kaadon_system_auth_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kaadon_system_auth_node` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `auth_id` bigint(20) unsigned DEFAULT NULL COMMENT '角色ID',
  `node_id` bigint(20) DEFAULT NULL COMMENT '节点ID',
  PRIMARY KEY (`id`),
  KEY `index_system_auth_auth` (`auth_id`) USING BTREE,
  KEY `index_system_auth_node` (`node_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='角色与节点关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kaadon_system_auth_node`
--

LOCK TABLES `kaadon_system_auth_node` WRITE;
/*!40000 ALTER TABLE `kaadon_system_auth_node` DISABLE KEYS */;
INSERT INTO `kaadon_system_auth_node` VALUES (1,6,1),(2,6,2),(3,6,9),(4,6,12),(5,6,18),(6,6,19),(7,6,21),(8,6,22),(9,6,29),(10,6,30),(11,6,38),(12,6,39),(13,6,45),(14,6,46),(15,6,52),(16,6,53);
/*!40000 ALTER TABLE `kaadon_system_auth_node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kaadon_system_config`
--

DROP TABLE IF EXISTS `kaadon_system_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kaadon_system_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '变量名',
  `group` varchar(30) NOT NULL DEFAULT '' COMMENT '分组',
  `value` text COMMENT '变量值',
  `remark` varchar(100) DEFAULT '' COMMENT '备注信息',
  `sort` int(10) DEFAULT '0',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `group` (`group`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kaadon_system_config`
--

LOCK TABLES `kaadon_system_config` WRITE;
/*!40000 ALTER TABLE `kaadon_system_config` DISABLE KEYS */;
INSERT INTO `kaadon_system_config` VALUES (41,'alisms_access_key_id','sms','填你的','阿里大于公钥',0,NULL,NULL),(42,'alisms_access_key_secret','sms','填你的','阿里大鱼私钥',0,NULL,NULL),(55,'upload_type','upload','local','当前上传方式 （local,alioss,qnoss,txoss）',0,NULL,NULL),(56,'upload_allow_ext','upload','doc,gif,ico,icon,jpg,mp3,mp4,p12,pem,png,rar,jpeg','允许上传的文件类型',0,NULL,NULL),(57,'upload_allow_size','upload','1024000','允许上传的大小',0,NULL,NULL),(58,'upload_allow_mime','upload','image/gif,image/jpeg,video/x-msvideo,text/plain,image/png','允许上传的文件mime',0,NULL,NULL),(59,'upload_allow_type','upload','local,alioss,qnoss,txcos','可用的上传文件方式',0,NULL,NULL),(60,'alioss_access_key_id','upload','填你的','阿里云oss公钥',0,NULL,NULL),(61,'alioss_access_key_secret','upload','填你的','阿里云oss私钥',0,NULL,NULL),(62,'alioss_endpoint','upload','填你的','阿里云oss数据中心',0,NULL,NULL),(63,'alioss_bucket','upload','填你的','阿里云oss空间名称',0,NULL,NULL),(64,'alioss_domain','upload','填你的','阿里云oss访问域名',0,NULL,NULL),(65,'logo_title','site','EasyAdmin','LOGO标题',0,NULL,NULL),(66,'logo_image','site','/favicon.ico','logo图片',0,NULL,NULL),(68,'site_name','site','EasyAdmin后台系统','站点名称',0,NULL,NULL),(69,'site_ico','site','https://lxn-99php.oss-cn-shenzhen.aliyuncs.com/upload/20191111/7d32671f4c1d1b01b0b28f45205763f9.ico','浏览器图标',0,NULL,NULL),(70,'site_copyright','site','©版权所有 2014-2018 叁贰柒工作室66','版权信息',0,NULL,NULL),(71,'site_beian','site','粤ICP备16006642号-2','备案信息',0,NULL,NULL),(72,'site_version','site','2.0.0','版本信息',0,NULL,NULL),(75,'sms_type','sms','alisms','短信类型',0,NULL,NULL),(76,'miniapp_appid','wechat','填你的','小程序公钥',0,NULL,NULL),(77,'miniapp_appsecret','wechat','填你的','小程序私钥',0,NULL,NULL),(78,'web_appid','wechat','填你的','公众号公钥',0,NULL,NULL),(79,'web_appsecret','wechat','填你的','公众号私钥',0,NULL,NULL),(80,'txcos_secret_id','upload','填你的','腾讯云cos密钥',0,NULL,NULL),(81,'txcos_secret_key','upload','填你的','腾讯云cos私钥',0,NULL,NULL),(82,'txcos_region','upload','填你的','存储桶地域',0,NULL,NULL),(83,'tecos_bucket','upload','填你的','存储桶名称',0,NULL,NULL),(84,'qnoss_access_key','upload','填你的','访问密钥',0,NULL,NULL),(85,'qnoss_secret_key','upload','填你的','安全密钥',0,NULL,NULL),(86,'qnoss_bucket','upload','填你的','存储空间',0,NULL,NULL),(87,'qnoss_domain','upload','填你的','访问域名',0,NULL,NULL);
/*!40000 ALTER TABLE `kaadon_system_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kaadon_system_log_202105`
--

DROP TABLE IF EXISTS `kaadon_system_log_202105`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kaadon_system_log_202105` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) unsigned DEFAULT '0' COMMENT '管理员ID',
  `url` varchar(1500) NOT NULL DEFAULT '' COMMENT '操作页面',
  `method` varchar(50) NOT NULL COMMENT '请求方法',
  `title` varchar(100) DEFAULT '' COMMENT '日志标题',
  `content` text NOT NULL COMMENT '内容',
  `ip` varchar(50) NOT NULL DEFAULT '' COMMENT 'IP',
  `useragent` varchar(255) DEFAULT '' COMMENT 'User-Agent',
  `create_time` int(10) DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=641 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='后台操作日志表 - 202105';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kaadon_system_log_202105`
--

LOCK TABLES `kaadon_system_log_202105` WRITE;
/*!40000 ALTER TABLE `kaadon_system_log_202105` DISABLE KEYS */;
INSERT INTO `kaadon_system_log_202105` VALUES (630,NULL,'/admin/login/index.html','post','','{\"username\":\"admin\",\"password\":\"a378c24ff7a9091ae6f4b346ae59317ba1191423\",\"captcha\":\"8upw\",\"keep_login\":\"1\"}','36.44.36.197','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36',1620317809),(631,NULL,'/admin/login/index.html','post','','{\"username\":\"admin\",\"password\":\"a33b679d5581a8692988ec9f92ad2d6a2259eaa7\",\"captcha\":\"ncdr\",\"keep_login\":\"1\"}','36.44.36.197','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36',1620317820),(632,1,'/admin/system.node/refreshNode?force=1','post','','{\"force\":\"1\"}','36.44.36.197','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36',1620317830),(633,1,'/admin/system.node/clearNode','post','','[]','36.44.36.197','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36',1620317835),(634,1,'/admin/system.node/refreshNode?force=1','post','','{\"force\":\"1\"}','36.44.36.197','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36',1620317838),(635,1,'/admin/system.node/refreshNode?force=0','post','','{\"force\":\"0\"}','36.44.36.197','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36',1620317841),(636,1,'/admin/system.node/refreshNode?force=1','post','','{\"force\":\"1\"}','36.44.36.197','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36',1620319628),(637,1,'/admin/system.node/refreshNode?force=1','post','','{\"force\":\"1\"}','36.44.36.197','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',1620319636),(638,1,'/admin/system.node/refreshNode?force=1','post','','{\"force\":\"1\"}','36.44.36.197','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',1620319721),(639,1,'/admin/system.node/refreshNode?force=1','post','','{\"force\":\"1\"}','36.44.36.197','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',1620319761),(640,1,'/admin/system.node/refreshNode?force=1','post','','{\"force\":\"1\"}','36.44.36.197','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',1620321462);
/*!40000 ALTER TABLE `kaadon_system_log_202105` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kaadon_system_menu`
--

DROP TABLE IF EXISTS `kaadon_system_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kaadon_system_menu` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '父id',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '名称',
  `icon` varchar(100) NOT NULL DEFAULT '' COMMENT '菜单图标',
  `href` varchar(100) NOT NULL DEFAULT '' COMMENT '链接',
  `params` varchar(500) DEFAULT '' COMMENT '链接参数',
  `target` varchar(20) NOT NULL DEFAULT '_self' COMMENT '链接打开方式',
  `sort` int(11) DEFAULT '0' COMMENT '菜单排序',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态(0:禁用,1:启用)',
  `remark` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(11) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `title` (`title`),
  KEY `href` (`href`)
) ENGINE=InnoDB AUTO_INCREMENT=254 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统菜单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kaadon_system_menu`
--

LOCK TABLES `kaadon_system_menu` WRITE;
/*!40000 ALTER TABLE `kaadon_system_menu` DISABLE KEYS */;
INSERT INTO `kaadon_system_menu` VALUES (227,99999999,'后台首页','fa fa-home','index/welcome','','_self',0,1,NULL,NULL,1573120497,NULL),(228,0,'系统管理','fa fa-cog','','','_self',0,1,'',NULL,1588999529,NULL),(234,228,'菜单管理','fa fa-tree','system.menu/index','','_self',10,1,'',NULL,1588228555,NULL),(244,228,'管理员管理','fa fa-user','system.admin/index','','_self',12,1,'',1573185011,1588228573,NULL),(245,228,'角色管理','fa fa-bitbucket-square','system.auth/index','','_self',11,1,'',1573435877,1588228634,NULL),(246,228,'节点管理','fa fa-list','system.node/index','','_self',9,1,'',1573435919,1588228648,NULL),(247,228,'配置管理','fa fa-asterisk','system.config/index','','_self',8,1,'',1573457448,1588228566,NULL),(248,228,'上传管理','fa fa-arrow-up','system.uploadfile/index','','_self',0,1,'',1573542953,1588228043,NULL),(249,0,'商城管理','fa fa-list','','','_self',0,1,'',1589439884,1589439884,NULL),(250,249,'商品分类','fa fa-calendar-check-o','mall.cate/index','','_self',0,1,'',1589439910,1589439966,NULL),(251,249,'商品管理','fa fa-list','mall.goods/index','','_self',0,1,'',1589439931,1589439942,NULL),(252,228,'快捷入口','fa fa-list','system.quick/index','','_self',0,1,'',1589623683,1589623683,NULL),(253,228,'日志管理','fa fa-connectdevelop','system.log/index','','_self',0,1,'',1589623684,1589623684,NULL);
/*!40000 ALTER TABLE `kaadon_system_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kaadon_system_node`
--

DROP TABLE IF EXISTS `kaadon_system_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kaadon_system_node` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `node` varchar(100) DEFAULT NULL COMMENT '节点代码',
  `title` varchar(500) DEFAULT NULL COMMENT '节点标题',
  `type` tinyint(1) DEFAULT '3' COMMENT '节点类型（1：控制器，2：节点）',
  `is_auth` tinyint(1) unsigned DEFAULT '1' COMMENT '是否启动RBAC权限控制',
  `create_time` int(10) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `node` (`node`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统节点表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kaadon_system_node`
--

LOCK TABLES `kaadon_system_node` WRITE;
/*!40000 ALTER TABLE `kaadon_system_node` DISABLE KEYS */;
INSERT INTO `kaadon_system_node` VALUES (1,'system.admin','管理员管理',1,1,1589580432,1589580432),(2,'system.admin/index','列表',2,1,1589580432,1589580432),(3,'system.admin/add','添加',2,1,1589580432,1589580432),(4,'system.admin/edit','编辑',2,1,1589580432,1589580432),(5,'system.admin/password','编辑',2,1,1589580432,1589580432),(6,'system.admin/delete','删除',2,1,1589580432,1589580432),(7,'system.admin/modify','属性修改',2,1,1589580432,1589580432),(8,'system.admin/export','导出',2,1,1589580432,1589580432),(9,'system.auth','角色权限管理',1,1,1589580432,1589580432),(10,'system.auth/authorize','授权',2,1,1589580432,1589580432),(11,'system.auth/saveAuthorize','授权保存',2,1,1589580432,1589580432),(12,'system.auth/index','列表',2,1,1589580432,1589580432),(13,'system.auth/add','添加',2,1,1589580432,1589580432),(14,'system.auth/edit','编辑',2,1,1589580432,1589580432),(15,'system.auth/delete','删除',2,1,1589580432,1589580432),(16,'system.auth/export','导出',2,1,1589580432,1589580432),(17,'system.auth/modify','属性修改',2,1,1589580432,1589580432),(18,'system.config','系统配置管理',1,1,1589580432,1589580432),(19,'system.config/index','列表',2,1,1589580432,1589580432),(20,'system.config/save','保存',2,1,1589580432,1589580432),(21,'system.menu','菜单管理',1,1,1589580432,1589580432),(22,'system.menu/index','列表',2,1,1589580432,1589580432),(23,'system.menu/add','添加',2,1,1589580432,1589580432),(24,'system.menu/edit','编辑',2,1,1589580432,1589580432),(25,'system.menu/delete','删除',2,1,1589580432,1589580432),(26,'system.menu/modify','属性修改',2,1,1589580432,1589580432),(27,'system.menu/getMenuTips','添加菜单提示',2,1,1589580432,1589580432),(28,'system.menu/export','导出',2,1,1589580432,1589580432),(29,'system.node','系统节点管理',1,1,1589580432,1589580432),(30,'system.node/index','列表',2,1,1589580432,1589580432),(31,'system.node/refreshNode','系统节点更新',2,1,1589580432,1589580432),(32,'system.node/clearNode','清除失效节点',2,1,1589580432,1589580432),(33,'system.node/add','添加',2,1,1589580432,1589580432),(34,'system.node/edit','编辑',2,1,1589580432,1589580432),(35,'system.node/delete','删除',2,1,1589580432,1589580432),(36,'system.node/export','导出',2,1,1589580432,1589580432),(37,'system.node/modify','属性修改',2,1,1589580432,1589580432),(38,'system.uploadfile','上传文件管理',1,1,1589580432,1589580432),(39,'system.uploadfile/index','列表',2,1,1589580432,1589580432),(40,'system.uploadfile/add','添加',2,1,1589580432,1589580432),(41,'system.uploadfile/edit','编辑',2,1,1589580432,1589580432),(42,'system.uploadfile/delete','删除',2,1,1589580432,1589580432),(43,'system.uploadfile/export','导出',2,1,1589580432,1589580432),(44,'system.uploadfile/modify','属性修改',2,1,1589580432,1589580432),(45,'mall.cate','商品分类管理',1,1,1589580432,1589580432),(46,'mall.cate/index','列表',2,1,1589580432,1589580432),(47,'mall.cate/add','添加',2,1,1589580432,1589580432),(48,'mall.cate/edit','编辑',2,1,1589580432,1589580432),(49,'mall.cate/delete','删除',2,1,1589580432,1589580432),(50,'mall.cate/export','导出',2,1,1589580432,1589580432),(51,'mall.cate/modify','属性修改',2,1,1589580432,1589580432),(52,'mall.goods','商城商品管理',1,1,1589580432,1589580432),(53,'mall.goods/index','列表',2,1,1589580432,1589580432),(54,'mall.goods/stock','入库',2,1,1589580432,1589580432),(55,'mall.goods/add','添加',2,1,1589580432,1589580432),(56,'mall.goods/edit','编辑',2,1,1589580432,1589580432),(57,'mall.goods/delete','删除',2,1,1589580432,1589580432),(58,'mall.goods/export','导出',2,1,1589580432,1589580432),(59,'mall.goods/modify','属性修改',2,1,1589580432,1589580432),(60,'system.quick','快捷入口管理',1,1,1589623188,1589623188),(61,'system.quick/index','列表',2,1,1589623188,1589623188),(62,'system.quick/add','添加',2,1,1589623188,1589623188),(63,'system.quick/edit','编辑',2,1,1589623188,1589623188),(64,'system.quick/delete','删除',2,1,1589623188,1589623188),(65,'system.quick/export','导出',2,1,1589623188,1589623188),(66,'system.quick/modify','属性修改',2,1,1589623188,1589623188),(67,'system.log','操作日志管理',1,1,1589623188,1589623188),(68,'system.log/index','列表',2,1,1589623188,1589623188);
/*!40000 ALTER TABLE `kaadon_system_node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kaadon_system_quick`
--

DROP TABLE IF EXISTS `kaadon_system_quick`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kaadon_system_quick` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(20) NOT NULL COMMENT '快捷入口名称',
  `icon` varchar(100) DEFAULT NULL COMMENT '图标',
  `href` varchar(255) DEFAULT NULL COMMENT '快捷链接',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '状态(1:禁用,2:启用)',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注说明',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(11) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统快捷入口表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kaadon_system_quick`
--

LOCK TABLES `kaadon_system_quick` WRITE;
/*!40000 ALTER TABLE `kaadon_system_quick` DISABLE KEYS */;
INSERT INTO `kaadon_system_quick` VALUES (1,'管理员管理','fa fa-user','system.admin/index',0,1,'',1589624097,1589624792,NULL),(2,'角色管理','fa fa-bitbucket-square','system.auth/index',0,1,'',1589624772,1589624781,NULL),(3,'菜单管理','fa fa-tree','system.menu/index',0,1,NULL,1589624097,1589624792,NULL),(6,'节点管理','fa fa-list','system.node/index',0,1,NULL,1589624772,1589624781,NULL),(7,'配置管理','fa fa-asterisk','system.config/index',0,1,NULL,1589624097,1589624792,NULL),(8,'上传管理','fa fa-arrow-up','system.uploadfile/index',0,1,NULL,1589624772,1589624781,NULL),(10,'商品分类','fa fa-calendar-check-o','mall.cate/index',0,1,NULL,1589624097,1589624792,NULL),(11,'商品管理','fa fa-list','mall.goods/index',0,1,NULL,1589624772,1589624781,NULL);
/*!40000 ALTER TABLE `kaadon_system_quick` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kaadon_system_uploadfile`
--

DROP TABLE IF EXISTS `kaadon_system_uploadfile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kaadon_system_uploadfile` (
  `id` int(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `upload_type` varchar(20) NOT NULL DEFAULT 'local' COMMENT '存储位置',
  `original_name` varchar(255) DEFAULT NULL COMMENT '文件原名',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '物理路径',
  `image_width` varchar(30) NOT NULL DEFAULT '' COMMENT '宽度',
  `image_height` varchar(30) NOT NULL DEFAULT '' COMMENT '高度',
  `image_type` varchar(30) NOT NULL DEFAULT '' COMMENT '图片类型',
  `image_frames` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图片帧数',
  `mime_type` varchar(100) NOT NULL DEFAULT '' COMMENT 'mime类型',
  `file_size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `file_ext` varchar(100) DEFAULT NULL,
  `sha1` varchar(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `create_time` int(10) DEFAULT NULL COMMENT '创建日期',
  `update_time` int(10) DEFAULT NULL COMMENT '更新时间',
  `upload_time` int(10) DEFAULT NULL COMMENT '上传时间',
  PRIMARY KEY (`id`),
  KEY `upload_type` (`upload_type`),
  KEY `original_name` (`original_name`)
) ENGINE=InnoDB AUTO_INCREMENT=316 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='上传文件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kaadon_system_uploadfile`
--

LOCK TABLES `kaadon_system_uploadfile` WRITE;
/*!40000 ALTER TABLE `kaadon_system_uploadfile` DISABLE KEYS */;
INSERT INTO `kaadon_system_uploadfile` VALUES (286,'alioss','image/jpeg','https://lxn-99php.oss-cn-shenzhen.aliyuncs.com/upload/20191111/0a6de1ac058ee134301501899b84ecb1.jpg','','','',0,'image/jpeg',0,'jpg','',NULL,NULL,NULL),(287,'alioss','image/jpeg','https://lxn-99php.oss-cn-shenzhen.aliyuncs.com/upload/20191111/46d7384f04a3bed331715e86a4095d15.jpg','','','',0,'image/jpeg',0,'jpg','',NULL,NULL,NULL),(288,'alioss','image/x-icon','https://lxn-99php.oss-cn-shenzhen.aliyuncs.com/upload/20191111/7d32671f4c1d1b01b0b28f45205763f9.ico','','','',0,'image/x-icon',0,'ico','',NULL,NULL,NULL),(289,'alioss','image/jpeg','https://lxn-99php.oss-cn-shenzhen.aliyuncs.com/upload/20191111/28cefa547f573a951bcdbbeb1396b06f.jpg','','','',0,'image/jpeg',0,'jpg','',NULL,NULL,NULL),(290,'alioss','image/jpeg','https://lxn-99php.oss-cn-shenzhen.aliyuncs.com/upload/20191111/2c412adf1b30c8be3a913e603c7b6e4a.jpg','','','',0,'image/jpeg',0,'jpg','',NULL,NULL,NULL),(291,'alioss','timg (1).jpg','http://easyadmin.oss-cn-shenzhen.aliyuncs.com/upload/20191113/ff793ced447febfa9ea2d86f9f88fa8e.jpg','','','',0,'image/jpeg',0,'jpg','',1573612437,NULL,NULL),(296,'txcos','22243.jpg','https://easyadmin-1251997243.cos.ap-guangzhou.myqcloud.com/upload/20191114/2381eaf81208ac188fa994b6f2579953.jpg','','','',0,'image/jpeg',0,'jpg','',1573712153,NULL,NULL),(297,'local','timg.jpg','http://admin.host/upload/20200423/5055a273cf8e3f393d699d622b74f247.jpg','','','',0,'image/jpeg',0,'jpg','',1587614155,NULL,NULL),(298,'local','timg.jpg','http://admin.host/upload/20200423/243f4e59f1b929951ef79c5f8be7468a.jpg','','','',0,'image/jpeg',0,'jpg','',1587614269,NULL,NULL),(299,'local','head.jpg','http://admin.host/upload/20200512/a5ce9883379727324f5686ef61205ce2.jpg','','','',0,'image/jpeg',0,'jpg','',1589255649,NULL,NULL),(300,'local','896e5b87c9ca70e4.jpg','http://admin.host/upload/20200514/577c65f101639f53dbbc9e7aa346f81c.jpg','','','',0,'image/jpeg',0,'jpg','',1589427798,NULL,NULL),(301,'local','896e5b87c9ca70e4.jpg','http://admin.host/upload/20200514/98fc09b0c4ad4d793a6f04bef79a0edc.jpg','','','',0,'image/jpeg',0,'jpg','',1589427840,NULL,NULL),(302,'local','18811e7611c8f292.jpg','http://admin.host/upload/20200514/e1c6c9ef6a4b98b8f7d95a1a0191a2df.jpg','','','',0,'image/jpeg',0,'jpg','',1589438645,NULL,NULL);
/*!40000 ALTER TABLE `kaadon_system_uploadfile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'codemiracle'
--

--
-- Dumping routines for database 'codemiracle'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-09 20:09:47
