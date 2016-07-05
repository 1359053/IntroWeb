/*
Navicat MySQL Data Transfer

Source Server         : MySQL
Source Server Version : 50621
Source Host           : localhost:3306
Source Database       : productshop

Target Server Type    : MYSQL
Target Server Version : 50621
File Encoding         : 65001

Date: 2015-06-26 16:34:38
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `idCart` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `idCus` varchar(50) CHARACTER SET utf8 NOT NULL,
  `payStatus` varchar(10) COLLATE utf8_unicode_ci DEFAULT 'UNPAID',
  `delStatus` varchar(10) COLLATE utf8_unicode_ci DEFAULT 'NOT YET',
  `address` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `receiver` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `orderDateTime` datetime DEFAULT NULL,
  `delDateTime` datetime DEFAULT NULL,
  `totalPrice` double(11,0) DEFAULT NULL,
  `phoneNumber` varchar(11) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postcode` varchar(11) COLLATE utf8_unicode_ci DEFAULT NULL,
  `payDateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`idCart`),
  KEY `fk_cart_customer_idcus` (`idCus`),
  CONSTRAINT `fk_idcus_cart_user` FOREIGN KEY (`idCus`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES ('00047', 'dhs', 'PAID', 'DELIVERED', '123 Đường 109, Phước Long B, Quận 9, TP.HCM', 'Son Dang', '2015-06-06 22:40:43', '2015-06-26 07:44:09', '9890000', '0988881141', null, '2015-06-06 22:40:43');
INSERT INTO `cart` VALUES ('00060', 'dhs', 'PAID', 'NOT YET', '123 Đường 109, Phước Long B, Quận 9, TP.HCM', 'Son Dang', '2015-06-07 00:05:40', null, '23380000', '0988881141', null, '2015-06-26 15:33:21');
INSERT INTO `cart` VALUES ('00062', 'dhs', 'UNPAID', 'NOT YET', '123 Đường 109, Phước Long B, Quận 9, TP.HCM', 'Son Dang', '2015-06-07 00:07:39', null, '116900000', '0988881141', null, null);
INSERT INTO `cart` VALUES ('00063', 'dhs', 'UNPAID', 'NOT YET', '123 Đường 109, Phước Long B, Quận 9, TP.HCM', 'Son Dang', '2015-06-07 00:08:11', null, '35070000', '0988881141', null, null);
INSERT INTO `cart` VALUES ('00064', 'dhs', 'UNPAID', 'NOT YET', '123 Đường 109, Phước Long B, Quận 9, TP.HCM', 'Son Dang', '2015-06-07 11:44:11', null, '35070000', '0988881141', null, null);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `catId` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `catName` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`catId`),
  KEY `catId` (`catId`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('001', 'Premium');
INSERT INTO `category` VALUES ('002', 'Basic');
INSERT INTO `category` VALUES ('003', 'Business');
INSERT INTO `category` VALUES ('004', 'Professional');
INSERT INTO `category` VALUES ('016', 'Gaming');

-- ----------------------------
-- Table structure for detail
-- ----------------------------
DROP TABLE IF EXISTS `detail`;
CREATE TABLE `detail` (
  `idCart` int(5) unsigned NOT NULL,
  `sku` int(5) unsigned NOT NULL,
  `quantity` int(3) unsigned NOT NULL,
  PRIMARY KEY (`idCart`,`sku`),
  KEY `fk_detail_laptop_idlap` (`sku`),
  KEY `fk_detail_cart_idcart` (`idCart`),
  CONSTRAINT `fk_detail_cart_idcart` FOREIGN KEY (`idCart`) REFERENCES `cart` (`idCart`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_detail_product_sku` FOREIGN KEY (`sku`) REFERENCES `product` (`sku`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of detail
-- ----------------------------
INSERT INTO `detail` VALUES ('83', '11', '5');
INSERT INTO `detail` VALUES ('88', '27', '4');
INSERT INTO `detail` VALUES ('89', '8', '1');
INSERT INTO `detail` VALUES ('93', '8', '3');
INSERT INTO `detail` VALUES ('93', '13', '7');

-- ----------------------------
-- Table structure for import
-- ----------------------------
DROP TABLE IF EXISTS `import`;
CREATE TABLE `import` (
  `sku` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `importDateTime` datetime NOT NULL,
  `quantity` int(4) unsigned DEFAULT NULL,
  `unitPrice` double(11,2) unsigned DEFAULT NULL,
  PRIMARY KEY (`sku`,`importDateTime`),
  CONSTRAINT `fk_import_product_sku` FOREIGN KEY (`sku`) REFERENCES `product` (`sku`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of import
-- ----------------------------
INSERT INTO `import` VALUES ('008', '2015-05-20 17:07:14', '2', '5990000.00');
INSERT INTO `import` VALUES ('009', '2015-05-20 17:07:14', '0', '11990000.00');
INSERT INTO `import` VALUES ('011', '2015-05-20 17:07:14', '12', '7490000.00');
INSERT INTO `import` VALUES ('012', '2015-05-20 17:07:14', '31', '12990000.00');
INSERT INTO `import` VALUES ('013', '2015-05-20 17:07:14', '12', '16990000.00');

-- ----------------------------
-- Table structure for manufacturer
-- ----------------------------
DROP TABLE IF EXISTS `manufacturer`;
CREATE TABLE `manufacturer` (
  `manId` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `manName` varchar(50) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`manId`),
  KEY `manId` (`manId`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of manufacturer
-- ----------------------------
INSERT INTO `manufacturer` VALUES ('001', 'ASUS');
INSERT INTO `manufacturer` VALUES ('002', 'DELL');
INSERT INTO `manufacturer` VALUES ('003', 'HP');
INSERT INTO `manufacturer` VALUES ('004', 'LENOVO');
INSERT INTO `manufacturer` VALUES ('005', 'ACER');

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `sku` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `catId` int(3) unsigned NOT NULL,
  `manId` int(3) unsigned NOT NULL,
  `name` varchar(40) CHARACTER SET utf8 NOT NULL,
  `processor` varchar(60) CHARACTER SET utf8 DEFAULT NULL,
  `ram` int(5) unsigned DEFAULT NULL,
  `screen` double(5,2) unsigned DEFAULT NULL,
  `hdd` int(5) unsigned DEFAULT NULL,
  `picture` varchar(70) CHARACTER SET utf8 DEFAULT '',
  `unitPrice` double(11,2) unsigned DEFAULT NULL,
  PRIMARY KEY (`sku`),
  KEY `fk_product_category_catid` (`catId`),
  KEY `fk_product_manufacturer_manid` (`manId`),
  CONSTRAINT `fk_product_category_catid` FOREIGN KEY (`catId`) REFERENCES `category` (`catId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_product_manufacturer_manid` FOREIGN KEY (`manId`) REFERENCES `manufacturer` (`manId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES ('00008', '2', '1', 'ASUS X453MA', 'Intel, Celeron, N2830, 2.16 GHz', '2', '15.60', '500', 'asus-x453ma-nowatermark-200x200.jpg', '5990000.00');
INSERT INTO `product` VALUES ('00009', '2', '1', 'ASUS K451LA', 'Intel, Core i3 Haswell, 4010U, 1.70 GHz', '4', '14.00', '500', '300-asus-k451la-wx092h-nowatermark-200x200.jpg', '11990000.00');
INSERT INTO `product` VALUES ('00011', '2', '1', 'ASUS X453MA', 'Intel, Pentium, N3540, 2.16 GHz', '2', '14.00', '500', 'asus-x453ma-celeron-n3540-win8-nowatermark-200x200.jpg', '7490000.00');
INSERT INTO `product` VALUES ('00012', '1', '2', 'Dell Inspiron 3442', 'Intel, Core i5 Haswell, 4210U, 1.70 GHz', '4', '14.00', '1000', 'dell-inspiron-3442-54214g1t-01-nowatermark-200x200.jpg', '12990000.00');
INSERT INTO `product` VALUES ('00013', '1', '2', 'Dell Inspiron 3541', 'Intel, Core i7 Haswell, 4510U, 2.00 GHz', '4', '15.60', '500', 'dell-inspiron-3542-dnd6x4-300copy-nowatermark-200x200.jpg', '16990000.00');
INSERT INTO `product` VALUES ('00014', '1', '2', 'Dell Inspiron 5441', 'Intel, Core i3 Haswell, 4005U, 1.70 GHz', '4', '14.00', '500', 'dell-inspiron-5442-m4i3324p-02-nowatermark-200x200.jpg', '10390000.00');
INSERT INTO `product` VALUES ('00015', '1', '2', 'Dell Inspiron 7737', 'Intel, Core i7 Haswell, 4510U, 2.00 GHz', '16', '17.30', '1000', 'dell-inspiron-7737-02-nowatermark-200x200.jpg', '35890000.00');
INSERT INTO `product` VALUES ('00016', '1', '2', 'Dell Vostro 3446', 'Intel, Core i5 Haswell, 4210U, 1.70 GHz', '4', '14.00', '500', 'dell-vostro-3446-5j8dw1-nowatermark-200x200.jpg', '13990000.00');
INSERT INTO `product` VALUES ('00017', '1', '2', 'Dell Vostro 5470', 'Intel, Core i7 Haswell, 4510U, 2.00 GHz', '4', '14.00', '1000', 'Dell-Vostro-5470-300copy-nowatermark-200x200.jpg', '17990000.00');
INSERT INTO `product` VALUES ('00018', '1', '2', 'Dell Inspiron 5442', 'Intel, Core i5 Haswell, 4210U, 1.70 GHz', '4', '14.00', '1000', 'dell-inspiron-5442-p49g001.jpg', '14290000.00');
INSERT INTO `product` VALUES ('00020', '1', '5', 'Acer Aspire v3 371', 'Intel, Core i5 Haswell, 4210U, 1.70 GHz', '4', '13.30', '500', 'acer-aspire-v3-371-i5-win81-nowatermark-120x120.jpg', '12990000.00');
INSERT INTO `product` VALUES ('00021', '1', '3', 'HP Pavilion 14 V024tu', 'Intel, Core i5 Haswell, 4210U, 1.70 GHz', '4', '14.00', '500', 'hp-pavilion-14-v024tu-j6m77pa-6.jpg', '13990000.00');
INSERT INTO `product` VALUES ('00022', '1', '3', 'HP Pavilion 14 v025TU', 'Intel, Core i5 Haswell, 4210U, 1.70 GHz', '4', '14.00', '500', 'HP-Pavilion-14-v025TU-nowatermark-200x200.jpg', '13990000.00');
INSERT INTO `product` VALUES ('00023', '4', '4', 'Lenovo S410', 'Intel, Core i5 Haswell, 4210U, 1.70 GHz', '4', '14.00', '500', 'lenovo-s410-i5-win8-2-nowatermark-200x200.jpg', '12990000.00');
INSERT INTO `product` VALUES ('00024', '4', '4', 'Lenovo Z5070', 'Intel, Core i3 Haswell, 4030U, 1.90 GHz', '4', '15.60', '500', 'lenovo-z5070-59439197-300-nowatermark-120x120.jpg', '12290000.00');
INSERT INTO `product` VALUES ('00025', '4', '2', 'Dell Inspiron 11 3147', 'Intel, Core i3 Haswell, 4010U, 1.70 GHz', '4', '11.60', '500', 'dell-inspiron-11-3147-nowatermark-200x200.jpg', '13990000.00');
INSERT INTO `product` VALUES ('00026', '1', '2', 'Dell Vostro 5470', 'Intel, Core i7 Haswell, 4510U, 2.00 GHz', '4', '14.00', '1000', 'Dell-Vostro-5470-300copy-nowatermark-200x200.jpg', '12190000.00');
INSERT INTO `product` VALUES ('00027', '4', '4', 'Lenovo Z5070', 'Intel, Core i3 Haswell, 4030U, 1.90 GHz', '4', '15.60', '500', 'lenovo-z5070-59439197-300-nowatermark-120x120.jpg', '9890000.00');
INSERT INTO `product` VALUES ('00028', '1', '2', 'Dell Inspiron 7737', 'Intel, Core i7 Haswell, 4510U, 2.00 GHz', '16', '17.30', '1000', 'dell-inspiron-7737-02-nowatermark-200x200.jpg', '15990000.00');
INSERT INTO `product` VALUES ('00029', '4', '4', 'Lenovo S410', 'Intel, Core i5 Haswell, 4210U, 1.70 GHz', '4', '14.00', '500', 'lenovo-s410-i5-win8-2-nowatermark-200x200.jpg', '11690000.00');
INSERT INTO `product` VALUES ('00030', '2', '1', 'ASUS K451LA', 'Intel, Core i3 Haswell, 4010U, 1.70 GHz', '4', '14.00', '500', '300-asus-k451la-wx092h-nowatermark-200x200.jpg', '28490000.00');
INSERT INTO `product` VALUES ('00031', '2', '1', 'ASUS TP500LN', 'Intel, Core i5 Haswell, 4210U, 1.70 GHz', '4', '15.60', '500', 'asus-tp500ln-cj129h-nowatermark-120x120.jpg', '16890000.00');
INSERT INTO `product` VALUES ('00032', '1', '2', 'Dell Inspiron 7737', 'Intel, Core i7 Haswell, 4510U, 2.00 GHz', '16', '17.30', '1000', 'dell-inspiron-7737-02-nowatermark-200x200.jpg', '10590000.00');
INSERT INTO `product` VALUES ('00033', '2', '1', 'ASUS X453MA', 'Intel, Pentium, N3540, 2.16 GHz', '2', '14.00', '500', 'asus-x453ma-celeron-n3540-win8-nowatermark-200x200.jpg', '5990000.00');
INSERT INTO `product` VALUES ('00034', '1', '2', 'Dell Inspiron 3442', 'Intel, Core i5 Haswell, 4210U, 1.70 GHz', '4', '14.00', '1000', 'dell-inspiron-3442-54214g1t-01-nowatermark-200x200.jpg', '11990000.00');
INSERT INTO `product` VALUES ('00035', '1', '2', 'Dell Inspiron 3541', 'Intel, Core i7 Haswell, 4510U, 2.00 GHz', '4', '15.60', '500', 'dell-inspiron-3542-dnd6x4-300copy-nowatermark-200x200.jpg', '15690000.00');
INSERT INTO `product` VALUES ('00036', '1', '2', 'Dell Inspiron 5441', 'Intel, Core i3 Haswell, 4005U, 1.70 GHz', '4', '14.00', '500', 'dell-inspiron-5442-m4i3324p-02-nowatermark-200x200.jpg', '7490000.00');
INSERT INTO `product` VALUES ('00037', '1', '2', 'Dell Inspiron 7737', 'Intel, Core i7 Haswell, 4510U, 2.00 GHz', '16', '17.30', '1000', 'dell-inspiron-7737-02-nowatermark-200x200.jpg', '12990000.00');
INSERT INTO `product` VALUES ('00038', '1', '3', 'HP Pavilion 14 V024tu', 'Intel, Core i5 Haswell, 4210U, 1.70 GHz', '4', '14.00', '500', 'hp-pavilion-14-v024tu-j6m77pa-6.jpg', '16990000.00');
INSERT INTO `product` VALUES ('00039', '1', '3', 'HP Pavilion 14 v025TU', 'Intel, Core i5 Haswell, 4210U, 1.70 GHz', '4', '14.00', '500', 'HP-Pavilion-14-v025TU-nowatermark-200x200.jpg', '10390000.00');
INSERT INTO `product` VALUES ('00040', '4', '4', 'Lenovo S410', 'Intel, Core i5 Haswell, 4210U, 1.70 GHz', '4', '14.00', '500', 'lenovo-s410-i5-win8-2-nowatermark-200x200.jpg', '35890000.00');
INSERT INTO `product` VALUES ('00041', '4', '4', 'Lenovo Z5070', 'Intel, Core i3 Haswell, 4030U, 1.90 GHz', '4', '15.60', '500', 'lenovo-z5070-59439197-300-nowatermark-120x120.jpg', '13990000.00');
INSERT INTO `product` VALUES ('00042', '4', '2', 'Dell Inspiron 11 3147', 'Intel, Core i3 Haswell, 4010U, 1.70 GHz', '4', '11.60', '500', 'dell-inspiron-11-3147-nowatermark-200x200.jpg', '17990000.00');
INSERT INTO `product` VALUES ('00043', '1', '2', 'Dell Vostro 5470', 'Intel, Core i7 Haswell, 4510U, 2.00 GHz', '4', '14.00', '1000', 'Dell-Vostro-5470-300copy-nowatermark-200x200.jpg', '14290000.00');
INSERT INTO `product` VALUES ('00045', '1', '2', 'Dell Inspiron 7737', 'Intel, Core i7 Haswell, 4510U, 2.00 GHz', '16', '17.30', '1000', 'dell-inspiron-7737-02-nowatermark-200x200.jpg', '12990000.00');
INSERT INTO `product` VALUES ('00046', '4', '4', 'Lenovo S410', 'Intel, Core i5 Haswell, 4210U, 1.70 GHz', '4', '14.00', '500', 'lenovo-s410-i5-win8-2-nowatermark-200x200.jpg', '13990000.00');
INSERT INTO `product` VALUES ('00047', '2', '1', 'ASUS K451LA', 'Intel, Core i3 Haswell, 4010U, 1.70 GHz', '4', '14.00', '500', '300-asus-k451la-wx092h-nowatermark-200x200.jpg', '13990000.00');
INSERT INTO `product` VALUES ('00048', '2', '1', 'ASUS K451LA', 'Intel, Core i3 Haswell, 4010U, 1.70 GHz', '4', '14.00', '500', '300-asus-k451la-wx092h-nowatermark-200x200.jpg', '13990000.00');
INSERT INTO `product` VALUES ('00054', '1', '1', 'ASUS ROG', 'Intel', '16', '15.40', '500', 'ASUS_ROG.jpg', '1600000.00');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` varchar(50) CHARACTER SET utf8 NOT NULL,
  `password` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(40) CHARACTER SET utf8 DEFAULT NULL,
  `address` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `phone` varchar(11) COLLATE utf8_unicode_ci DEFAULT NULL,
  `role` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('aa@aa.aa', '11111111', 'aa@aa.aa', '11', '011111111', 'user');
INSERT INTO `user` VALUES ('ad@ad', '11111111', 'ad', '111', '111', 'user');
INSERT INTO `user` VALUES ('admin', '123', 'Administrator', '227 Nguyễn Văn Cừ, phường 4, Hồ Chí Minh', '0988881141', 'admin');
INSERT INTO `user` VALUES ('admin@admin.com', '123456789', 'Administrator', 'ITEC, 227 Nguyễn Văn Cừ, Quận 5, Tp.HCM', '09876543211', 'admin');
INSERT INTO `user` VALUES ('customer', '123', 'Khách Hàng', '227 Nguyễn Văn Cừ, phường 4, Hồ Chí Minh', '0912345678', 'user');
INSERT INTO `user` VALUES ('dhs', '12345678', 'Son Dang', '123 Đường 109, Phước Long B, Quận 9, TP.HCM', '0988881141', 'user');
INSERT INTO `user` VALUES ('dhs1', '88888888', '', 'sgsfg', '3434', 'user');
INSERT INTO `user` VALUES ('dhs1984@gmail.co', '12345678', '', 'ad', '32', 'user');
INSERT INTO `user` VALUES ('dhs1984@gmail.com', '88888888', '', 'adfaf', '13123', 'user');
INSERT INTO `user` VALUES ('dhs1985@gmail.com', '11111111', 'Sơn Đặng', 'Lý Thường Kiệt', '123', 'user');
INSERT INTO `user` VALUES ('dhs2', '11111111', '', '22', '22', 'user');
INSERT INTO `user` VALUES ('dhs@dff', '11111111', '', 'ada', '4234', 'user');
INSERT INTO `user` VALUES ('dsfs@fdaf', '11111111', '', 'adasfa', '123', 'user');
INSERT INTO `user` VALUES ('minh@gmail.com', '11111111', 'Minh', '11', '11', 'user');
INSERT INTO `user` VALUES ('p@gmail.com', '11111111', 'Phuong', '227', '227', 'user');
INSERT INTO `user` VALUES ('Phu', '11111111', '', '11', '11', 'user');
INSERT INTO `user` VALUES ('q@glmail', '22222222', 'Quan', '1111', '1111', 'user');
INSERT INTO `user` VALUES ('sadfad', '11111111', 'adfa', 'sdf', '1212', 'user');
INSERT INTO `user` VALUES ('td@td.com', '11111111', 'td@td.com', 'adfadf', '0911111111', 'user');
INSERT INTO `user` VALUES ('tester@gmail.com', '12345678', 'tester@gmail.com', '227 Nguyễn Văn Cừ, Phường 4, Quận 5', '0909111333', 'user');

-- ----------------------------
-- Table structure for viewtracking
-- ----------------------------
DROP TABLE IF EXISTS `viewtracking`;
CREATE TABLE `viewtracking` (
  `sku` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `totalViews` int(5) unsigned DEFAULT '0',
  `lastView` datetime DEFAULT NULL,
  `lastUserId` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`sku`),
  CONSTRAINT `fk_viewtracking_product_sku` FOREIGN KEY (`sku`) REFERENCES `product` (`sku`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of viewtracking
-- ----------------------------
INSERT INTO `viewtracking` VALUES ('008', '3', '2015-06-26 15:23:57', '');
INSERT INTO `viewtracking` VALUES ('009', '5', '2015-06-26 13:53:08', 'admin@admin.com');
INSERT INTO `viewtracking` VALUES ('011', '2', '2015-06-16 11:32:35', 'dhs');
INSERT INTO `viewtracking` VALUES ('013', '1', '2015-06-17 08:34:35', '');
INSERT INTO `viewtracking` VALUES ('014', '1', '2015-06-17 08:33:50', '');
INSERT INTO `viewtracking` VALUES ('021', '2', '2015-06-17 12:02:02', 'dhs');
INSERT INTO `viewtracking` VALUES ('022', '1', '2015-06-15 09:56:45', 'customer');
INSERT INTO `viewtracking` VALUES ('029', '1', '2015-06-26 15:24:05', '');
INSERT INTO `viewtracking` VALUES ('045', '1', '2015-06-16 23:46:44', '');
INSERT INTO `viewtracking` VALUES ('046', '1', '2015-06-26 15:52:19', '');
