CREATE TABLE `wash_database` (
	`ID` INT(11) NOT NULL AUTO_INCREMENT,
	`citizenid` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_general_ci',
	`amount` INT(11) NOT NULL DEFAULT '0',
	`time` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`howlong` INT(11) NOT NULL DEFAULT '0',
	PRIMARY KEY (`ID`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=9
;
