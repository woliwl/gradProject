/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80021
 Source Host           : localhost:3306
 Source Schema         : bill

 Target Server Type    : MySQL
 Target Server Version : 80021
 File Encoding         : 65001

 Date: 15/10/2020 16:17:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for class
-- ----------------------------
DROP TABLE IF EXISTS `class`;
CREATE TABLE `class`  (
  `icon_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `font_class` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `quality` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`icon_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of class
-- ----------------------------
INSERT INTO `class` VALUES ('0', '其它', 'icon-qita', '0');
INSERT INTO `class` VALUES ('1', '其它', 'icon-qita', '1');
INSERT INTO `class` VALUES ('10048033', '餐饮', 'icon-canyin', '1');
INSERT INTO `class` VALUES ('10215403', '红包', 'icon-hongbao', '1');
INSERT INTO `class` VALUES ('10463154', '买菜', 'icon-maicai', '1');
INSERT INTO `class` VALUES ('11366697', '兼职', 'icon-jianzhi', '0');
INSERT INTO `class` VALUES ('13232166', '礼物', 'icon-liwu2', '0');
INSERT INTO `class` VALUES ('13371778', '红包', 'icon-hongbao1', '0');
INSERT INTO `class` VALUES ('13894303', '老人', 'icon-laoren', '1');
INSERT INTO `class` VALUES ('14047410', '教育', 'icon-jiaoyu', '1');
INSERT INTO `class` VALUES ('14051248', '债务', 'icon-fuzhaibiao', '-1');
INSERT INTO `class` VALUES ('14273160', '美容美发', 'icon-meirongmeifa', '1');
INSERT INTO `class` VALUES ('1927451', '宠物', 'icon-chongwu', '1');
INSERT INTO `class` VALUES ('2695764', '礼物', 'icon-liwu1', '1');
INSERT INTO `class` VALUES ('2972336', '收益', 'icon-shouyi', '0');
INSERT INTO `class` VALUES ('3747613', '生活用品', 'icon-shyp', '1');
INSERT INTO `class` VALUES ('3979172', '房租', 'icon-fangzu', '1');
INSERT INTO `class` VALUES ('3979183', '零食', 'icon-lingshi', '1');
INSERT INTO `class` VALUES ('3979186', '交通', 'icon-jiaotong', '1');
INSERT INTO `class` VALUES ('3979421', '运动', 'icon-yundong', '1');
INSERT INTO `class` VALUES ('4388881', '工资', 'icon-gongzi', '0');
INSERT INTO `class` VALUES ('43974', '家电', 'icon-jiadian', '1');
INSERT INTO `class` VALUES ('4757633', '贷款', 'icon-daikuan', '1');
INSERT INTO `class` VALUES ('4943826', '水电', 'icon-shuidian', '1');
INSERT INTO `class` VALUES ('578012', '理财', 'icon-licai', '1');
INSERT INTO `class` VALUES ('675133', '母婴', 'icon-imuying', '1');
INSERT INTO `class` VALUES ('7367512', '旅游', 'icon-lvyou', '1');
INSERT INTO `class` VALUES ('7762852', '学习', 'icon-xuexi', '1');
INSERT INTO `class` VALUES ('8242259', '娱乐', 'icon-yule', '1');
INSERT INTO `class` VALUES ('876112', '数码', 'icon-shuma', '1');
INSERT INTO `class` VALUES ('935288', '医疗', 'icon-yiliao', '1');
INSERT INTO `class` VALUES ('9492507', '服饰', 'icon-clothes', '1');

SET FOREIGN_KEY_CHECKS = 1;
