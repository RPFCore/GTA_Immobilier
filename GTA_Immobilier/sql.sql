INSERT INTO `items` (`libelle`, `isUsable`, `type`) VALUES
	('Clef_1', 1, 0),
	('Clef_2', 1, 0);
	('Clef_3', 1, 0),


DROP TABLE IF EXISTS `gta_immo_stockage`;
CREATE TABLE IF NOT EXISTS `gta_immo_stockage` (
  `argent` int(11) unsigned DEFAULT 0,
  `argent_sale` int(11) unsigned DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `gta_immo_stockage` (`argent`, `argent_sale`) VALUES
	(0, 0);