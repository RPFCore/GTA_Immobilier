CREATE TABLE IF NOT EXISTS `user_storage` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `item_name` varchar(255) DEFAULT NULL,
  `quantity` bigint(20) unsigned NOT NULL DEFAULT 0,
  `license` varchar(50) NOT NULL DEFAULT '0',
  UNIQUE KEY `item_id_license` (`item_name`,`license`) USING BTREE,
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `items` (`libelle`, `isUsable`, `type`) VALUES
	('Clef', 1, 30000),
	('Clef_2', 1, 200000);
	('Clef_3', 1, 2000000),
	('Clef_4', 1, 15000000);
