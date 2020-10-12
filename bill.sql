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

 Date: 12/10/2020 08:52:19
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
INSERT INTO `class` VALUES ('14051248', '负债', 'icon-fuzhaibiao', '1');
INSERT INTO `class` VALUES ('14273160', '美容美发', 'icon-meirongmeifa', '1');
INSERT INTO `class` VALUES ('1927451', '宠物', 'icon-chongwu', '1');
INSERT INTO `class` VALUES ('2695764', '礼物', 'icon-liwu1', '1');
INSERT INTO `class` VALUES ('2972336', '收益', 'icon-shouyi', '0');
INSERT INTO `class` VALUES ('3547583', '股票', 'icon-gupiao', '1');
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

-- ----------------------------
-- Table structure for families
-- ----------------------------
DROP TABLE IF EXISTS `families`;
CREATE TABLE `families`  (
  `openid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '家人身份标识',
  `nickName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `avatarUrl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `famNum` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '家庭号',
  `famName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '家庭名称',
  `date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '家庭创建/加入时间'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of families
-- ----------------------------
INSERT INTO `families` VALUES ('oAKXk5E5tWUfI15RJBl1ryFUkBkE', '%E5%94%94%E5%97%AF%E6%96%87', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJTpxCSZE9p6FxUXhjYMbpRibaFGJAHudFTglPibARCGeyTpxrShsmScGVlRWpqVkXHqHMZicxY08qlg/132', 'k1DACi', '唐宋八大家', '2020-09-09T01:06:02.689Z');
INSERT INTO `families` VALUES ('oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', 'SSmVu9', '欢乐颂', '2020-09-09T01:14:55.221Z');

-- ----------------------------
-- Table structure for families_bill
-- ----------------------------
DROP TABLE IF EXISTS `families_bill`;
CREATE TABLE `families_bill`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '账务id 不重复随机数',
  `famNum` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '家庭号',
  `openid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '记账者id',
  `nickName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '记账者姓名',
  `avatarUrl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '记账者头像',
  `date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '账务记录时间',
  `billsub` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '账务记录内容',
  `spend` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '账务花费',
  `classid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '账务类别id'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of families_bill
-- ----------------------------
INSERT INTO `families_bill` VALUES ('UpIcUJVdoc', 'SSmVu9', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-09-14 16:14', '姐姐红包', '300', '13371778');
INSERT INTO `families_bill` VALUES ('R20Daz7nTI', 'SSmVu9', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-09-14 16:14', '', '3000', '4388881');
INSERT INTO `families_bill` VALUES ('I4qxyOKkpR', 'SSmVu9', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-09-14 16:30', '秋季外套', '-200', '9492507');
INSERT INTO `families_bill` VALUES ('deU20yBJ9n', 'SSmVu9', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-09-16 09:20', '妈妈送的纪念品转卖', '300', '13232166');
INSERT INTO `families_bill` VALUES ('xutb4RjTAE', 'SSmVu9', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-09-16 09:24', '感冒药', '-100', '935288');
INSERT INTO `families_bill` VALUES ('krsLt4JGCV', 'SSmVu9', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-09-17 09:21', '洗衣液', '-60', '3747613');
INSERT INTO `families_bill` VALUES ('SwTMCDZTqH', 'SSmVu9', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-09-17 09:37', '爸爸红包', '200', '13371778');
INSERT INTO `families_bill` VALUES ('0gcslx3HrZ', 'SSmVu9', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-09-17 09:37', '优优生日礼物，十万个为什么', '-106', '2695764');
INSERT INTO `families_bill` VALUES ('IyFd3K1wrk', 'SSmVu9', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-09-18 08:56', '口罩', '-2.4', '935288');
INSERT INTO `families_bill` VALUES ('S1cD8wJODl', 'SSmVu9', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-09-18 08:57', '', '-20', '3979183');
INSERT INTO `families_bill` VALUES ('n38fqpPSnz', 'k1DACi', 'oAKXk5E5tWUfI15RJBl1ryFUkBkE', '%E5%94%94%E5%97%AF%E6%96%87', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJTpxCSZE9p6FxUXhjYMbpRibaFGJAHudFTglPibARCGeyTpxrShsmScGVlRWpqVkXHqHMZicxY08qlg/132', '2020-09-18 16:49', '', '6000', '4388881');
INSERT INTO `families_bill` VALUES ('l4xamWcxt0', 'k1DACi', 'oAKXk5E5tWUfI15RJBl1ryFUkBkE', '%E5%94%94%E5%97%AF%E6%96%87', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJTpxCSZE9p6FxUXhjYMbpRibaFGJAHudFTglPibARCGeyTpxrShsmScGVlRWpqVkXHqHMZicxY08qlg/132', '2020-09-18 16:54', '连衣裙', '-500', '9492507');
INSERT INTO `families_bill` VALUES ('JA2xoGv5P2', 'k1DACi', 'oAKXk5E5tWUfI15RJBl1ryFUkBkE', '%E5%94%94%E5%97%AF%E6%96%87', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJTpxCSZE9p6FxUXhjYMbpRibaFGJAHudFTglPibARCGeyTpxrShsmScGVlRWpqVkXHqHMZicxY08qlg/132', '2020-09-18 16:57', '游戏充值', '-100', '8242259');
INSERT INTO `families_bill` VALUES ('r8nZD1sgWE', 'k1DACi', 'oAKXk5E5tWUfI15RJBl1ryFUkBkE', '%E5%94%94%E5%97%AF%E6%96%87', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJTpxCSZE9p6FxUXhjYMbpRibaFGJAHudFTglPibARCGeyTpxrShsmScGVlRWpqVkXHqHMZicxY08qlg/132', '2020-09-18 16:58', '', '-50', '4943826');
INSERT INTO `families_bill` VALUES ('7dwqc3GzBT', 'k1DACi', 'oAKXk5E5tWUfI15RJBl1ryFUkBkE', '%E5%94%94%E5%97%AF%E6%96%87', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJTpxCSZE9p6FxUXhjYMbpRibaFGJAHudFTglPibARCGeyTpxrShsmScGVlRWpqVkXHqHMZicxY08qlg/132', '2020-09-18 17:00', '公交卡充值', '-50', '3979186');
INSERT INTO `families_bill` VALUES ('DvBmGmsgbf', 'k1DACi', 'oAKXk5E5tWUfI15RJBl1ryFUkBkE', '%E5%94%94%E5%97%AF%E6%96%87', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJTpxCSZE9p6FxUXhjYMbpRibaFGJAHudFTglPibARCGeyTpxrShsmScGVlRWpqVkXHqHMZicxY08qlg/132', '2020-09-21 09:11', '鑫鑫红包', '200', '13371778');
INSERT INTO `families_bill` VALUES ('7707ydxKdm', 'SSmVu9', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-09-23 16:00', '外套加牛仔裤', '-500', '9492507');
INSERT INTO `families_bill` VALUES ('iIxNZhM7hn', 'SSmVu9', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-09-24 10:24', '花呗', '-1000', '14051248');
INSERT INTO `families_bill` VALUES ('hOOkvFZuvj', 'SSmVu9', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-09-24 11:19', '利息提现', '2000', '2972336');
INSERT INTO `families_bill` VALUES ('ic14xsNlWH', 'SSmVu9', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-09-28 10:56', '只有水费和燃气费', '-50', '4943826');
INSERT INTO `families_bill` VALUES ('RfMmeNpdJ7', 'SSmVu9', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-10-09 09:13', '10月', '2000', '4388881');
INSERT INTO `families_bill` VALUES ('XUvqLXuNm6', 'SSmVu9', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-10-09 09:13', '衣服', '-270', '9492507');
INSERT INTO `families_bill` VALUES ('leIMlOVjHB', 'SSmVu9', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-10-09 09:14', '拔牙', '-300', '935288');
INSERT INTO `families_bill` VALUES ('j1gpUobY28', 'SSmVu9', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-10-10 09:32', '早餐', '-5', '10048033');
INSERT INTO `families_bill` VALUES ('JH9O8oJPG9', 'k1DACi', 'oAKXk5E5tWUfI15RJBl1ryFUkBkE', '%E5%94%94%E5%97%AF%E6%96%87', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJTpxCSZE9p6FxUXhjYMbpRibaFGJAHudFTglPibARCGeyTpxrShsmScGoAH0T7CLeyJBu4Uk9HY3cw/132', '2020-10-10 16:05', '题库', '-200', '7762852');

-- ----------------------------
-- Table structure for home
-- ----------------------------
DROP TABLE IF EXISTS `home`;
CREATE TABLE `home`  (
  `openid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '家庭户主标识',
  `nickName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `avatarUrl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `famNum` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '家庭号',
  `famName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`openid`, `famNum`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of home
-- ----------------------------
INSERT INTO `home` VALUES ('oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', 'SSmVu9', '欢乐颂', '2020-09-09T01:14:55.221Z');
INSERT INTO `home` VALUES ('oAKXk5E5tWUfI15RJBl1ryFUkBkE', '%E5%94%94%E5%97%AF%E6%96%87', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJTpxCSZE9p6FxUXhjYMbpRibaFGJAHudFTglPibARCGeyTpxrShsmScGVlRWpqVkXHqHMZicxY08qlg/132', 'k1DACi', '唐宋八大家', '2020-09-09T01:06:02.689Z');

-- ----------------------------
-- Table structure for person_bill
-- ----------------------------
DROP TABLE IF EXISTS `person_bill`;
CREATE TABLE `person_bill`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '账务id 不重复随机数',
  `openid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '记账者id',
  `nickName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '记账者姓名',
  `avatarUrl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '记账者头像',
  `date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '账务记录时间',
  `billsub` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '账务记录内容',
  `spend` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '账务花费',
  `classid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '账务类别id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of person_bill
-- ----------------------------
INSERT INTO `person_bill` VALUES ('0gcslx3HrZ', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-09-17 09:37', '优优生日礼物，十万个为什么', '-106', '2695764');
INSERT INTO `person_bill` VALUES ('7707ydxKdm', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-09-23 16:00', '外套加牛仔裤', '-500', '9492507');
INSERT INTO `person_bill` VALUES ('7dwqc3GzBT', 'oAKXk5E5tWUfI15RJBl1ryFUkBkE', '%E5%94%94%E5%97%AF%E6%96%87', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJTpxCSZE9p6FxUXhjYMbpRibaFGJAHudFTglPibARCGeyTpxrShsmScGVlRWpqVkXHqHMZicxY08qlg/132', '2020-09-18 17:00', '公交卡充值', '-50', '3979186');
INSERT INTO `person_bill` VALUES ('deU20yBJ9n', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-09-16 09:20', '妈妈送的纪念品转卖', '300', '13232166');
INSERT INTO `person_bill` VALUES ('DvBmGmsgbf', 'oAKXk5E5tWUfI15RJBl1ryFUkBkE', '%E5%94%94%E5%97%AF%E6%96%87', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJTpxCSZE9p6FxUXhjYMbpRibaFGJAHudFTglPibARCGeyTpxrShsmScGVlRWpqVkXHqHMZicxY08qlg/132', '2020-09-21 09:11', '鑫鑫红包', '200', '13371778');
INSERT INTO `person_bill` VALUES ('hOOkvFZuvj', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-09-24 11:19', '利息提现', '2000', '2972336');
INSERT INTO `person_bill` VALUES ('I4qxyOKkpR', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-09-14 16:30', '秋季外套', '-200', '9492507');
INSERT INTO `person_bill` VALUES ('ic14xsNlWH', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-09-28 10:56', '只有水费和燃气费', '-50', '4943826');
INSERT INTO `person_bill` VALUES ('iIxNZhM7hn', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-09-24 10:24', '花呗', '-1000', '14051248');
INSERT INTO `person_bill` VALUES ('IyFd3K1wrk', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-09-18 08:56', '口罩', '-2.4', '935288');
INSERT INTO `person_bill` VALUES ('j1gpUobY28', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-10-10 09:32', '早餐', '-5', '10048033');
INSERT INTO `person_bill` VALUES ('JA2xoGv5P2', 'oAKXk5E5tWUfI15RJBl1ryFUkBkE', '%E5%94%94%E5%97%AF%E6%96%87', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJTpxCSZE9p6FxUXhjYMbpRibaFGJAHudFTglPibARCGeyTpxrShsmScGVlRWpqVkXHqHMZicxY08qlg/132', '2020-09-18 16:57', '游戏充值', '-100', '8242259');
INSERT INTO `person_bill` VALUES ('JH9O8oJPG9', 'oAKXk5E5tWUfI15RJBl1ryFUkBkE', '%E5%94%94%E5%97%AF%E6%96%87', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJTpxCSZE9p6FxUXhjYMbpRibaFGJAHudFTglPibARCGeyTpxrShsmScGoAH0T7CLeyJBu4Uk9HY3cw/132', '2020-10-10 16:05', '题库', '-200', '7762852');
INSERT INTO `person_bill` VALUES ('krsLt4JGCV', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-09-17 09:21', '洗衣液', '-60', '3747613');
INSERT INTO `person_bill` VALUES ('l4xamWcxt0', 'oAKXk5E5tWUfI15RJBl1ryFUkBkE', '%E5%94%94%E5%97%AF%E6%96%87', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJTpxCSZE9p6FxUXhjYMbpRibaFGJAHudFTglPibARCGeyTpxrShsmScGVlRWpqVkXHqHMZicxY08qlg/132', '2020-09-18 16:54', '连衣裙', '-500', '9492507');
INSERT INTO `person_bill` VALUES ('leIMlOVjHB', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-10-09 09:14', '拔牙', '-300', '935288');
INSERT INTO `person_bill` VALUES ('n38fqpPSnz', 'oAKXk5E5tWUfI15RJBl1ryFUkBkE', '%E5%94%94%E5%97%AF%E6%96%87', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJTpxCSZE9p6FxUXhjYMbpRibaFGJAHudFTglPibARCGeyTpxrShsmScGVlRWpqVkXHqHMZicxY08qlg/132', '2020-09-18 16:49', '', '6000', '4388881');
INSERT INTO `person_bill` VALUES ('R20Daz7nTI', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-09-14 16:14', '', '3000', '4388881');
INSERT INTO `person_bill` VALUES ('r8nZD1sgWE', 'oAKXk5E5tWUfI15RJBl1ryFUkBkE', '%E5%94%94%E5%97%AF%E6%96%87', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJTpxCSZE9p6FxUXhjYMbpRibaFGJAHudFTglPibARCGeyTpxrShsmScGVlRWpqVkXHqHMZicxY08qlg/132', '2020-09-18 16:58', '', '-50', '4943826');
INSERT INTO `person_bill` VALUES ('RfMmeNpdJ7', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-10-09 09:13', '10月', '2000', '4388881');
INSERT INTO `person_bill` VALUES ('S1cD8wJODl', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-09-18 08:57', '', '-20', '3979183');
INSERT INTO `person_bill` VALUES ('SwTMCDZTqH', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-09-17 09:37', '爸爸红包', '200', '13371778');
INSERT INTO `person_bill` VALUES ('UpIcUJVdoc', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-09-14 16:14', '姐姐红包', '300', '13371778');
INSERT INTO `person_bill` VALUES ('xutb4RjTAE', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-09-16 09:24', '感冒药', '-100', '935288');
INSERT INTO `person_bill` VALUES ('XUvqLXuNm6', 'oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132', '2020-10-09 09:13', '衣服', '-270', '9492507');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `openid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nickName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `avatarUrl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`openid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('oAKXk5E_yGh2g-spx2mdZCqLEA2M', '%E5%91%BC%E5%99%9C%E5%91%BC%E5%99%9C', 'https://thirdwx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKrd422XMYFTS2d5U31iaJQJNLhmkolibWD9HhnIrfQfvs2ch1rIq2Qge7TxOyMny1tb9ia9PicKbOiblbQ/132');
INSERT INTO `user` VALUES ('oAKXk5E5tWUfI15RJBl1ryFUkBkE', '%E5%94%94%E5%97%AF%E6%96%87', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJTpxCSZE9p6FxUXhjYMbpRibaFGJAHudFTglPibARCGeyTpxrShsmScGVlRWpqVkXHqHMZicxY08qlg/132');

SET FOREIGN_KEY_CHECKS = 1;
