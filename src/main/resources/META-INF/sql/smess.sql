/*
SQLyog Ultimate v11.24 (32 bit)
MySQL - 5.6.18-enterprise-commercial-advanced : Database - smess
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`smess` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `smess`;

/*Table structure for table `cp_goods` */

DROP TABLE IF EXISTS `cp_goods`;

CREATE TABLE `cp_goods` (
  `GOODS_ID` varchar(100) NOT NULL,
  `TITLE` varchar(255) DEFAULT NULL COMMENT '商品标题',
  `BIANMA` varchar(30) DEFAULT NULL COMMENT '商品编码',
  `SPTYPE_ID` varchar(100) DEFAULT NULL COMMENT '商品类别',
  `SPBRAND_ID` varchar(100) DEFAULT NULL COMMENT '品牌',
  `SPUNIT_ID` varchar(100) DEFAULT NULL COMMENT '计量单位',
  `DESCRIPTION` varchar(5000) DEFAULT NULL COMMENT '商品描述',
  `SHORTDESC` varchar(500) DEFAULT NULL COMMENT '简述',
  `USERNAME` varchar(100) DEFAULT NULL COMMENT '用户名',
  `ZCOUNT` int(11) DEFAULT NULL,
  PRIMARY KEY (`GOODS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cp_goods` */

insert  into `cp_goods`(`GOODS_ID`,`TITLE`,`BIANMA`,`SPTYPE_ID`,`SPBRAND_ID`,`SPUNIT_ID`,`DESCRIPTION`,`SHORTDESC`,`USERNAME`,`ZCOUNT`) values ('284e2238d7fc4bd481c6324fc4c160cf','蒙发护发膏','FHD22001','80c376c418014643aa1a77e2462ce704','a129234a7c584cedbc90f2917f3c9b9c','87e8777c1b514085a09e0f3438151b24','<p>蒙发护发膏</p>','蒙发护发膏','a1',100),('adfd62b9bcde4474b826f92ce64f518d','蒙发护洗发水','FHD22002','80c376c418014643aa1a77e2462ce704','a129234a7c584cedbc90f2917f3c9b9c','87e8777c1b514085a09e0f3438151b24','<p>蒙发护洗发水</p>','蒙发护洗发水','a1',88),('b27e2ba8eab74c90a1418ac341d63241','洗发水','225522','8e5ed83e9fec45fb8ac7ab18f65a184d','bb86304a219b4e2b8e99e5fb0a6f406d','cbee034f4c9c4c47b097ee4ee559a67d','<p>洗发水</p>','洗发水','a2',0),('f0eb6f8cbebc453da88a8c2e1625c9f3','潘婷护法乳','FHD22003','95a3946f4be247ecab2979ae90833a76','bde3e3e047804bc9a3e8860021209e72','abbb90a0b5624157a0593e2326d92720','<p>潘婷护法乳</p>','潘婷护法乳','a1',50);

/*Table structure for table `cp_spbrand` */

DROP TABLE IF EXISTS `cp_spbrand`;

CREATE TABLE `cp_spbrand` (
  `SPBRAND_ID` varchar(100) NOT NULL,
  `NAME` varchar(50) DEFAULT NULL COMMENT '品牌管理',
  `BZ` varchar(1000) DEFAULT NULL COMMENT '备注',
  `USERNAME` varchar(100) DEFAULT NULL COMMENT '用户名',
  PRIMARY KEY (`SPBRAND_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cp_spbrand` */

insert  into `cp_spbrand`(`SPBRAND_ID`,`NAME`,`BZ`,`USERNAME`) values ('a129234a7c584cedbc90f2917f3c9b9c','蒙发','蒙发','a1'),('bb86304a219b4e2b8e99e5fb0a6f406d','潘婷','潘婷','a2'),('bde3e3e047804bc9a3e8860021209e72','潘婷','潘婷','a1');

/*Table structure for table `cp_sptype` */

DROP TABLE IF EXISTS `cp_sptype`;

CREATE TABLE `cp_sptype` (
  `SPTYPE_ID` varchar(100) NOT NULL,
  `NAME` varchar(50) DEFAULT NULL COMMENT '商品类别',
  `BZ` varchar(1000) DEFAULT NULL COMMENT '备注',
  `USERNAME` varchar(100) DEFAULT NULL COMMENT '用户名',
  PRIMARY KEY (`SPTYPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cp_sptype` */

insert  into `cp_sptype`(`SPTYPE_ID`,`NAME`,`BZ`,`USERNAME`) values ('80c376c418014643aa1a77e2462ce704','养发系类','养发系类','a1'),('8e5ed83e9fec45fb8ac7ab18f65a184d','洗发','洗发','a2'),('95a3946f4be247ecab2979ae90833a76','护法系列','护法系列','a1');

/*Table structure for table `cp_spunit` */

DROP TABLE IF EXISTS `cp_spunit`;

CREATE TABLE `cp_spunit` (
  `SPUNIT_ID` varchar(100) NOT NULL,
  `NAME` varchar(50) DEFAULT NULL COMMENT '计量单位',
  `BZ` varchar(1000) DEFAULT NULL COMMENT '备注',
  `USERNAME` varchar(100) DEFAULT NULL COMMENT '用户名',
  PRIMARY KEY (`SPUNIT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cp_spunit` */

insert  into `cp_spunit`(`SPUNIT_ID`,`NAME`,`BZ`,`USERNAME`) values ('87e8777c1b514085a09e0f3438151b24','盒','盒','a1'),('abbb90a0b5624157a0593e2326d92720','瓶','瓶','a1'),('cbee034f4c9c4c47b097ee4ee559a67d','瓶','瓶','a2');

/*Table structure for table `db_fhdb` */

DROP TABLE IF EXISTS `db_fhdb`;

CREATE TABLE `db_fhdb` (
  `FHDB_ID` varchar(100) NOT NULL,
  `USERNAME` varchar(50) DEFAULT NULL COMMENT '操作用户',
  `BACKUP_TIME` varchar(32) DEFAULT NULL COMMENT '备份时间',
  `TABLENAME` varchar(50) DEFAULT NULL COMMENT '表名',
  `SQLPATH` varchar(300) DEFAULT NULL COMMENT '存储位置',
  `TYPE` int(1) NOT NULL COMMENT '类型',
  `DBSIZE` varchar(10) DEFAULT NULL COMMENT '文件大小',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`FHDB_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `db_fhdb` */

/*Table structure for table `db_timingbackup` */

DROP TABLE IF EXISTS `db_timingbackup`;

CREATE TABLE `db_timingbackup` (
  `TIMINGBACKUP_ID` varchar(100) NOT NULL,
  `JOBNAME` varchar(50) DEFAULT NULL COMMENT '任务名称',
  `CREATE_TIME` varchar(32) DEFAULT NULL COMMENT '创建时间',
  `TABLENAME` varchar(50) DEFAULT NULL COMMENT '表名',
  `STATUS` int(1) NOT NULL COMMENT '类型',
  `FHTIME` varchar(30) DEFAULT NULL COMMENT '时间规则',
  `TIMEEXPLAIN` varchar(100) DEFAULT NULL COMMENT '规则说明',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`TIMINGBACKUP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `db_timingbackup` */

/*Table structure for table `erp_customer` */

DROP TABLE IF EXISTS `erp_customer`;

CREATE TABLE `erp_customer` (
  `CUSTOMER_ID` varchar(100) NOT NULL,
  `NAME` varchar(100) DEFAULT NULL COMMENT '姓名',
  `AGE` varchar(10) DEFAULT NULL COMMENT '年龄',
  `PHONE` varchar(100) NOT NULL COMMENT '手机',
  `ADDRESS` varchar(1000) DEFAULT NULL COMMENT '地址',
  `QQ` int(20) NOT NULL COMMENT 'QQ',
  `WEIXIN` varchar(100) DEFAULT NULL COMMENT '微信',
  `CTIME` varchar(32) DEFAULT NULL COMMENT '建档时间',
  `MONEY` int(11) NOT NULL COMMENT '消费金额',
  `LEVEL` varchar(100) DEFAULT NULL COMMENT '级别',
  `REMARKS1` varchar(1000) DEFAULT NULL COMMENT '备注1',
  `REMARKS2` varchar(1000) DEFAULT NULL COMMENT '备注2',
  `USERNAME` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`CUSTOMER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `erp_customer` */

insert  into `erp_customer`(`CUSTOMER_ID`,`NAME`,`AGE`,`PHONE`,`ADDRESS`,`QQ`,`WEIXIN`,`CTIME`,`MONEY`,`LEVEL`,`REMARKS1`,`REMARKS2`,`USERNAME`) values ('884a84021c2d45f4b09872f226bcaaa5','葛优','55','13666666666','北京',555555,'555555','2017-03-04 23:51:20',5588,'1a1b2fbf64864e78854fe04aee748acc','脱发比较严重','说','a2'),('a16795fc5eb74d46b155791d14715a8a','张三','32','13233333333','历城区',1235689,'1235689','2017-03-04 15:11:43',500,'56d7c5a4397c42b5bc3989d6dd46eec3','脱发严重','111','a1'),('efb91a8c84dd42a09442ae6b56067b3d','王五','55','13555555555','济南',313596790,'313596790','2017-03-05 20:41:01',500,'50141667fca64083819a37453fd27e49','中等脱发','s','a1');

/*Table structure for table `erp_customerimg` */

DROP TABLE IF EXISTS `erp_customerimg`;

CREATE TABLE `erp_customerimg` (
  `CUSTOMERIMG_ID` varchar(100) NOT NULL,
  `CDESCRIPTION` varchar(3000) DEFAULT NULL COMMENT '描述',
  `CTIME` varchar(32) DEFAULT NULL COMMENT '记录日期',
  `CUSTOMER_ID` varchar(100) DEFAULT NULL COMMENT '商户ID',
  PRIMARY KEY (`CUSTOMERIMG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `erp_customerimg` */

insert  into `erp_customerimg`(`CUSTOMERIMG_ID`,`CDESCRIPTION`,`CTIME`,`CUSTOMER_ID`) values ('ff49180755f941cfb00b981cd0d4b9eb','<p>ddd<img src=\"/smess/plugins/ueditor/jsp/upload1/20170304/94331488563343291.jpg\" title=\"n.jpg\"/></p>','2017-03-04 01:49:05','a277421ef2524e9ab5a4492a8a7a4ac2');

/*Table structure for table `erp_intoku` */

DROP TABLE IF EXISTS `erp_intoku`;

CREATE TABLE `erp_intoku` (
  `INTOKU_ID` varchar(100) NOT NULL,
  `GOODS_ID` varchar(100) DEFAULT NULL COMMENT '商品ID',
  `INCOUNT` int(11) NOT NULL COMMENT '数量',
  `PRICE` double(11,2) DEFAULT NULL COMMENT '单价',
  `ZPRICE` double(11,2) DEFAULT NULL COMMENT '总价',
  `INTIME` varchar(32) DEFAULT NULL COMMENT '入库时间',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  `USERNAME` varchar(100) DEFAULT NULL COMMENT '用户名',
  `GOODS_NAME` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`INTOKU_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `erp_intoku` */

insert  into `erp_intoku`(`INTOKU_ID`,`GOODS_ID`,`INCOUNT`,`PRICE`,`ZPRICE`,`INTIME`,`BZ`,`USERNAME`,`GOODS_NAME`) values ('04796e6e7c954d12b6654de6605e7a07','f0eb6f8cbebc453da88a8c2e1625c9f3',100,88.00,8800.00,'2017-11-09 11:09:39','进货','a1','潘婷护法乳'),('d1aea70951114eb3950a6066dc4ced3e','adfd62b9bcde4474b826f92ce64f518d',88,66.00,5808.00,'2017-11-09 11:12:28','进货','a1','蒙发护洗发水'),('f4c806a3461a4b8b9a152420176c1c2d','284e2238d7fc4bd481c6324fc4c160cf',100,86.00,8600.00,'2017-11-09 11:13:07','进货','a1','蒙发护发膏');

/*Table structure for table `erp_level` */

DROP TABLE IF EXISTS `erp_level`;

CREATE TABLE `erp_level` (
  `LEVEL_ID` varchar(100) NOT NULL,
  `TITLE` varchar(100) DEFAULT NULL COMMENT '级别',
  `USERNAME` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`LEVEL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `erp_level` */

insert  into `erp_level`(`LEVEL_ID`,`TITLE`,`USERNAME`) values ('1a1b2fbf64864e78854fe04aee748acc','大客户','a2'),('50141667fca64083819a37453fd27e49','重要客户','a1'),('56d7c5a4397c42b5bc3989d6dd46eec3','潜在客户','a1'),('bcdbb5af953f4472915a2644d42f2ce9','流动客户','a1');

/*Table structure for table `erp_outku` */

DROP TABLE IF EXISTS `erp_outku`;

CREATE TABLE `erp_outku` (
  `OUTKU_ID` varchar(100) NOT NULL,
  `GOODS_ID` varchar(100) DEFAULT NULL COMMENT '商品ID',
  `INCOUNT` int(11) NOT NULL COMMENT '数量',
  `PRICE` double(11,2) DEFAULT NULL COMMENT '单价',
  `ZPRICE` double(11,2) DEFAULT NULL COMMENT '总价',
  `OUTTIME` varchar(32) DEFAULT NULL COMMENT '出库时间',
  `GOODS_NAME` varchar(255) DEFAULT NULL COMMENT '商品名称',
  `USERNAME` varchar(100) DEFAULT NULL COMMENT '用户名',
  `BZ` text,
  `CUSTOMER_ID` varchar(100) DEFAULT NULL,
  `CUSTOMER_NAME` varchar(100) DEFAULT NULL,
  `ORDER_NUMBER` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`OUTKU_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `erp_outku` */

insert  into `erp_outku`(`OUTKU_ID`,`GOODS_ID`,`INCOUNT`,`PRICE`,`ZPRICE`,`OUTTIME`,`GOODS_NAME`,`USERNAME`,`BZ`,`CUSTOMER_ID`,`CUSTOMER_NAME`,`ORDER_NUMBER`) values ('15a0cb7cbee145fea293963cc7e0255f','f0eb6f8cbebc453da88a8c2e1625c9f3',50,500.00,25000.00,'2017-11-09 11:13:46','潘婷护法乳','a1','500','efb91a8c84dd42a09442ae6b56067b3d','王五','D20171109111346390246');

/*Table structure for table `erp_remarks` */

DROP TABLE IF EXISTS `erp_remarks`;

CREATE TABLE `erp_remarks` (
  `REMARKS_ID` varchar(100) NOT NULL,
  `REMARKS` varchar(1000) DEFAULT NULL COMMENT '备注',
  `USERNAME` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`REMARKS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `erp_remarks` */

insert  into `erp_remarks`(`REMARKS_ID`,`REMARKS`,`USERNAME`) values ('295926172a884b28ad9adf454137d6eb','中等脱发','a1'),('b74fa2d77faf4aaca1f0ba64927e6335','轻微脱发','a1'),('cb070bac61cf46c3a1e2790a8483c1e1','脱发严重','a1'),('fa51fc07acb1405e9e6e3c106095d7a6','脱发比较严重','a2');

/*Table structure for table `sys_dictionaries` */

DROP TABLE IF EXISTS `sys_dictionaries`;

CREATE TABLE `sys_dictionaries` (
  `DICTIONARIES_ID` varchar(100) NOT NULL,
  `NAME` varchar(30) DEFAULT NULL COMMENT '名称',
  `NAME_EN` varchar(50) DEFAULT NULL COMMENT '英文',
  `BIANMA` varchar(50) DEFAULT NULL COMMENT '编码',
  `ORDER_BY` int(11) NOT NULL COMMENT '排序',
  `PARENT_ID` varchar(100) DEFAULT NULL COMMENT '上级ID',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  `TBSNAME` varchar(100) DEFAULT NULL COMMENT '排查表',
  PRIMARY KEY (`DICTIONARIES_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_dictionaries` */

insert  into `sys_dictionaries`(`DICTIONARIES_ID`,`NAME`,`NAME_EN`,`BIANMA`,`ORDER_BY`,`PARENT_ID`,`BZ`,`TBSNAME`) values ('0193ffbfae1e49e0b7810546cada316a','济南','JiNan','0030301',1,'10f46a521ea0471f8d71ee75ac3b5f3a','济南',''),('096e4ec8986149d994b09e604504e38d','黄浦区','huangpu','0030201',1,'f1ea30ddef1340609c35c88fb2919bee','黄埔',''),('10f46a521ea0471f8d71ee75ac3b5f3a','山东','ShanDong','00303',3,'be4a8c5182c744d28282a5345783a77f','山东省',''),('12a62a3e5bed44bba0412b7e6b733c93','北京','beijing','00301',1,'be4a8c5182c744d28282a5345783a77f','北京',''),('507fa87a49104c7c8cdb52fdb297da12','宣武区','xuanwuqu','0030101',1,'12a62a3e5bed44bba0412b7e6b733c93','宣武区',''),('66f1ff79b13947da98525aff7380ef50','高新区','gaoxinqu','003030101',1,'0193ffbfae1e49e0b7810546cada316a','高新区',''),('8994f5995f474e2dba6cfbcdfe5ea07a','语文','yuwen','00201',1,'fce20eb06d7b4b4d8f200eda623f725c','语文',''),('8ea7c44af25f48b993a14f791c8d689f','分类','fenlei','001',1,'0','分类',''),('be4a8c5182c744d28282a5345783a77f','地区','diqu','003',3,'0','地区',''),('d428594b0494476aa7338d9061e23ae3','红色','red','00101',1,'8ea7c44af25f48b993a14f791c8d689f','红色',''),('de9afadfbed0428fa343704d6acce2c4','绿色','green','00102',2,'8ea7c44af25f48b993a14f791c8d689f','绿色',''),('f1ea30ddef1340609c35c88fb2919bee','上海','shanghai','00302',2,'be4a8c5182c744d28282a5345783a77f','上海',''),('fce20eb06d7b4b4d8f200eda623f725c','课程','kecheng','002',2,'0','课程','');

/*Table structure for table `sys_fhbutton` */

DROP TABLE IF EXISTS `sys_fhbutton`;

CREATE TABLE `sys_fhbutton` (
  `FHBUTTON_ID` varchar(100) NOT NULL,
  `NAME` varchar(30) DEFAULT NULL COMMENT '名称',
  `QX_NAME` varchar(50) DEFAULT NULL COMMENT '权限标识',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`FHBUTTON_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_fhbutton` */

insert  into `sys_fhbutton`(`FHBUTTON_ID`,`NAME`,`QX_NAME`,`BZ`) values ('3542adfbda73410c976e185ffe50ad06','导出EXCEL','toExcel','导出EXCEL'),('46992ea280ba4b72b29dedb0d4bc0106','发邮件','email','发送电子邮件'),('4efa162fce8340f0bd2dcd3b11d327ec','导入EXCEL','FromExcel','导入EXCEL到系统用户'),('cc51b694d5344d28a9aa13c84b7166cd','发短信','sms','发送短信'),('da7fd386de0b49ce809984f5919022b8','站内信','FHSMS','发送站内信');

/*Table structure for table `sys_fhlog` */

DROP TABLE IF EXISTS `sys_fhlog`;

CREATE TABLE `sys_fhlog` (
  `FHLOG_ID` varchar(100) NOT NULL,
  `USERNAME` varchar(100) DEFAULT NULL COMMENT '用户名',
  `CZTIME` varchar(32) DEFAULT NULL COMMENT '操作时间',
  `CONTENT` varchar(255) DEFAULT NULL COMMENT '事件',
  PRIMARY KEY (`FHLOG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_fhlog` */

insert  into `sys_fhlog`(`FHLOG_ID`,`USERNAME`,`CZTIME`,`CONTENT`) values ('3c1e924c9d114c30b79e7059429a9dd3','a1','2018-01-04 00:18:18','登录系统'),('457ae5ab583240baa324edf7f5d89baf','a2','2018-01-04 00:17:53','登录系统'),('590f2f0613ab4c7cad505d208e991a07','a2','2018-01-04 00:18:11','退出'),('5be0dc7885e342f8a9c26eba14cda519','a0','2018-01-03 22:09:40','登录系统'),('ae48c7dc29e440fc882d9a37a65e7e98','a1','2018-01-03 22:10:01','登录系统'),('b12772751ce448219d2e1a0e75f40a64','a1','2018-01-04 00:08:10','登录系统'),('c912031782fb413ab672536c9205b162','a1','2018-01-04 00:12:24','登录系统'),('d4c7259d974a4c9f816b3d67db837fe5','a1','2018-01-04 00:17:46','退出'),('dd1ca3e73318430398f3a3c0f61ede2d','admin','2018-01-03 22:08:35','登录系统');

/*Table structure for table `sys_fhsms` */

DROP TABLE IF EXISTS `sys_fhsms`;

CREATE TABLE `sys_fhsms` (
  `FHSMS_ID` varchar(100) NOT NULL,
  `CONTENT` varchar(1000) DEFAULT NULL COMMENT '内容',
  `TYPE` varchar(5) DEFAULT NULL COMMENT '类型',
  `TO_USERNAME` varchar(255) DEFAULT NULL COMMENT '收信人',
  `FROM_USERNAME` varchar(255) DEFAULT NULL COMMENT '发信人',
  `SEND_TIME` varchar(100) DEFAULT NULL COMMENT '发信时间',
  `STATUS` varchar(5) DEFAULT NULL COMMENT '状态',
  `SANME_ID` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`FHSMS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_fhsms` */

insert  into `sys_fhsms`(`FHSMS_ID`,`CONTENT`,`TYPE`,`TO_USERNAME`,`FROM_USERNAME`,`SEND_TIME`,`STATUS`,`SANME_ID`) values ('05879f5868824f35932ee9f2062adc03','你好','2','admin','san','2016-01-25 14:05:31','1','b311e893228f42d5a05dbe16917fd16f'),('2635dd035c6f4bb5a091abdd784bd899','你好','2','san','admin','2016-01-25 14:05:02','1','1b7637306683460f89174c2b025862b5'),('3bbc59aec89c45a989f32a8d674061a2','1','2','a1','a2','2017-10-28 01:52:50','2','95dc9576616e46ef82070c0f575a3619'),('52378ccd4e2d4fe08994d1652af87c68','你好','1','admin','san','2016-01-25 16:26:44','1','920b20dafdfb4c09b560884eb277c51d'),('59e630a10b734e008b24b9b13a3e873f','eee','1','a1','eee','2017-10-28 02:03:24','2','49e9a3b171784675a94baf0c0a295c7c'),('77ed13f9c49a4c4bb460c41b8580dd36','gggg','2','admin','san','2016-01-24 21:22:43','2','dd9ee339576e48c5b046b94fa1901d00'),('98a6869f942042a1a037d9d9f01cb50f','你好','1','admin','san','2016-01-25 14:05:02','1','1b7637306683460f89174c2b025862b5'),('9e00295529014b6e8a27019cbccb3da1','柔柔弱弱','1','admin','san','2016-01-24 21:22:57','1','a29603d613ea4e54b5678033c1bf70a6'),('d3aedeb430f640359bff86cd657a8f59','你好','1','admin','san','2016-01-24 21:22:12','1','f022fbdce3d845aba927edb698beb90b'),('e5376b1bd54b489cb7f2203632bd74ec','管理员好','2','admin','san','2016-01-25 14:06:13','2','b347b2034faf43c79b54be4627f3bd2b'),('e5cf70d885e74382b1d5fad3d93f1424','1','1','a2','a1','2017-10-28 01:52:50','2','95dc9576616e46ef82070c0f575a3619'),('e613ac0fcc454f32895a70b747bf4fb5','你也好','2','admin','san','2016-01-25 16:27:54','2','ce8dc3b15afb40f28090f8b8e13f078d'),('f25e00cfafe741a3a05e3839b66dc7aa','你好','2','san','admin','2016-01-25 16:26:44','1','920b20dafdfb4c09b560884eb277c51d');

/*Table structure for table `sys_loginimg` */

DROP TABLE IF EXISTS `sys_loginimg`;

CREATE TABLE `sys_loginimg` (
  `LOGINIMG_ID` varchar(100) NOT NULL,
  `NAME` varchar(30) DEFAULT NULL COMMENT '文件名',
  `FILEPATH` varchar(100) DEFAULT NULL COMMENT '路径',
  `TYPE` int(2) NOT NULL COMMENT '状态',
  `FORDER` int(3) NOT NULL COMMENT '排序',
  PRIMARY KEY (`LOGINIMG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_loginimg` */

/*Table structure for table `sys_menu` */

DROP TABLE IF EXISTS `sys_menu`;

CREATE TABLE `sys_menu` (
  `MENU_ID` int(11) NOT NULL,
  `MENU_NAME` varchar(255) DEFAULT NULL,
  `MENU_URL` varchar(255) DEFAULT NULL,
  `PARENT_ID` varchar(100) DEFAULT NULL,
  `MENU_ORDER` varchar(100) DEFAULT NULL,
  `MENU_ICON` varchar(60) DEFAULT NULL,
  `MENU_TYPE` varchar(10) DEFAULT NULL,
  `MENU_STATE` int(1) DEFAULT NULL,
  PRIMARY KEY (`MENU_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_menu` */

insert  into `sys_menu`(`MENU_ID`,`MENU_NAME`,`MENU_URL`,`PARENT_ID`,`MENU_ORDER`,`MENU_ICON`,`MENU_TYPE`,`MENU_STATE`) values (1,'系统管理','#','0','1','menu-icon fa fa-desktop blue','2',1),(2,'权限管理','#','1','1','menu-icon fa fa-lock black','1',1),(3,'日志管理','fhlog/list.do','1','6','menu-icon fa fa-book blue','1',1),(6,'信息管理','#','0','5','menu-icon fa fa-credit-card green','2',1),(7,'图片管理','#','6','1','menu-icon fa fa-folder-o pink','2',1),(8,'性能监控','druid/index.html','9','9','menu-icon fa fa-tachometer red','1',1),(9,'系统工具','#','0','3','menu-icon fa fa-cog black','2',1),(20,'在线管理','onlinemanager/list.do','1','5','menu-icon fa fa-laptop green','1',1),(36,'角色(基础权限)','role.do','2','1','menu-icon fa fa-key orange','1',1),(37,'按钮权限','buttonrights/list.do','2','2','menu-icon fa fa-key green','1',1),(38,'菜单管理','menu/listAllMenu.do','1','3','menu-icon fa fa-folder-open-o brown','1',1),(39,'按钮管理','fhbutton/list.do','1','2','menu-icon fa fa-download orange','1',1),(40,'用户管理','#','0','2','menu-icon fa fa-users blue','2',1),(41,'系统用户','user/listUsers.do','40','1','menu-icon fa fa-users green','1',1),(43,'数据字典','dictionaries/listAllDict.do?DICTIONARIES_ID=0','1','4','menu-icon fa fa-book purple','1',1),(50,'站内信','fhsms/list.do','6','3','menu-icon fa fa-envelope green','1',1),(51,'图片列表','pictures/list.do','7','1','menu-icon fa fa-folder-open-o green','1',1),(52,'图片爬虫','pictures/goImageCrawler.do','7','2','menu-icon fa fa-cloud-download green','1',1),(54,'数据库管理','#','0','9','menu-icon fa fa-hdd-o blue','2',1),(55,'数据库备份','brdb/listAllTable.do','54','1','menu-icon fa fa-cloud-upload blue','1',1),(56,'数据库还原','brdb/list.do','54','3','menu-icon fa fa-cloud-download blue','1',1),(57,'备份定时器','timingbackup/list.do','54','2','menu-icon fa fa-tachometer blue','1',1),(58,'SQL编辑器','sqledit/view.do','54','4','menu-icon fa fa-pencil-square-o blue','1',1),(69,'客户管理','#','0','11','menu-icon fa fa-users green','2',1),(70,'客户资料','customer/list.do','69','1','menu-icon fa fa-users blue','1',1),(71,'客户备注','remarks/list.do','69','2','menu-icon fa fa-bookmark green','1',1),(72,'客户级别','level/list.do','69','3','menu-icon fa fa-filter orange','1',1),(73,'商品管理','#','0','12','menu-icon fa fa-inbox blue','2',1),(74,'商品列表','goods/list.do','73','1','menu-icon fa fa-gift green','1',1),(75,'商品类别','sptype/list.do','73','2','menu-icon fa fa-book blue','1',1),(76,'品牌管理','spbrand/list.do','73','3','menu-icon fa fa-globe purple','1',1),(77,'计量单位','spunit/list.do','73','4','menu-icon fa fa-circle-o pink','1',1),(78,'库存管理','#','0','13','menu-icon fa fa-home purple','2',1),(79,'商品库存(存)','kucun/list.do','78','1','menu-icon fa fa-home green','1',1),(80,'商品入库(进)','intoku/list.do','78','2','menu-icon fa fa-cloud-download orange','1',1),(81,'商品出库(销)','outku/list.do','78','3','menu-icon fa fa-cloud-upload purple','1',1),(82,'库存盘点','kucun/kucunchar.do','78','4','menu-icon fa fa-bar-chart-o blue','1',1),(83,'销售报表','outku/salesReport.do','78','5','menu-icon fa fa-book red','1',1),(84,'所有客户','allcustomer/list.do','69','1','menu-icon fa fa-users blue','1',1);

/*Table structure for table `sys_role` */

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `ROLE_ID` varchar(100) NOT NULL,
  `ROLE_NAME` varchar(100) DEFAULT NULL,
  `RIGHTS` varchar(255) DEFAULT NULL,
  `PARENT_ID` varchar(100) DEFAULT NULL,
  `ADD_QX` varchar(255) DEFAULT NULL,
  `DEL_QX` varchar(255) DEFAULT NULL,
  `EDIT_QX` varchar(255) DEFAULT NULL,
  `CHA_QX` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_role` */

insert  into `sys_role`(`ROLE_ID`,`ROLE_NAME`,`RIGHTS`,`PARENT_ID`,`ADD_QX`,`DEL_QX`,`EDIT_QX`,`CHA_QX`) values ('1','系统管理组','19343403975985204063896526','0','1','1','1','1'),('115b386ff04f4352b060dffcd2b5d1da','中级会员','','2','0','0','0','0'),('1b67fc82ce89457a8347ae53e43a347e','初级会员','','2','0','0','0','0'),('2','备用组(TEST)','','0','0','0','0','1'),('3','注册用户','','1','','0','0','0'),('3264c8e83d0248bb9e3ea6195b4c0216','总管理员(厂家)','19343403410773623942676544','1','19343403410773623942676544','19343403410773623942676544','19343403410773623942676544','19343403410773623942676544'),('68f8e4a39efe47c7bb869e9d15ab925d','下级管理员(商户)','19342222819149607996489792','1','19342222819149607996489792','19342222819149607996489792','19342222819149607996489792','19342222819152906531373120'),('8b70a7e67f2841e7aaba8a4d92e5ff6f','高级会员','','2','0','0','0','0');

/*Table structure for table `sys_role_fhbutton` */

DROP TABLE IF EXISTS `sys_role_fhbutton`;

CREATE TABLE `sys_role_fhbutton` (
  `RB_ID` varchar(100) NOT NULL,
  `ROLE_ID` varchar(100) DEFAULT NULL,
  `BUTTON_ID` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`RB_ID`),
  KEY `角色表外键` (`ROLE_ID`) USING BTREE,
  KEY `fbutton` (`BUTTON_ID`),
  CONSTRAINT `fbutton` FOREIGN KEY (`BUTTON_ID`) REFERENCES `sys_fhbutton` (`FHBUTTON_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `frole` FOREIGN KEY (`ROLE_ID`) REFERENCES `sys_role` (`ROLE_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_role_fhbutton` */

insert  into `sys_role_fhbutton`(`RB_ID`,`ROLE_ID`,`BUTTON_ID`) values ('4ee1e2bc03a64ef1bc578fcf2e2ea2c1','68f8e4a39efe47c7bb869e9d15ab925d','3542adfbda73410c976e185ffe50ad06'),('5669c8754b4d4e368365ed5065f9fc10','3264c8e83d0248bb9e3ea6195b4c0216','3542adfbda73410c976e185ffe50ad06'),('6cc655a1f9b746eea6af9df540f8e743','3','da7fd386de0b49ce809984f5919022b8'),('74203935bfa34ce3b9b80e81f2a2bcfe','68f8e4a39efe47c7bb869e9d15ab925d','4efa162fce8340f0bd2dcd3b11d327ec'),('81d31bc5bf02490a85ce496b6755ef26','3','46992ea280ba4b72b29dedb0d4bc0106'),('8231c216fb514b4188e4162e629c6237','3264c8e83d0248bb9e3ea6195b4c0216','4efa162fce8340f0bd2dcd3b11d327ec'),('88f66a65ee1642bea7979e0e1050ac5f','3','4efa162fce8340f0bd2dcd3b11d327ec'),('8f8b3c5bfdfa4c6da19fce7396279180','68f8e4a39efe47c7bb869e9d15ab925d','cc51b694d5344d28a9aa13c84b7166cd'),('d51dc41918b040a78a021c9a43caf8d5','68f8e4a39efe47c7bb869e9d15ab925d','da7fd386de0b49ce809984f5919022b8'),('d80abc961d594f75b65e90d5b7437aa9','3','cc51b694d5344d28a9aa13c84b7166cd'),('d9a9a5a2d79446449cd26c17f061e1d0','3264c8e83d0248bb9e3ea6195b4c0216','da7fd386de0b49ce809984f5919022b8'),('e2033c3cdb8d48a1865e16e085f103b7','3264c8e83d0248bb9e3ea6195b4c0216','46992ea280ba4b72b29dedb0d4bc0106'),('f0329033d0914faf8ea6e9ff252cc5e6','68f8e4a39efe47c7bb869e9d15ab925d','46992ea280ba4b72b29dedb0d4bc0106'),('f919c1f620634bdaa353a9f63194a2e0','3','3542adfbda73410c976e185ffe50ad06'),('fbc51895f2184d63bd1409320a7a7a2a','3264c8e83d0248bb9e3ea6195b4c0216','cc51b694d5344d28a9aa13c84b7166cd');

/*Table structure for table `sys_user` */

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
  `USER_ID` varchar(100) NOT NULL,
  `USERNAME` varchar(255) DEFAULT NULL,
  `PASSWORD` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `RIGHTS` varchar(255) DEFAULT NULL,
  `ROLE_ID` varchar(100) DEFAULT NULL,
  `LAST_LOGIN` varchar(255) DEFAULT NULL,
  `IP` varchar(100) DEFAULT NULL,
  `STATUS` varchar(32) DEFAULT NULL,
  `BZ` varchar(255) DEFAULT NULL,
  `SKIN` varchar(100) DEFAULT NULL,
  `EMAIL` varchar(32) DEFAULT NULL,
  `NUMBER` varchar(100) DEFAULT NULL,
  `PHONE` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_user` */

insert  into `sys_user`(`USER_ID`,`USERNAME`,`PASSWORD`,`NAME`,`RIGHTS`,`ROLE_ID`,`LAST_LOGIN`,`IP`,`STATUS`,`BZ`,`SKIN`,`EMAIL`,`NUMBER`,`PHONE`) values ('1','admin','de41b7fb99201d8334c23c014db35ecd92df81bc','FH','1133671055321055258374707980945218933803269864762743594642571294','1','2018-01-03 22:08:35','0:0:0:0:0:0:0:1','0','admin','default','QQ313596790@main.com','001','18788888888'),('a88125c7e4994d5a80061a3645d7701d','a0','203e2ccc573d3bfd4b2492926f441614b97d9f9d','总管','','3264c8e83d0248bb9e3ea6195b4c0216','2018-01-03 22:09:40','0:0:0:0:0:0:0:1','0','总管','default','222222@qq.com','0001','13555555555'),('aba226eceabc404d8960be0ee3626fcd','a2','2a68de09b5b0087d43654e9657dcf6a87408b349','李四','','68f8e4a39efe47c7bb869e9d15ab925d','2018-01-04 00:17:53','0:0:0:0:0:0:0:1','0','李四','default','55555@qq.com','000003','18888888888'),('df658542223d4da9b700852fd9adaddf','a1','cc3282bafa1ffcbc63c7edf850067c98e28fedb3','测试','','68f8e4a39efe47c7bb869e9d15ab925d','2018-01-04 00:18:18','0:0:0:0:0:0:0:1','0','测试','default','12121212@qq.com','1002','18765555555');

/*Table structure for table `sys_userphoto` */

DROP TABLE IF EXISTS `sys_userphoto`;

CREATE TABLE `sys_userphoto` (
  `USERPHOTO_ID` varchar(100) NOT NULL,
  `USERNAME` varchar(30) DEFAULT NULL COMMENT '用户名',
  `PHOTO0` varchar(255) DEFAULT NULL COMMENT '原图',
  `PHOTO1` varchar(100) DEFAULT NULL COMMENT '头像1',
  `PHOTO2` varchar(100) DEFAULT NULL COMMENT '头像2',
  `PHOTO3` varchar(100) DEFAULT NULL COMMENT '头像3',
  PRIMARY KEY (`USERPHOTO_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_userphoto` */

/*Table structure for table `tb_pictures` */

DROP TABLE IF EXISTS `tb_pictures`;

CREATE TABLE `tb_pictures` (
  `PICTURES_ID` varchar(100) NOT NULL,
  `TITLE` varchar(255) DEFAULT NULL COMMENT '标题',
  `NAME` varchar(255) DEFAULT NULL COMMENT '文件名',
  `PATH` varchar(255) DEFAULT NULL COMMENT '路径',
  `CREATETIME` varchar(100) DEFAULT NULL COMMENT '创建时间',
  `MASTER_ID` varchar(255) DEFAULT NULL COMMENT '属于',
  `BZ` varchar(255) DEFAULT NULL COMMENT '备注',
  `ORDER_BY` int(11) DEFAULT NULL,
  PRIMARY KEY (`PICTURES_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tb_pictures` */

insert  into `tb_pictures`(`PICTURES_ID`,`TITLE`,`NAME`,`PATH`,`CREATETIME`,`MASTER_ID`,`BZ`,`ORDER_BY`) values ('003db5c4dc3e4aa1947aac40c2ab4a73','商品图片','f190660d413745d9a951076efb5722a8.jpg','goods/f190660d413745d9a951076efb5722a8.jpg','2017-11-09 10:19:41','284e2238d7fc4bd481c6324fc4c160cf','商品图片',1),('2b3c8819dba04577a0fb37e33451c4b4','商品图片','545d84d1102c45f3846f5ba1fa494a2e.jpg','goods/545d84d1102c45f3846f5ba1fa494a2e.jpg','2017-11-09 10:19:41','284e2238d7fc4bd481c6324fc4c160cf','商品图片',1),('3f5afe51b5ab4bdbaa3e2ffd8c4f0abb','商品图片','8c3ea7205b814d93aea4245b0da423c6.png','goods/8c3ea7205b814d93aea4245b0da423c6.jpg','2017-11-09 10:19:41','284e2238d7fc4bd481c6324fc4c160cf','商品图片',1),('8920d2602c924679a685716253b643bb','商品图片','d639b3aeb6574f259d0c8b95e5dde279.jpg','goods/d639b3aeb6574f259d0c8b95e5dde279.jpg','2017-11-09 10:19:41','284e2238d7fc4bd481c6324fc4c160cf','商品图片',1),('919de55ada25424c9efb5d679e5dabb3','商品图片','f2e9b235dc9f4da3969cb0a4b351ac69.jpg','goods/f2e9b235dc9f4da3969cb0a4b351ac69.jpg','2017-11-09 10:19:41','284e2238d7fc4bd481c6324fc4c160cf','商品图片',1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
