/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 50732
 Source Host           : localhost:3306
 Source Schema         : febs_temp

 Target Server Type    : MySQL
 Target Server Version : 50732
 File Encoding         : 65001

 Date: 16/10/2023 16:47:36
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for QRTZ_BLOB_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
CREATE TABLE `QRTZ_BLOB_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of QRTZ_BLOB_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_CALENDARS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
CREATE TABLE `QRTZ_CALENDARS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `CALENDAR_NAME` varchar(200) NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of QRTZ_CALENDARS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_CRON_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
CREATE TABLE `QRTZ_CRON_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `CRON_EXPRESSION` varchar(200) NOT NULL,
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of QRTZ_CRON_TRIGGERS
-- ----------------------------
BEGIN;
INSERT INTO `QRTZ_CRON_TRIGGERS` VALUES ('FebsScheduler', 'TASK_5', 'DEFAULT', '0 35 14 16 10 ? ', 'Asia/Shanghai');
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_FIRED_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
CREATE TABLE `QRTZ_FIRED_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `ENTRY_ID` varchar(95) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) NOT NULL,
  `JOB_NAME` varchar(200) DEFAULT NULL,
  `JOB_GROUP` varchar(200) DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of QRTZ_FIRED_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_JOB_DETAILS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
CREATE TABLE `QRTZ_JOB_DETAILS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) NOT NULL,
  `IS_DURABLE` varchar(1) NOT NULL,
  `IS_NONCONCURRENT` varchar(1) NOT NULL,
  `IS_UPDATE_DATA` varchar(1) NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) NOT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of QRTZ_JOB_DETAILS
-- ----------------------------
BEGIN;
INSERT INTO `QRTZ_JOB_DETAILS` VALUES ('FebsScheduler', 'TASK_5', 'DEFAULT', NULL, 'cn.yuuki.job.handler.ScheduleJob', '0', '0', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720017636E2E7975756B692E6A6F622E656E746974792E4A6F62058D52AC1093A3040200084C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C000673746174757371007E000978707400087461736B4C6973747372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000018B372FB2AF7874001030203335203134203136203130203F207372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000000574000474657374740000740003323232740001317800);
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_LOCKS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_LOCKS`;
CREATE TABLE `QRTZ_LOCKS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `LOCK_NAME` varchar(40) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of QRTZ_LOCKS
-- ----------------------------
BEGIN;
INSERT INTO `QRTZ_LOCKS` VALUES ('clusteredScheduler', 'STATE_ACCESS');
INSERT INTO `QRTZ_LOCKS` VALUES ('FebsScheduler', 'STATE_ACCESS');
INSERT INTO `QRTZ_LOCKS` VALUES ('FebsScheduler', 'TRIGGER_ACCESS');
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_SCHEDULER_STATE
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
CREATE TABLE `QRTZ_SCHEDULER_STATE` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of QRTZ_SCHEDULER_STATE
-- ----------------------------
BEGIN;
INSERT INTO `QRTZ_SCHEDULER_STATE` VALUES ('clusteredScheduler', 'chennimadeMBP.lan1697419548345', 1697419685475, 10000);
INSERT INTO `QRTZ_SCHEDULER_STATE` VALUES ('FebsScheduler', 'chennimadeMBP.lan1697440619568', 1697446052524, 15000);
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_SIMPLE_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of QRTZ_SIMPLE_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_SIMPROP_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `STR_PROP_1` varchar(512) DEFAULT NULL,
  `STR_PROP_2` varchar(512) DEFAULT NULL,
  `STR_PROP_3` varchar(512) DEFAULT NULL,
  `INT_PROP_1` int(11) DEFAULT NULL,
  `INT_PROP_2` int(11) DEFAULT NULL,
  `LONG_PROP_1` bigint(20) DEFAULT NULL,
  `LONG_PROP_2` bigint(20) DEFAULT NULL,
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of QRTZ_SIMPROP_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
CREATE TABLE `QRTZ_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) NOT NULL,
  `TRIGGER_TYPE` varchar(8) NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `SCHED_NAME` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `QRTZ_JOB_DETAILS` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of QRTZ_TRIGGERS
-- ----------------------------
BEGIN;
INSERT INTO `QRTZ_TRIGGERS` VALUES ('FebsScheduler', 'TASK_5', 'DEFAULT', 'TASK_5', 'DEFAULT', NULL, 1729060500000, -1, 5, 'PAUSED', 'CRON', 1697437955000, 0, NULL, 2, 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720017636E2E7975756B692E6A6F622E656E746974792E4A6F62058D52AC1093A3040200084C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C000673746174757371007E000978707400087461736B4C6973747074001030203335203134203136203130203F207372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000057400057465737431740000740003323232740001307800);
COMMIT;

-- ----------------------------
-- Table structure for t_dept
-- ----------------------------
DROP TABLE IF EXISTS `t_dept`;
CREATE TABLE `t_dept` (
  `DEPT_ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门ID',
  `PARENT_ID` bigint(20) NOT NULL COMMENT '上级部门ID',
  `DEPT_NAME` varchar(100) NOT NULL COMMENT '部门名称',
  `ORDER_NUM` double(20,0) DEFAULT NULL COMMENT '排序',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `MODIFY_TIME` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`DEPT_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_dept
-- ----------------------------
BEGIN;
INSERT INTO `t_dept` VALUES (1, 0, '开发部', 1, '2018-01-04 15:42:26', '2019-01-05 21:08:27');
INSERT INTO `t_dept` VALUES (2, 1, '开发一部', 1, '2018-01-04 15:42:34', '2019-01-18 00:59:37');
INSERT INTO `t_dept` VALUES (3, 1, '开发二部', 2, '2018-01-04 15:42:29', '2019-01-05 14:09:39');
INSERT INTO `t_dept` VALUES (4, 0, '市场部', 2, '2018-01-04 15:42:36', '2019-01-23 06:27:56');
INSERT INTO `t_dept` VALUES (5, 0, '人事部', 3, '2018-01-04 15:42:32', '2019-01-23 06:27:59');
INSERT INTO `t_dept` VALUES (6, 0, '测试部', 4, '2018-01-04 15:42:38', '2019-01-17 08:15:47');
INSERT INTO `t_dept` VALUES (14, 6, '测试一部', NULL, '2023-05-31 01:38:58', '2023-05-31 01:39:25');
INSERT INTO `t_dept` VALUES (17, 0, '采购部', NULL, '2023-05-31 01:41:52', NULL);
INSERT INTO `t_dept` VALUES (19, 0, '管理部', NULL, '2023-05-31 02:26:26', NULL);
INSERT INTO `t_dept` VALUES (20, 0, '销售部门', NULL, '2023-05-31 11:06:24', '2023-06-03 01:08:30');
INSERT INTO `t_dept` VALUES (21, 0, '软件信息技术中心', NULL, '2023-06-03 01:07:20', NULL);
INSERT INTO `t_dept` VALUES (22, 21, '测试部', NULL, '2023-06-03 01:07:36', NULL);
COMMIT;

-- ----------------------------
-- Table structure for t_dict
-- ----------------------------
DROP TABLE IF EXISTS `t_dict`;
CREATE TABLE `t_dict` (
  `DICT_ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典ID',
  `KEYY` bigint(20) NOT NULL COMMENT '键',
  `VALUEE` varchar(100) NOT NULL COMMENT '值',
  `FIELD_NAME` varchar(100) NOT NULL COMMENT '字段名称',
  `TABLE_NAME` varchar(100) NOT NULL COMMENT '表名',
  PRIMARY KEY (`DICT_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_dict
-- ----------------------------
BEGIN;
INSERT INTO `t_dict` VALUES (1, 0, '男', 'ssex', 't_user');
INSERT INTO `t_dict` VALUES (2, 1, '女', 'ssex', 't_user');
INSERT INTO `t_dict` VALUES (3, 2, '保密', 'ssex', 't_user');
INSERT INTO `t_dict` VALUES (4, 1, '有效', 'status', 't_user');
INSERT INTO `t_dict` VALUES (5, 0, '锁定', 'status', 't_user');
INSERT INTO `t_dict` VALUES (6, 0, '菜单', 'type', 't_menu');
INSERT INTO `t_dict` VALUES (7, 1, '按钮', 'type', 't_menu');
INSERT INTO `t_dict` VALUES (30, 0, '正常', 'status', 't_job');
INSERT INTO `t_dict` VALUES (31, 1, '暂停', 'status', 't_job');
INSERT INTO `t_dict` VALUES (32, 0, '成功', 'status', 't_job_log');
INSERT INTO `t_dict` VALUES (33, 1, '失败', 'status', 't_job_log');
COMMIT;

-- ----------------------------
-- Table structure for t_eximport
-- ----------------------------
DROP TABLE IF EXISTS `t_eximport`;
CREATE TABLE `t_eximport` (
  `FIELD1` varchar(20) NOT NULL,
  `FIELD2` int(11) NOT NULL,
  `FIELD3` varchar(100) NOT NULL,
  `CREATE_TIME` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Excel导入导出测试';

-- ----------------------------
-- Records of t_eximport
-- ----------------------------
BEGIN;
INSERT INTO `t_eximport` VALUES ('字段3333', 134234, 'mrbird0@gmail.com', '2019-11-07 06:39:03');
COMMIT;

-- ----------------------------
-- Table structure for t_job
-- ----------------------------
DROP TABLE IF EXISTS `t_job`;
CREATE TABLE `t_job` (
  `JOB_ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务id',
  `BEAN_NAME` varchar(50) NOT NULL COMMENT 'spring bean名称',
  `METHOD_NAME` varchar(50) NOT NULL COMMENT '方法名',
  `PARAMS` varchar(50) DEFAULT NULL COMMENT '参数',
  `CRON_EXPRESSION` varchar(20) NOT NULL COMMENT 'cron表达式',
  `STATUS` char(2) NOT NULL COMMENT '任务状态  0：正常  1：暂停',
  `REMARK` varchar(50) DEFAULT NULL COMMENT '备注',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`JOB_ID`) USING BTREE,
  KEY `t_job_create_time` (`CREATE_TIME`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='定时任务表';

-- ----------------------------
-- Records of t_job
-- ----------------------------
BEGIN;
INSERT INTO `t_job` VALUES (5, 'taskList', 'test1', '', '0 35 14 16 10 ? ', '1', '222', '2023-10-16 06:32:35');
COMMIT;

-- ----------------------------
-- Table structure for t_job_log
-- ----------------------------
DROP TABLE IF EXISTS `t_job_log`;
CREATE TABLE `t_job_log` (
  `LOG_ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志id',
  `JOB_ID` bigint(20) NOT NULL COMMENT '任务id',
  `BEAN_NAME` varchar(100) NOT NULL COMMENT 'spring bean名称',
  `METHOD_NAME` varchar(100) NOT NULL COMMENT '方法名',
  `PARAMS` varchar(200) DEFAULT NULL COMMENT '参数',
  `STATUS` char(2) NOT NULL COMMENT '任务状态    0：成功    1：失败',
  `ERROR` text COMMENT '失败信息',
  `TIMES` decimal(11,0) DEFAULT NULL COMMENT '耗时(单位：毫秒)',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`LOG_ID`) USING BTREE,
  KEY `t_job_log_create_time` (`CREATE_TIME`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='调度日志表';

-- ----------------------------
-- Records of t_job_log
-- ----------------------------
BEGIN;
INSERT INTO `t_job_log` VALUES (1, 5, 'taskList', 'test', '', '1', 'java.lang.NoSuchMethodException: cn.yuuki.job.task.TaskList.test()', 21, '2023-10-16 07:17:14');
INSERT INTO `t_job_log` VALUES (2, 5, 'taskList', 'test1', '', '0', NULL, 2, '2023-10-16 07:19:02');
INSERT INTO `t_job_log` VALUES (3, 6, 'taskList', 'test', '123', '0', NULL, 3, '2023-10-16 08:06:53');
COMMIT;

-- ----------------------------
-- Table structure for t_log
-- ----------------------------
DROP TABLE IF EXISTS `t_log`;
CREATE TABLE `t_log` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `USERNAME` varchar(50) DEFAULT NULL COMMENT '操作用户',
  `OPERATION` text COMMENT '操作内容',
  `TIME` decimal(11,0) DEFAULT NULL COMMENT '耗时',
  `METHOD` text COMMENT '操作方法',
  `PARAMS` text COMMENT '方法参数',
  `IP` varchar(64) DEFAULT NULL COMMENT '操作者IP',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `location` varchar(50) DEFAULT NULL COMMENT '操作地点',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1856 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_log
-- ----------------------------
BEGIN;
INSERT INTO `t_log` VALUES (1815, 'mrbird', '删除用户', 301, 'cc.mrbird.febs.system.controller.UserController.deleteUsers()', ' userIds: \"11\"', '127.0.0.1', '2019-01-23 06:26:43', '内网IP|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1816, 'mrbird', '修改菜单/按钮', 170, 'cc.mrbird.febs.system.controller.MenuController.updateMenu()', ' menu: \"Menu(menuId=2, parentId=0, menuName=系统监控, path=/monitor, component=PageView, perms=null, icon=dashboard, type=0, orderNum=2.0, createTime=null, modifyTime=Wed Jan 23 14:27:12 CST 2019, createTimeFrom=null, createTimeTo=null)\"', '127.0.0.1', '2019-01-23 06:27:13', '内网IP|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1817, 'mrbird', '修改部门', 90, 'cc.mrbird.febs.system.controller.DeptController.updateDept()', ' dept: \"Dept(deptId=4, parentId=0, deptName=市场部, orderNum=2.0, createTime=null, modifyTime=Wed Jan 23 14:27:55 CST 2019, createTimeFrom=null, createTimeTo=null)\"', '127.0.0.1', '2019-01-23 06:27:56', '内网IP|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1818, 'mrbird', '修改部门', 596, 'cc.mrbird.febs.system.controller.DeptController.updateDept()', ' dept: \"Dept(deptId=5, parentId=0, deptName=人事部, orderNum=3.0, createTime=null, modifyTime=Wed Jan 23 14:27:59 CST 2019, createTimeFrom=null, createTimeTo=null)\"', '127.0.0.1', '2019-01-23 06:28:00', '内网IP|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1819, 'mrbird', '执行定时任务', 146, 'cc.mrbird.febs.job.controller.JobController.runJob()', ' jobId: \"1\"', '127.0.0.1', '2019-01-23 06:28:58', '内网IP|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1820, 'mrbird', '新增菜单/按钮', 160, 'cc.mrbird.febs.system.controller.MenuController.addMenu()', ' menu: \"Menu(menuId=130, parentId=3, menuName=导出Excel, path=null, component=null, perms=user:export, icon=null, type=1, orderNum=null, createTime=Wed Jan 23 14:35:15 CST 2019, modifyTime=null, createTimeFrom=null, createTimeTo=null)\"', '127.0.0.1', '2019-01-23 06:35:16', '内网IP|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1821, 'mrbird', '新增菜单/按钮', 255, 'cc.mrbird.febs.system.controller.MenuController.addMenu()', ' menu: \"Menu(menuId=131, parentId=4, menuName=导出Excel, path=null, component=null, perms=role:export, icon=null, type=1, orderNum=null, createTime=Wed Jan 23 14:35:36 CST 2019, modifyTime=null, createTimeFrom=null, createTimeTo=null)\"', '127.0.0.1', '2019-01-23 06:35:36', '内网IP|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1822, 'mrbird', '新增菜单/按钮', 172, 'cc.mrbird.febs.system.controller.MenuController.addMenu()', ' menu: \"Menu(menuId=132, parentId=5, menuName=导出Excel, path=null, component=null, perms=menu:export, icon=null, type=1, orderNum=null, createTime=Wed Jan 23 14:36:04 CST 2019, modifyTime=null, createTimeFrom=null, createTimeTo=null)\"', '127.0.0.1', '2019-01-23 06:36:05', '内网IP|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1823, 'mrbird', '新增菜单/按钮', 188, 'cc.mrbird.febs.system.controller.MenuController.addMenu()', ' menu: \"Menu(menuId=133, parentId=6, menuName=导出Excel, path=null, component=null, perms=dept:export, icon=null, type=1, orderNum=null, createTime=Wed Jan 23 14:36:24 CST 2019, modifyTime=null, createTimeFrom=null, createTimeTo=null)\"', '127.0.0.1', '2019-01-23 06:36:25', '内网IP|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1824, 'mrbird', '新增菜单/按钮', 186, 'cc.mrbird.febs.system.controller.MenuController.addMenu()', ' menu: \"Menu(menuId=134, parentId=64, menuName=导出Excel, path=null, component=null, perms=dict:export, icon=null, type=1, orderNum=null, createTime=Wed Jan 23 14:36:43 CST 2019, modifyTime=null, createTimeFrom=null, createTimeTo=null)\"', '127.0.0.1', '2019-01-23 06:36:44', '内网IP|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1825, 'mrbird', '新增菜单/按钮', 160, 'cc.mrbird.febs.system.controller.MenuController.addMenu()', ' menu: \"Menu(menuId=135, parentId=3, menuName=密码重置, path=null, component=null, perms=user:reset, icon=null, type=1, orderNum=null, createTime=Wed Jan 23 14:36:59 CST 2019, modifyTime=null, createTimeFrom=null, createTimeTo=null)\"', '127.0.0.1', '2019-01-23 06:37:00', '内网IP|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1826, 'mrbird', '新增菜单/按钮', 181, 'cc.mrbird.febs.system.controller.MenuController.addMenu()', ' menu: \"Menu(menuId=136, parentId=10, menuName=导出Excel, path=null, component=null, perms=log:export, icon=null, type=1, orderNum=null, createTime=Wed Jan 23 14:37:26 CST 2019, modifyTime=null, createTimeFrom=null, createTimeTo=null)\"', '127.0.0.1', '2019-01-23 06:37:27', '内网IP|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1827, 'mrbird', '新增菜单/按钮', 146, 'cc.mrbird.febs.system.controller.MenuController.addMenu()', ' menu: \"Menu(menuId=137, parentId=102, menuName=导出Excel, path=null, component=null, perms=job:export, icon=null, type=1, orderNum=null, createTime=Wed Jan 23 14:37:59 CST 2019, modifyTime=null, createTimeFrom=null, createTimeTo=null)\"', '127.0.0.1', '2019-01-23 06:37:59', '内网IP|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1828, 'mrbird', '新增菜单/按钮', 164, 'cc.mrbird.febs.system.controller.MenuController.addMenu()', ' menu: \"Menu(menuId=138, parentId=109, menuName=导出Excel, path=null, component=null, perms=jobLog:export, icon=null, type=1, orderNum=null, createTime=Wed Jan 23 14:38:32 CST 2019, modifyTime=null, createTimeFrom=null, createTimeTo=null)\"', '127.0.0.1', '2019-01-23 06:38:33', '内网IP|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1829, 'mrbird', '修改角色', 3132, 'cc.mrbird.febs.system.controller.RoleController.updateRole()', ' role: \"Role(roleId=1, roleName=管理员, remark=管理员, createTime=null, modifyTime=Wed Jan 23 14:45:28 CST 2019, createTimeFrom=null, createTimeTo=null, menuId=1,3,11,12,13,4,14,15,16,5,17,18,19,6,20,21,22,64,65,66,67,2,8,23,10,24,113,121,122,124,123,125,101,102,103,104,105,106,107,108,109,110,58,59,61,81,82,83,127,128,129,130,135,131,132,133,134,136,137,138)\"', '127.0.0.1', '2019-01-23 06:45:32', '内网IP|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1830, 'mrbird', '修改角色', 1730, 'cc.mrbird.febs.system.controller.RoleController.updateRole()', ' role: \"Role(roleId=2, roleName=注册用户, remark=只可查看不可操作, createTime=null, modifyTime=Wed Jan 23 15:31:07 CST 2019, createTimeFrom=null, createTimeTo=null, menuId=3,1,4,5,6,64,2,8,10,113,121,122,124,123,125,101,102,109,58,59,61,81,82,83,127,128,129)\"', '127.0.0.1', '2019-01-23 07:31:09', '内网IP|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1831, 'mrbird', '修改角色', 1997, 'cc.mrbird.febs.system.controller.RoleController.updateRole()', ' role: \"Role(roleId=2, roleName=注册用户, remark=可查看，新增，导出, createTime=null, modifyTime=Wed Jan 23 15:32:20 CST 2019, createTimeFrom=null, createTimeTo=null, menuId=3,1,4,5,6,64,2,8,10,113,121,122,124,123,125,101,102,109,58,59,61,81,82,83,127,128,129,130,14,17,132,20,133,65,134,136,103,137,138)\"', '127.0.0.1', '2019-01-23 07:32:22', '内网IP|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1832, 'mrbird', '新增角色', 1428, 'cc.mrbird.febs.system.controller.RoleController.addRole()', ' role: \"Role(roleId=72, roleName=普通用户, remark=只可查看，好可怜哦, createTime=Wed Jan 23 15:33:20 CST 2019, modifyTime=null, createTimeFrom=null, createTimeTo=null, menuId=1,3,4,5,6,64,2,8,10,113,121,122,124,123,127,101,102,109,58,59,61,81,82,83,128,129)\"', '127.0.0.1', '2019-01-23 07:33:22', '内网IP|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1833, 'mrbird', '新增用户', 338, 'cc.mrbird.febs.system.controller.UserController.addUser()', ' user: \"User(userId=12, username=jack, password=552649f10640385d0728a80a4242893e, deptId=6, deptName=null, email=jack@hotmail.com, mobile=null, status=1, createTime=Wed Jan 23 15:34:05 CST 2019, modifyTime=null, lastLoginTime=null, ssex=0, description=null, avatar=default.jpg, roleId=72, roleName=null, sortField=null, sortOrder=null, createTimeFrom=null, createTimeTo=null, id=null)\"', '127.0.0.1', '2019-01-23 07:34:06', '内网IP|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1834, 'mrbird', '修改角色', 2160, 'cc.mrbird.febs.system.controller.RoleController.updateRole()', ' role: \"Role(roleId=2, roleName=注册用户, remark=可查看，新增，导出, createTime=null, modifyTime=Wed Jan 23 15:37:08 CST 2019, createTimeFrom=null, createTimeTo=null, menuId=3,1,4,5,6,64,2,8,10,113,121,122,124,123,125,101,102,109,58,59,61,81,82,83,127,128,129,130,14,17,132,20,133,65,134,136,103,137,138,131)\"', '127.0.0.1', '2019-01-23 07:37:11', '内网IP|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1835, 'mrbird', '新增角色', 169, 'cc.mrbird.febs.system.controller.RoleController.addRole()', ' role: \"Role(roleId=73, roleName=测试xss, remark=<style>body{background:red !important}</style>, createTime=Wed Jan 23 15:47:04 CST 2019, modifyTime=null, createTimeFrom=null, createTimeTo=null, menuId=1,3)\"', '127.0.0.1', '2019-01-23 07:47:04', '内网IP|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1836, 'mrbird', '修改用户', 31, 'cc.mrbird.febs.system.controller.UserController.updateUser()', ' user: \"User(userId=1, username=mrbird, password=null, deptId=1, deptName=null, email=mrbird123@hotmail.com, mobile=13455533233, status=1, createTime=null, modifyTime=Wed Jan 23 21:08:13 CST 2019, lastLoginTime=null, ssex=0, description=null, avatar=null, roleId=1, roleName=null, sortField=null, sortOrder=null, createTimeFrom=null, createTimeTo=null, id=null)\"', '127.0.0.1', '2019-01-23 13:08:13', '内网IP|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1837, 'mrbird', '修改角色', 156, 'cc.mrbird.febs.system.controller.RoleController.updateRole()', ' role: \"Role(roleId=1, roleName=管理员, remark=管理员, createTime=null, modifyTime=Thu Nov 07 11:33:38 CST 2019, createTimeFrom=null, createTimeTo=null, menuIds=1,3,11,12,13,130,135,4,14,15,16,131,5,17,18,19,132,6,20,21,22,133,2,10,24,136,154,155)\"', '127.0.0.1', '2019-11-07 03:33:39', '内网IP|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1838, 'mrbird', '修改用户', 188, 'cn.yuuki.system.controller.UserController.updateUser()', ' user: \"SystemUser(userId=1, username=mrbird, realName=阿鸟, password=null, deptId=2, email=mrbird123@hotmail.com, mobile=13455533233, status=1, createTime=null, modifyTime=Fri Oct 13 15:27:45 CST 2023, lastLoginTime=null, sex=0, avatar=null, description=null, deptName=null, createTimeFrom=null, createTimeTo=null, roleId=1, theme=null, roleName=null, deptIds=null)\"', '127.0.0.1', '2023-10-13 07:27:45', '0|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1839, 'mrbird', '新增菜单/按钮', 186, 'cn.yuuki.system.controller.MenuController.addMenu()', ' menu: \"Menu(menuId=153, parentId=0, menuName=定时任务, path=/job, component=Layout, perms=, icon=icon-loop, type=0, orderNum=3, createTime=Mon Oct 16 10:19:28 CST 2023, modifyTime=null, createTimeFrom=null, createTimeTo=null)\"', '127.0.0.1', '2023-10-16 02:19:29', '0|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1840, 'mrbird', '新增菜单/按钮', 24, 'cn.yuuki.system.controller.MenuController.addMenu()', ' menu: \"Menu(menuId=154, parentId=153, menuName=定时任务管理, path=/job/manage, component=job/job/index, perms=job:view, icon=, type=0, orderNum=0, createTime=Mon Oct 16 10:19:59 CST 2023, modifyTime=null, createTimeFrom=null, createTimeTo=null)\"', '127.0.0.1', '2023-10-16 02:20:00', '0|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1841, 'mrbird', '新增菜单/按钮', 20, 'cn.yuuki.system.controller.MenuController.addMenu()', ' menu: \"Menu(menuId=155, parentId=154, menuName=新增, path=null, component=null, perms=job:add, icon=null, type=1, orderNum=null, createTime=Mon Oct 16 10:21:56 CST 2023, modifyTime=null, createTimeFrom=null, createTimeTo=null)\"', '127.0.0.1', '2023-10-16 02:21:57', '0|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1842, 'mrbird', '新增菜单/按钮', 90, 'cn.yuuki.system.controller.MenuController.addMenu()', ' menu: \"Menu(menuId=156, parentId=154, menuName=更新, path=null, component=null, perms=job:update, icon=null, type=1, orderNum=null, createTime=Mon Oct 16 10:22:27 CST 2023, modifyTime=null, createTimeFrom=null, createTimeTo=null)\"', '127.0.0.1', '2023-10-16 02:22:28', '0|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1843, 'mrbird', '新增菜单/按钮', 30, 'cn.yuuki.system.controller.MenuController.addMenu()', ' menu: \"Menu(menuId=157, parentId=154, menuName=删除, path=null, component=null, perms=job:delete, icon=null, type=1, orderNum=null, createTime=Mon Oct 16 10:22:41 CST 2023, modifyTime=null, createTimeFrom=null, createTimeTo=null)\"', '127.0.0.1', '2023-10-16 02:22:42', '0|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1844, 'mrbird', '新增菜单/按钮', 30, 'cn.yuuki.system.controller.MenuController.addMenu()', ' menu: \"Menu(menuId=158, parentId=154, menuName=运行任务, path=null, component=null, perms=job:run, icon=null, type=1, orderNum=null, createTime=Mon Oct 16 10:22:56 CST 2023, modifyTime=null, createTimeFrom=null, createTimeTo=null)\"', '127.0.0.1', '2023-10-16 02:22:57', '0|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1845, 'mrbird', '新增菜单/按钮', 22, 'cn.yuuki.system.controller.MenuController.addMenu()', ' menu: \"Menu(menuId=159, parentId=154, menuName=暂停任务, path=null, component=null, perms=job, icon=null, type=1, orderNum=null, createTime=Mon Oct 16 10:23:12 CST 2023, modifyTime=null, createTimeFrom=null, createTimeTo=null)\"', '127.0.0.1', '2023-10-16 02:23:12', '0|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1846, 'mrbird', '新增菜单/按钮', 46, 'cn.yuuki.system.controller.MenuController.addMenu()', ' menu: \"Menu(menuId=160, parentId=154, menuName=恢复任务, path=null, component=null, perms=job:resume, icon=null, type=1, orderNum=null, createTime=Mon Oct 16 10:23:29 CST 2023, modifyTime=null, createTimeFrom=null, createTimeTo=null)\"', '127.0.0.1', '2023-10-16 02:23:30', '0|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1847, 'mrbird', '修改菜单/按钮', 36, 'cn.yuuki.system.controller.MenuController.updateMenu()', ' menu: \"Menu(menuId=159, parentId=154, menuName=暂停任务, path=null, component=null, perms=job:pause, icon=null, type=1, orderNum=null, createTime=null, modifyTime=Mon Oct 16 10:23:40 CST 2023, createTimeFrom=null, createTimeTo=null)\"', '127.0.0.1', '2023-10-16 02:23:40', '0|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1848, 'mrbird', '删除角色', 147, 'cn.yuuki.system.controller.RoleController.deleteRoles()', ' roleIds: \"22\"', '127.0.0.1', '2023-10-16 02:26:05', '0|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1849, 'mrbird', '删除角色', 32, 'cn.yuuki.system.controller.RoleController.deleteRoles()', ' roleIds: \"13\"', '127.0.0.1', '2023-10-16 02:26:09', '0|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1850, 'mrbird', '删除角色', 33, 'cn.yuuki.system.controller.RoleController.deleteRoles()', ' roleIds: \"12\"', '127.0.0.1', '2023-10-16 02:26:12', '0|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1851, 'mrbird', '修改角色', 176, 'cn.yuuki.system.controller.RoleController.updateRole()', ' role: \"Role(roleId=1, roleName=管理员, remark=管理员, createTime=null, modifyTime=Mon Oct 16 10:26:24 CST 2023, menuIds=15,136,1,10,2,3,11,12,13,130,135,4,14,16,131,5,17,18,19,132,6,20,21,22,133,24,150,151,152,153,154,155,156,157,158,159,160)\"', '127.0.0.1', '2023-10-16 02:26:24', '0|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1852, 'mrbird', '新增菜单/按钮', 368, 'cn.yuuki.system.controller.MenuController.addMenu()', ' menu: \"Menu(menuId=161, parentId=153, menuName=执行日志, path=/job/jobLog, component=job/job-log/index, perms=jobLog:view, icon=, type=0, orderNum=1, createTime=Mon Oct 16 16:16:32 CST 2023, modifyTime=null, createTimeFrom=null, createTimeTo=null)\"', '127.0.0.1', '2023-10-16 08:16:33', '0|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1853, 'mrbird', '删除角色', 296, 'cn.yuuki.system.controller.RoleController.deleteRoles()', ' roleIds: \"21\"', '127.0.0.1', '2023-10-16 08:36:38', '0|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1854, 'mrbird', '修改角色', 322, 'cn.yuuki.system.controller.RoleController.updateRole()', ' role: \"Role(roleId=1, roleName=管理员, remark=管理员, createTime=null, modifyTime=Mon Oct 16 16:36:41 CST 2023, menuIds=14,152,10,132,159,135,150,136,18,157,13,133,5,155,11,21,16,153,2,6,160,4,151,1,19,158,130,24,15,17,156,12,22,131,154,3,20,161)\"', '127.0.0.1', '2023-10-16 08:36:42', '0|0|0|内网IP|内网IP');
INSERT INTO `t_log` VALUES (1855, 'mrbird', '修改菜单/按钮', 53, 'cn.yuuki.system.controller.MenuController.updateMenu()', ' menu: \"Menu(menuId=161, parentId=153, menuName=执行日志, path=/job/jobLog, component=job/job-log/index, perms=job:log:view, icon=, type=0, orderNum=1, createTime=null, modifyTime=Mon Oct 16 16:37:44 CST 2023, createTimeFrom=null, createTimeTo=null)\"', '127.0.0.1', '2023-10-16 08:37:45', '0|0|0|内网IP|内网IP');
COMMIT;

-- ----------------------------
-- Table structure for t_login_log
-- ----------------------------
DROP TABLE IF EXISTS `t_login_log`;
CREATE TABLE `t_login_log` (
  `ID` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `USERNAME` varchar(50) NOT NULL COMMENT '用户名',
  `LOGIN_TIME` datetime NOT NULL COMMENT '登录时间',
  `LOCATION` varchar(50) DEFAULT NULL COMMENT '登录地点',
  `IP` varchar(50) DEFAULT NULL COMMENT 'IP地址',
  `SYSTEM` varchar(50) DEFAULT NULL COMMENT '操作系统',
  `BROWSER` varchar(50) DEFAULT NULL COMMENT '浏览器',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=108 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='登录日志表';

-- ----------------------------
-- Records of t_login_log
-- ----------------------------
BEGIN;
INSERT INTO `t_login_log` VALUES (106, 'mrbird', '2023-08-04 06:39:04', '0|0|0|内网IP|内网IP', '127.0.0.1', 'Mac OS X 10_15_7', 'Chrome 11');
INSERT INTO `t_login_log` VALUES (107, 'mrbird', '2023-10-13 07:27:21', '0|0|0|内网IP|内网IP', '127.0.0.1', 'Mac OS X 10_15_7', 'Chrome 11');
COMMIT;

-- ----------------------------
-- Table structure for t_menu
-- ----------------------------
DROP TABLE IF EXISTS `t_menu`;
CREATE TABLE `t_menu` (
  `MENU_ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单/按钮ID',
  `PARENT_ID` bigint(20) NOT NULL COMMENT '上级菜单ID',
  `MENU_NAME` varchar(50) NOT NULL COMMENT '菜单/按钮名称',
  `PATH` varchar(255) DEFAULT NULL COMMENT '对应路由path',
  `COMPONENT` varchar(255) DEFAULT NULL COMMENT '对应路由组件component',
  `PERMS` varchar(50) DEFAULT NULL COMMENT '权限标识',
  `ICON` varchar(50) DEFAULT NULL COMMENT '图标',
  `TYPE` char(2) NOT NULL COMMENT '类型 0菜单 1按钮',
  `ORDER_NUM` double(20,0) DEFAULT NULL COMMENT '排序',
  `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFY_TIME` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`MENU_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=162 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_menu
-- ----------------------------
BEGIN;
INSERT INTO `t_menu` VALUES (1, 0, '系统管理', '/system', 'Layout', NULL, 'icon-settings', '0', 1, '2017-12-27 16:39:07', '2019-07-20 16:19:04');
INSERT INTO `t_menu` VALUES (2, 0, '系统监控', '/monitor', 'Layout', NULL, 'icon-computer', '0', 2, '2017-12-27 16:45:51', '2019-01-23 06:27:12');
INSERT INTO `t_menu` VALUES (3, 1, '用户管理', '/system/user', 'system/user/index', 'user:view', '', '0', 1, '2017-12-27 16:47:13', '2019-01-22 06:45:55');
INSERT INTO `t_menu` VALUES (4, 1, '角色管理', '/system/role', 'system/role/index', 'role:view', '', '0', 2, '2017-12-27 16:48:09', '2018-04-25 09:01:12');
INSERT INTO `t_menu` VALUES (5, 1, '菜单管理', '/system/menu', 'system/menu/index', 'menu:view', '', '0', 3, '2017-12-27 16:48:57', '2018-04-25 09:01:30');
INSERT INTO `t_menu` VALUES (6, 1, '部门管理', '/system/dept', 'system/dept/index', 'dept:view', '', '0', 4, '2017-12-27 16:57:33', '2018-04-25 09:01:40');
INSERT INTO `t_menu` VALUES (10, 2, '系统日志', '/monitor/systemlog', 'system/monitor/syslog/index', 'log:view', '', '0', 2, '2017-12-27 17:00:50', '2023-06-08 08:07:49');
INSERT INTO `t_menu` VALUES (11, 3, '新增用户', '', '', 'user:add', NULL, '1', NULL, '2017-12-27 17:02:58', NULL);
INSERT INTO `t_menu` VALUES (12, 3, '修改用户', '', '', 'user:update', NULL, '1', NULL, '2017-12-27 17:04:07', NULL);
INSERT INTO `t_menu` VALUES (13, 3, '删除用户', '', '', 'user:delete', NULL, '1', NULL, '2017-12-27 17:04:58', NULL);
INSERT INTO `t_menu` VALUES (14, 4, '新增角色', '', '', 'role:add', NULL, '1', NULL, '2017-12-27 17:06:38', NULL);
INSERT INTO `t_menu` VALUES (15, 4, '修改角色', '', '', 'role:update', NULL, '1', NULL, '2017-12-27 17:06:38', NULL);
INSERT INTO `t_menu` VALUES (16, 4, '删除角色', '', '', 'role:delete', NULL, '1', NULL, '2017-12-27 17:06:38', NULL);
INSERT INTO `t_menu` VALUES (17, 5, '新增菜单', '', '', 'menu:add', NULL, '1', NULL, '2017-12-27 17:08:02', NULL);
INSERT INTO `t_menu` VALUES (18, 5, '修改菜单', '', '', 'menu:update', NULL, '1', NULL, '2017-12-27 17:08:02', NULL);
INSERT INTO `t_menu` VALUES (19, 5, '删除菜单', '', '', 'menu:delete', NULL, '1', NULL, '2017-12-27 17:08:02', NULL);
INSERT INTO `t_menu` VALUES (20, 6, '新增部门', '', '', 'dept:add', NULL, '1', NULL, '2017-12-27 17:09:24', NULL);
INSERT INTO `t_menu` VALUES (21, 6, '修改部门', '', '', 'dept:update', NULL, '1', NULL, '2017-12-27 17:09:24', NULL);
INSERT INTO `t_menu` VALUES (22, 6, '删除部门', '', '', 'dept:delete', NULL, '1', NULL, '2017-12-27 17:09:24', NULL);
INSERT INTO `t_menu` VALUES (24, 10, '删除日志', '', '', 'log:delete', NULL, '1', NULL, '2017-12-27 17:11:45', NULL);
INSERT INTO `t_menu` VALUES (130, 3, '导出Excel', NULL, NULL, 'user:export', NULL, '1', NULL, '2019-01-23 06:35:16', NULL);
INSERT INTO `t_menu` VALUES (131, 4, '导出Excel', NULL, NULL, 'role:export', NULL, '1', NULL, '2019-01-23 06:35:36', NULL);
INSERT INTO `t_menu` VALUES (132, 5, '导出Excel', NULL, NULL, 'menu:export', NULL, '1', NULL, '2019-01-23 06:36:05', NULL);
INSERT INTO `t_menu` VALUES (133, 6, '导出Excel', NULL, NULL, 'dept:export', NULL, '1', NULL, '2019-01-23 06:36:25', NULL);
INSERT INTO `t_menu` VALUES (135, 3, '密码重置', NULL, NULL, 'user:reset', NULL, '1', NULL, '2019-01-23 06:37:00', NULL);
INSERT INTO `t_menu` VALUES (136, 10, '导出Excel', NULL, NULL, 'log:export', NULL, '1', NULL, '2019-01-23 06:37:27', NULL);
INSERT INTO `t_menu` VALUES (150, 2, '登录日志', '/monitor/loginlog', 'febs/monitor/loginlog/Index', 'monitor:loginlog', '', '0', 3, '2019-07-22 13:41:17', '2020-04-13 11:38:08');
INSERT INTO `t_menu` VALUES (151, 150, '删除日志', NULL, NULL, 'loginlog:delete', NULL, '1', NULL, '2019-07-22 13:43:04', NULL);
INSERT INTO `t_menu` VALUES (152, 150, '导出Excel', NULL, NULL, 'loginlog:export', NULL, '1', NULL, '2019-07-22 13:43:30', NULL);
INSERT INTO `t_menu` VALUES (153, 0, '定时任务', '/job', 'Layout', '', 'icon-loop', '0', 3, '2023-10-16 02:19:28', NULL);
INSERT INTO `t_menu` VALUES (154, 153, '定时任务管理', '/job/manage', 'job/job/index', 'job:view', '', '0', 0, '2023-10-16 02:20:00', NULL);
INSERT INTO `t_menu` VALUES (155, 154, '新增', NULL, NULL, 'job:add', NULL, '1', NULL, '2023-10-16 02:21:57', NULL);
INSERT INTO `t_menu` VALUES (156, 154, '更新', NULL, NULL, 'job:update', NULL, '1', NULL, '2023-10-16 02:22:28', NULL);
INSERT INTO `t_menu` VALUES (157, 154, '删除', NULL, NULL, 'job:delete', NULL, '1', NULL, '2023-10-16 02:22:42', NULL);
INSERT INTO `t_menu` VALUES (158, 154, '运行任务', NULL, NULL, 'job:run', NULL, '1', NULL, '2023-10-16 02:22:57', NULL);
INSERT INTO `t_menu` VALUES (159, 154, '暂停任务', NULL, NULL, 'job:pause', NULL, '1', NULL, '2023-10-16 02:23:12', '2023-10-16 02:23:40');
INSERT INTO `t_menu` VALUES (160, 154, '恢复任务', NULL, NULL, 'job:resume', NULL, '1', NULL, '2023-10-16 02:23:30', NULL);
INSERT INTO `t_menu` VALUES (161, 153, '执行日志', '/job/jobLog', 'job/job-log/index', 'job:log:view', '', '0', 1, '2023-10-16 08:16:33', '2023-10-16 08:37:45');
COMMIT;

-- ----------------------------
-- Table structure for t_role
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role` (
  `ROLE_ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `ROLE_NAME` varchar(10) NOT NULL COMMENT '角色名称',
  `REMARK` varchar(100) DEFAULT NULL COMMENT '角色描述',
  `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFY_TIME` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`ROLE_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_role
-- ----------------------------
BEGIN;
INSERT INTO `t_role` VALUES (1, '管理员', '管理员', '2017-12-27 16:23:11', '2023-10-16 08:36:42');
INSERT INTO `t_role` VALUES (4, '测试角色', '', '2020-03-08 19:16:01', '2023-05-31 11:17:56');
COMMIT;

-- ----------------------------
-- Table structure for t_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `t_role_menu`;
CREATE TABLE `t_role_menu` (
  `ROLE_ID` bigint(20) NOT NULL,
  `MENU_ID` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_role_menu
-- ----------------------------
BEGIN;
INSERT INTO `t_role_menu` VALUES (72, 1);
INSERT INTO `t_role_menu` VALUES (72, 3);
INSERT INTO `t_role_menu` VALUES (72, 4);
INSERT INTO `t_role_menu` VALUES (72, 5);
INSERT INTO `t_role_menu` VALUES (72, 6);
INSERT INTO `t_role_menu` VALUES (72, 64);
INSERT INTO `t_role_menu` VALUES (72, 2);
INSERT INTO `t_role_menu` VALUES (72, 8);
INSERT INTO `t_role_menu` VALUES (72, 10);
INSERT INTO `t_role_menu` VALUES (72, 113);
INSERT INTO `t_role_menu` VALUES (72, 121);
INSERT INTO `t_role_menu` VALUES (72, 122);
INSERT INTO `t_role_menu` VALUES (72, 124);
INSERT INTO `t_role_menu` VALUES (72, 123);
INSERT INTO `t_role_menu` VALUES (72, 127);
INSERT INTO `t_role_menu` VALUES (72, 101);
INSERT INTO `t_role_menu` VALUES (72, 102);
INSERT INTO `t_role_menu` VALUES (72, 109);
INSERT INTO `t_role_menu` VALUES (72, 58);
INSERT INTO `t_role_menu` VALUES (72, 59);
INSERT INTO `t_role_menu` VALUES (72, 61);
INSERT INTO `t_role_menu` VALUES (72, 81);
INSERT INTO `t_role_menu` VALUES (72, 82);
INSERT INTO `t_role_menu` VALUES (72, 83);
INSERT INTO `t_role_menu` VALUES (72, 128);
INSERT INTO `t_role_menu` VALUES (72, 129);
INSERT INTO `t_role_menu` VALUES (2, 3);
INSERT INTO `t_role_menu` VALUES (2, 1);
INSERT INTO `t_role_menu` VALUES (2, 4);
INSERT INTO `t_role_menu` VALUES (2, 5);
INSERT INTO `t_role_menu` VALUES (2, 6);
INSERT INTO `t_role_menu` VALUES (2, 64);
INSERT INTO `t_role_menu` VALUES (2, 2);
INSERT INTO `t_role_menu` VALUES (2, 8);
INSERT INTO `t_role_menu` VALUES (2, 10);
INSERT INTO `t_role_menu` VALUES (2, 113);
INSERT INTO `t_role_menu` VALUES (2, 121);
INSERT INTO `t_role_menu` VALUES (2, 122);
INSERT INTO `t_role_menu` VALUES (2, 124);
INSERT INTO `t_role_menu` VALUES (2, 123);
INSERT INTO `t_role_menu` VALUES (2, 125);
INSERT INTO `t_role_menu` VALUES (2, 101);
INSERT INTO `t_role_menu` VALUES (2, 102);
INSERT INTO `t_role_menu` VALUES (2, 109);
INSERT INTO `t_role_menu` VALUES (2, 58);
INSERT INTO `t_role_menu` VALUES (2, 59);
INSERT INTO `t_role_menu` VALUES (2, 61);
INSERT INTO `t_role_menu` VALUES (2, 81);
INSERT INTO `t_role_menu` VALUES (2, 82);
INSERT INTO `t_role_menu` VALUES (2, 83);
INSERT INTO `t_role_menu` VALUES (2, 127);
INSERT INTO `t_role_menu` VALUES (2, 128);
INSERT INTO `t_role_menu` VALUES (2, 129);
INSERT INTO `t_role_menu` VALUES (2, 130);
INSERT INTO `t_role_menu` VALUES (2, 14);
INSERT INTO `t_role_menu` VALUES (2, 17);
INSERT INTO `t_role_menu` VALUES (2, 132);
INSERT INTO `t_role_menu` VALUES (2, 20);
INSERT INTO `t_role_menu` VALUES (2, 133);
INSERT INTO `t_role_menu` VALUES (2, 65);
INSERT INTO `t_role_menu` VALUES (2, 134);
INSERT INTO `t_role_menu` VALUES (2, 136);
INSERT INTO `t_role_menu` VALUES (2, 103);
INSERT INTO `t_role_menu` VALUES (2, 137);
INSERT INTO `t_role_menu` VALUES (2, 138);
INSERT INTO `t_role_menu` VALUES (2, 131);
INSERT INTO `t_role_menu` VALUES (73, 1);
INSERT INTO `t_role_menu` VALUES (73, 3);
INSERT INTO `t_role_menu` VALUES (1, 14);
INSERT INTO `t_role_menu` VALUES (1, 152);
INSERT INTO `t_role_menu` VALUES (1, 10);
INSERT INTO `t_role_menu` VALUES (1, 132);
INSERT INTO `t_role_menu` VALUES (1, 159);
INSERT INTO `t_role_menu` VALUES (1, 135);
INSERT INTO `t_role_menu` VALUES (1, 150);
INSERT INTO `t_role_menu` VALUES (1, 136);
INSERT INTO `t_role_menu` VALUES (1, 18);
INSERT INTO `t_role_menu` VALUES (1, 157);
INSERT INTO `t_role_menu` VALUES (1, 13);
INSERT INTO `t_role_menu` VALUES (1, 133);
INSERT INTO `t_role_menu` VALUES (1, 5);
INSERT INTO `t_role_menu` VALUES (1, 155);
INSERT INTO `t_role_menu` VALUES (1, 11);
INSERT INTO `t_role_menu` VALUES (1, 21);
INSERT INTO `t_role_menu` VALUES (1, 16);
INSERT INTO `t_role_menu` VALUES (1, 153);
INSERT INTO `t_role_menu` VALUES (1, 2);
INSERT INTO `t_role_menu` VALUES (1, 6);
INSERT INTO `t_role_menu` VALUES (1, 160);
INSERT INTO `t_role_menu` VALUES (1, 4);
INSERT INTO `t_role_menu` VALUES (1, 151);
INSERT INTO `t_role_menu` VALUES (1, 1);
INSERT INTO `t_role_menu` VALUES (1, 19);
INSERT INTO `t_role_menu` VALUES (1, 158);
INSERT INTO `t_role_menu` VALUES (1, 130);
INSERT INTO `t_role_menu` VALUES (1, 24);
INSERT INTO `t_role_menu` VALUES (1, 15);
INSERT INTO `t_role_menu` VALUES (1, 17);
INSERT INTO `t_role_menu` VALUES (1, 156);
INSERT INTO `t_role_menu` VALUES (1, 12);
INSERT INTO `t_role_menu` VALUES (1, 22);
INSERT INTO `t_role_menu` VALUES (1, 131);
INSERT INTO `t_role_menu` VALUES (1, 154);
INSERT INTO `t_role_menu` VALUES (1, 3);
INSERT INTO `t_role_menu` VALUES (1, 20);
INSERT INTO `t_role_menu` VALUES (1, 161);
COMMIT;

-- ----------------------------
-- Table structure for t_test
-- ----------------------------
DROP TABLE IF EXISTS `t_test`;
CREATE TABLE `t_test` (
  `FIELD1` varchar(20) NOT NULL,
  `FIELD2` int(11) NOT NULL,
  `FIELD3` varchar(100) NOT NULL,
  `CREATE_TIME` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_test
-- ----------------------------
BEGIN;
INSERT INTO `t_test` VALUES ('字段1', 1, 'mrbird@gmail.com', '2019-01-22 16:26:51');
INSERT INTO `t_test` VALUES ('字段1', 1, 'mrbird0@gmail.com', '2019-01-23 03:01:03');
INSERT INTO `t_test` VALUES ('字段1', 2, 'mrbird1@gmail.com', '2019-01-23 03:01:03');
INSERT INTO `t_test` VALUES ('字段1', 3, 'mrbird2@gmail.com', '2019-01-23 03:01:03');
INSERT INTO `t_test` VALUES ('字段1', 4, 'mrbird3@gmail.com', '2019-01-23 03:01:03');
INSERT INTO `t_test` VALUES ('字段1', 5, 'mrbird4@gmail.com', '2019-01-23 03:01:03');
INSERT INTO `t_test` VALUES ('字段1', 10, 'mrbird9@gmail.com', '2019-01-23 03:01:03');
INSERT INTO `t_test` VALUES ('字段1', 1, 'mrbird0@gmail.com', '2019-01-23 03:03:49');
INSERT INTO `t_test` VALUES ('字段1', 2, 'mrbird1@gmail.com', '2019-01-23 03:03:49');
INSERT INTO `t_test` VALUES ('字段1', 3, 'mrbird2@gmail.com', '2019-01-23 03:03:49');
INSERT INTO `t_test` VALUES ('字段1', 4, 'mrbird3@gmail.com', '2019-01-23 03:03:49');
INSERT INTO `t_test` VALUES ('字段1', 5, 'mrbird4@gmail.com', '2019-01-23 03:03:49');
INSERT INTO `t_test` VALUES ('字段1', 10, 'mrbird9@gmail.com', '2019-01-23 03:03:49');
INSERT INTO `t_test` VALUES ('字段1', 1, 'mrbird0@gmail.com', '2019-01-23 03:07:47');
INSERT INTO `t_test` VALUES ('字段1', 2, 'mrbird1@gmail.com', '2019-01-23 03:07:47');
INSERT INTO `t_test` VALUES ('字段1', 3, 'mrbird2@gmail.com', '2019-01-23 03:07:47');
INSERT INTO `t_test` VALUES ('字段1', 4, 'mrbird3@gmail.com', '2019-01-23 03:07:47');
INSERT INTO `t_test` VALUES ('字段1', 5, 'mrbird4@gmail.com', '2019-01-23 03:07:47');
INSERT INTO `t_test` VALUES ('字段1', 6, 'mrbird5@gmail.com', '2019-01-23 03:07:47');
INSERT INTO `t_test` VALUES ('字段1', 1, 'mrbird0@gmail.com', '2019-01-23 03:08:09');
INSERT INTO `t_test` VALUES ('字段1', 2, 'mrbird1@gmail.com', '2019-01-23 03:08:09');
INSERT INTO `t_test` VALUES ('字段1', 3, 'mrbird2@gmail.com', '2019-01-23 03:08:09');
INSERT INTO `t_test` VALUES ('字段1', 4, 'mrbird3@gmail.com', '2019-01-23 03:08:09');
INSERT INTO `t_test` VALUES ('字段1', 5, 'mrbird4@gmail.com', '2019-01-23 03:08:09');
INSERT INTO `t_test` VALUES ('字段1', 10, 'mrbird9@gmail.com', '2019-01-23 03:08:09');
INSERT INTO `t_test` VALUES ('字段1', 1, 'mrbird0@gmail.com', '2019-01-23 03:19:52');
INSERT INTO `t_test` VALUES ('字段1', 2, 'mrbird1@gmail.com', '2019-01-23 03:19:52');
INSERT INTO `t_test` VALUES ('字段1', 3, 'mrbird2@gmail.com', '2019-01-23 03:19:52');
INSERT INTO `t_test` VALUES ('字段1', 4, 'mrbird3@gmail.com', '2019-01-23 03:19:52');
INSERT INTO `t_test` VALUES ('字段1', 5, 'mrbird4@gmail.com', '2019-01-23 03:19:52');
INSERT INTO `t_test` VALUES ('字段1', 6, 'mrbird5@gmail.com', '2019-01-23 03:19:52');
INSERT INTO `t_test` VALUES ('字段1', 1, 'mrbird0@gmail.com', '2019-01-23 03:20:56');
INSERT INTO `t_test` VALUES ('字段1', 2, 'mrbird1@gmail.com', '2019-01-23 03:20:56');
INSERT INTO `t_test` VALUES ('字段1', 3, 'mrbird2@gmail.com', '2019-01-23 03:20:56');
INSERT INTO `t_test` VALUES ('字段1', 4, 'mrbird3@gmail.com', '2019-01-23 03:20:56');
INSERT INTO `t_test` VALUES ('字段1', 5, 'mrbird4@gmail.com', '2019-01-23 03:20:56');
INSERT INTO `t_test` VALUES ('字段1', 6, 'mrbird5@gmail.com', '2019-01-23 03:20:56');
INSERT INTO `t_test` VALUES ('字段1', 1, 'mrbird0@gmail.com', '2019-01-23 06:12:38');
INSERT INTO `t_test` VALUES ('字段1', 2, 'mrbird1@gmail.com', '2019-01-23 06:12:38');
INSERT INTO `t_test` VALUES ('字段1', 3, 'mrbird2@gmail.com', '2019-01-23 06:12:38');
INSERT INTO `t_test` VALUES ('字段1', 4, 'mrbird3@gmail.com', '2019-01-23 06:12:38');
INSERT INTO `t_test` VALUES ('字段1', 5, 'mrbird4@gmail.com', '2019-01-23 06:12:38');
INSERT INTO `t_test` VALUES ('字段1', 6, 'mrbird5@gmail.com', '2019-01-23 06:12:38');
INSERT INTO `t_test` VALUES ('字段1', 7, 'mrbird6@gmail.com', '2019-01-23 06:12:38');
INSERT INTO `t_test` VALUES ('字段1', 8, 'mrbird7@gmail.com', '2019-01-23 06:12:38');
INSERT INTO `t_test` VALUES ('字段1', 9, 'mrbird8@gmail.com', '2019-01-23 06:12:38');
INSERT INTO `t_test` VALUES ('字段1', 11, 'mrbird10@gmail.com', '2019-01-23 06:12:38');
INSERT INTO `t_test` VALUES ('字段1', 12, 'mrbird11@gmail.com', '2019-01-23 06:12:38');
INSERT INTO `t_test` VALUES ('字段1', 14, 'mrbird13@gmail.com', '2019-01-23 06:12:38');
INSERT INTO `t_test` VALUES ('字段1', 15, 'mrbird14@gmail.com', '2019-01-23 06:12:38');
INSERT INTO `t_test` VALUES ('字段1', 16, 'mrbird15@gmail.com', '2019-01-23 06:12:38');
INSERT INTO `t_test` VALUES ('字段1', 18, 'mrbird17@gmail.com', '2019-01-23 06:12:38');
INSERT INTO `t_test` VALUES ('字段1', 19, 'mrbird18@gmail.com', '2019-01-23 06:12:38');
INSERT INTO `t_test` VALUES ('字段1', 20, 'mrbird19@gmail.com', '2019-01-23 06:12:38');
COMMIT;

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `USER_ID` bigint(10) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `USERNAME` varchar(50) NOT NULL COMMENT '用户名',
  `PASSWORD` varchar(128) NOT NULL COMMENT '密码',
  `DEPT_ID` bigint(20) DEFAULT NULL COMMENT '部门ID',
  `EMAIL` varchar(128) DEFAULT NULL COMMENT '邮箱',
  `MOBILE` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `STATUS` char(1) NOT NULL COMMENT '状态 0锁定 1有效',
  `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
  `MODIFY_TIME` datetime DEFAULT NULL COMMENT '修改时间',
  `LAST_LOGIN_TIME` datetime DEFAULT NULL COMMENT '最近访问时间',
  `SEX` char(1) DEFAULT NULL COMMENT '性别 0男 1女 2保密',
  `DESCRIPTION` varchar(100) DEFAULT NULL COMMENT '描述',
  `AVATAR` varchar(100) DEFAULT NULL COMMENT '用户头像',
  `REAL_NAME` varchar(20) DEFAULT NULL COMMENT '真实姓名',
  PRIMARY KEY (`USER_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_user
-- ----------------------------
BEGIN;
INSERT INTO `t_user` VALUES (1, 'mrbird', '$2a$10$PLlkFvSIJeym3Sky.xpmzerFeVgQSyVGZkittMjnG8Ot7esxay.3a', 2, 'mrbird123@hotmail.com', '13455533233', '1', '2017-12-27 15:47:19', '2023-10-13 07:27:45', '2023-10-13 07:27:20', '0', '我是帅比作者。', 'default.jpg', '阿鸟');
COMMIT;

-- ----------------------------
-- Table structure for t_user_config
-- ----------------------------
DROP TABLE IF EXISTS `t_user_config`;
CREATE TABLE `t_user_config` (
  `USER_ID` bigint(20) NOT NULL COMMENT '用户ID',
  `THEME` varchar(10) DEFAULT NULL COMMENT '系统主题 dark暗色风格，light明亮风格',
  `LAYOUT` varchar(10) DEFAULT NULL COMMENT '系统布局 side侧边栏，head顶部栏',
  `MULTI_PAGE` char(1) DEFAULT NULL COMMENT '页面风格 1多标签页 0单页',
  `FIX_SIDERBAR` char(1) DEFAULT NULL COMMENT '页面滚动是否固定侧边栏 1固定 0不固定',
  `FIX_HEADER` char(1) DEFAULT NULL COMMENT '页面滚动是否固定顶栏 1固定 0不固定',
  `COLOR` varchar(20) DEFAULT NULL COMMENT '主题颜色 RGB值',
  PRIMARY KEY (`USER_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_user_config
-- ----------------------------
BEGIN;
INSERT INTO `t_user_config` VALUES (1, 'light', 'side', '0', '1', '1', 'rgb(66, 185, 131)');
INSERT INTO `t_user_config` VALUES (2, 'light', 'side', '0', '1', '1', 'rgb(24, 144, 255)');
INSERT INTO `t_user_config` VALUES (12, 'dark', 'side', '1', '1', '1', 'rgb(66, 185, 131)');
COMMIT;

-- ----------------------------
-- Table structure for t_user_role
-- ----------------------------
DROP TABLE IF EXISTS `t_user_role`;
CREATE TABLE `t_user_role` (
  `USER_ID` bigint(20) NOT NULL COMMENT '用户ID',
  `ROLE_ID` bigint(20) NOT NULL COMMENT '角色ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_user_role
-- ----------------------------
BEGIN;
INSERT INTO `t_user_role` VALUES (2, 2);
INSERT INTO `t_user_role` VALUES (12, 72);
INSERT INTO `t_user_role` VALUES (1, 1);
COMMIT;

-- ----------------------------
-- Function structure for findDeptChildren
-- ----------------------------
DROP FUNCTION IF EXISTS `findDeptChildren`;
delimiter ;;
CREATE FUNCTION `findDeptChildren`(rootId INT)
 RETURNS varchar(4000) CHARSET utf8
BEGIN
  DECLARE sTemp VARCHAR(4000);
    DECLARE sTempChd VARCHAR(4000);
    SET sTemp = '$';
    SET sTempChd = CAST(rootId as CHAR);
    WHILE sTempChd is not null DO
    SET sTemp = CONCAT(sTemp,',',sTempChd);
    SELECT GROUP_CONCAT(dept_id) INTO sTempChd FROM t_dept
    WHERE FIND_IN_SET(parent_id,sTempChd)>0;
END WHILE;
RETURN sTemp;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for findMenuChildren
-- ----------------------------
DROP FUNCTION IF EXISTS `findMenuChildren`;
delimiter ;;
CREATE FUNCTION `findMenuChildren`(rootId INT)
 RETURNS varchar(4000) CHARSET utf8
BEGIN
  DECLARE sTemp VARCHAR(4000);
    DECLARE sTempChd VARCHAR(4000);
    SET sTemp = '$';
    SET sTempChd = CAST(rootId as CHAR);
    WHILE sTempChd is not null DO
    SET sTemp = CONCAT(sTemp,',',sTempChd);
    SELECT GROUP_CONCAT(menu_id) INTO sTempChd FROM t_menu
    WHERE FIND_IN_SET(parent_id,sTempChd)>0;
END WHILE;
RETURN sTemp;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
