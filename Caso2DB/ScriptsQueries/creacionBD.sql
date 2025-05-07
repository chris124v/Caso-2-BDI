-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema paymentAssistant
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema paymentAssistant
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `paymentAssistant` DEFAULT CHARACTER SET utf8 ;
USE `paymentAssistant` ;

-- -----------------------------------------------------
-- Table `paymentAssistant`.`currencies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`currencies` (
  `currencyId` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `acronym` VARCHAR(10) NOT NULL,
  `countryid` TINYINT NOT NULL,
  `symbol` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`currencyId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`country` (
  `countryid` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  `currencyId` TINYINT NOT NULL,
  PRIMARY KEY (`countryid`),
  INDEX `fk_country_currencies1_idx` (`currencyId` ASC) VISIBLE,
  CONSTRAINT `fk_country_currencies1`
    FOREIGN KEY (`currencyId`)
    REFERENCES `paymentAssistant`.`currencies` (`currencyId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`users` (
  `userid` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NOT NULL,
  `fecha_registro` DATETIME NOT NULL,
  `password` VARBINARY(250) NOT NULL,
  `usertype` VARCHAR(100) NOT NULL,
  `isactive` BIT(1) NOT NULL DEFAULT 1,
  `countryid` TINYINT NOT NULL,
  PRIMARY KEY (`userid`),
  INDEX `fk_users_country1_idx` (`countryid` ASC) VISIBLE,
  CONSTRAINT `fk_users_country1`
    FOREIGN KEY (`countryid`)
    REFERENCES `paymentAssistant`.`country` (`countryid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`modules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`modules` (
  `moduleid` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`moduleid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`permissions` (
  `permissionid` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(50) NOT NULL,
  `code` VARCHAR(10) NOT NULL,
  `moduleid` INT NOT NULL,
  PRIMARY KEY (`permissionid`),
  INDEX `fk_paym_permissions_paym_modules1_idx` (`moduleid` ASC) VISIBLE,
  CONSTRAINT `fk_paym_permissions_paym_modules1`
    FOREIGN KEY (`moduleid`)
    REFERENCES `paymentAssistant`.`modules` (`moduleid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`userspermissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`userspermissions` (
  `rolepermissionid` INT NOT NULL AUTO_INCREMENT,
  `enabled` BIT(1) NOT NULL DEFAULT 1,
  `deleted` BIT(1) NOT NULL DEFAULT 0,
  `lastupdate` DATETIME NOT NULL DEFAULT NOW(),
  `username` VARCHAR(50) NOT NULL,
  `checksum` VARBINARY(250) NOT NULL,
  `permissionid` INT NOT NULL,
  `userid` INT NOT NULL,
  PRIMARY KEY (`rolepermissionid`),
  INDEX `fk_paym_userspermissions_paym_permissions1_idx` (`permissionid` ASC) VISIBLE,
  INDEX `fk_paym_userspermissions_paym_users1_idx` (`userid` ASC) VISIBLE,
  CONSTRAINT `fk_paym_userspermissions_paym_permissions1`
    FOREIGN KEY (`permissionid`)
    REFERENCES `paymentAssistant`.`permissions` (`permissionid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paym_userspermissions_paym_users1`
    FOREIGN KEY (`userid`)
    REFERENCES `paymentAssistant`.`users` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`roles` (
  `roleid` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`roleid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`usersroles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`usersroles` (
  `roleid` INT NOT NULL,
  `userid` INT NOT NULL,
  `lastupdate` DATETIME NOT NULL DEFAULT NOW(),
  `username` VARCHAR(64) NOT NULL,
  `checksum` VARBINARY(128) NOT NULL,
  `enabled` BIT(1) NOT NULL DEFAULT 1,
  `deleted` BIT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`roleid`, `userid`),
  INDEX `fk_paym_roles_has_paym_users_paym_users1_idx` (`userid` ASC) VISIBLE,
  INDEX `fk_paym_roles_has_paym_users_paym_roles_idx` (`roleid` ASC) VISIBLE,
  CONSTRAINT `fk_paym_roles_has_paym_users_paym_roles`
    FOREIGN KEY (`roleid`)
    REFERENCES `paymentAssistant`.`roles` (`roleid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paym_roles_has_paym_users_paym_users1`
    FOREIGN KEY (`userid`)
    REFERENCES `paymentAssistant`.`users` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`rolespermissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`rolespermissions` (
  `rolepermissionid` INT NOT NULL AUTO_INCREMENT,
  `enabled` BIT(1) NOT NULL DEFAULT 1,
  `deleted` BIT(1) NOT NULL DEFAULT 0,
  `lastupdate` DATETIME NOT NULL DEFAULT NOW(),
  `username` VARCHAR(50) NOT NULL,
  `checksum` VARBINARY(250) NOT NULL,
  `permissionid` INT NOT NULL,
  `roleid` INT NOT NULL,
  PRIMARY KEY (`rolepermissionid`),
  INDEX `fk_paym_userspermissions_paym_permissions1_idx` (`permissionid` ASC) VISIBLE,
  INDEX `fk_paym_rolespermissions_paym_roles1_idx` (`roleid` ASC) VISIBLE,
  CONSTRAINT `fk_paym_userspermissions_paym_permissions10`
    FOREIGN KEY (`permissionid`)
    REFERENCES `paymentAssistant`.`permissions` (`permissionid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paym_rolespermissions_paym_roles1`
    FOREIGN KEY (`roleid`)
    REFERENCES `paymentAssistant`.`roles` (`roleid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`paymentmethods`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`paymentmethods` (
  `paymentmethodid` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `APIurl` VARCHAR(250) NOT NULL,
  `securityKey` VARBINARY(250) NOT NULL,
  `key` VARBINARY(250) NOT NULL,
  `enabled` BIT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`paymentmethodid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`userpaymentmethods`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`userpaymentmethods` (
  `userpaymentmethodid` INT NOT NULL AUTO_INCREMENT,
  `userid` INT NOT NULL,
  `paymentmethodid` TINYINT NOT NULL,
  `accountinfo` VARCHAR(250) NULL,
  `accountnumber` VARCHAR(100) NULL,
  `expirationdate` DATETIME NULL,
  `isdefault` BIT(1) NOT NULL DEFAULT 0,
  `enabled` BIT(1) NOT NULL DEFAULT 1,
  `createdat` DATETIME NOT NULL DEFAULT NOW(),
  `updatedat` DATETIME NOT NULL DEFAULT NOW(),
  PRIMARY KEY (`userpaymentmethodid`),
  INDEX `fk_userpaymentmethods_users1_idx` (`userid` ASC) VISIBLE,
  INDEX `fk_userpaymentmethods_paymentmethods1_idx` (`paymentmethodid` ASC) VISIBLE,
  CONSTRAINT `fk_userpaymentmethods_users1`
    FOREIGN KEY (`userid`)
    REFERENCES `paymentAssistant`.`users` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_userpaymentmethods_paymentmethods1`
    FOREIGN KEY (`paymentmethodid`)
    REFERENCES `paymentAssistant`.`paymentmethods` (`paymentmethodid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`plans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`plans` (
  `plansid` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` TEXT NOT NULL,
  `isactive` BIT(1) NOT NULL DEFAULT 1,
  `createdat` TIMESTAMP NOT NULL,
  `updatedat` TIMESTAMP NOT NULL,
  PRIMARY KEY (`plansid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`planpricing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`planpricing` (
  `priceid` TINYINT NOT NULL AUTO_INCREMENT,
  `billingperiod` VARCHAR(20) NOT NULL,
  `price` DECIMAL NOT NULL,
  `createdat` TIMESTAMP NOT NULL,
  `updatedat` TIMESTAMP NOT NULL,
  `plansid` TINYINT NOT NULL,
  `currencyId` TINYINT NOT NULL,
  PRIMARY KEY (`priceid`),
  INDEX `fk_planpricing_plans1_idx` (`plansid` ASC) VISIBLE,
  INDEX `fk_planpricing_currencies1_idx` (`currencyId` ASC) VISIBLE,
  CONSTRAINT `fk_planpricing_plans1`
    FOREIGN KEY (`plansid`)
    REFERENCES `paymentAssistant`.`plans` (`plansid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_planpricing_currencies1`
    FOREIGN KEY (`currencyId`)
    REFERENCES `paymentAssistant`.`currencies` (`currencyId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`userssubscriptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`userssubscriptions` (
  `usersubsid` INT NOT NULL AUTO_INCREMENT,
  `userid` INT NOT NULL,
  `start_date` DATETIME NOT NULL,
  `end_date` DATETIME NOT NULL,
  `autorenew` BIT(1) NOT NULL DEFAULT 1,
  `status` VARCHAR(20) NOT NULL,
  `createdat` DATETIME NOT NULL,
  `updateat` DATETIME NOT NULL,
  `plansid` TINYINT NOT NULL,
  `priceid` TINYINT NOT NULL,
  PRIMARY KEY (`usersubsid`),
  INDEX `fk_userssubscriptions_users1_idx` (`userid` ASC) VISIBLE,
  INDEX `fk_userssubscriptions_plans1_idx` (`plansid` ASC) VISIBLE,
  INDEX `fk_userssubscriptions_planpricing1_idx` (`priceid` ASC) VISIBLE,
  CONSTRAINT `fk_userssubscriptions_users1`
    FOREIGN KEY (`userid`)
    REFERENCES `paymentAssistant`.`users` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_userssubscriptions_plans1`
    FOREIGN KEY (`plansid`)
    REFERENCES `paymentAssistant`.`plans` (`plansid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_userssubscriptions_planpricing1`
    FOREIGN KEY (`priceid`)
    REFERENCES `paymentAssistant`.`planpricing` (`priceid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`payments` (
  `paymentsid` TINYINT NOT NULL AUTO_INCREMENT,
  `amount` DECIMAL NOT NULL,
  `actualmamount` DECIMAL NOT NULL,
  `description` VARCHAR(250) NOT NULL,
  `error` VARCHAR(250) NULL,
  `date` DATETIME NOT NULL,
  `checksum` VARBINARY(250) NOT NULL,
  `currencyId` TINYINT NOT NULL,
  `userpaymentmethodid` INT NOT NULL,
  `usersubsid` INT NOT NULL,
  PRIMARY KEY (`paymentsid`),
  INDEX `fk_payments_currencies1_idx` (`currencyId` ASC) VISIBLE,
  INDEX `fk_payments_userpaymentmethods1_idx` (`userpaymentmethodid` ASC) VISIBLE,
  INDEX `fk_payments_userssubscriptions1_idx` (`usersubsid` ASC) VISIBLE,
  CONSTRAINT `fk_payments_currencies1`
    FOREIGN KEY (`currencyId`)
    REFERENCES `paymentAssistant`.`currencies` (`currencyId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payments_userpaymentmethods1`
    FOREIGN KEY (`userpaymentmethodid`)
    REFERENCES `paymentAssistant`.`userpaymentmethods` (`userpaymentmethodid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payments_userssubscriptions1`
    FOREIGN KEY (`usersubsid`)
    REFERENCES `paymentAssistant`.`userssubscriptions` (`usersubsid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`exchangeRate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`exchangeRate` (
  `exchangeRateId` TINYINT NOT NULL AUTO_INCREMENT,
  `sourcecurrencyid` TINYINT NOT NULL,
  `targetcurrencyid` TINYINT NOT NULL,
  `startdate` DATETIME NOT NULL,
  `enddate` DATETIME NULL,
  `exchangerate` DECIMAL NOT NULL,
  `enabled` BIT(1) NOT NULL DEFAULT 1,
  `currentExchangeRate` BIT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`exchangeRateId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`transactions` (
  `transactionid` INT NOT NULL AUTO_INCREMENT,
  `transaction_date` DATETIME NOT NULL,
  `idpayments` INT NULL,
  `transaction_amount` DECIMAL NOT NULL,
  `transaction_state` ENUM('pending', 'successful', 'failed') NOT NULL,
  `error_description` VARCHAR(50) NOT NULL,
  `paymentsid` TINYINT NOT NULL,
  `description` VARCHAR(250) NOT NULL,
  `referenceNumber` VARCHAR(250) NOT NULL,
  `checksum` VARBINARY(250) NOT NULL,
  `exchangeRateId` TINYINT NOT NULL,
  `currencyId` TINYINT NOT NULL,
  PRIMARY KEY (`transactionid`),
  INDEX `fk_transactions_payments1_idx` (`paymentsid` ASC) VISIBLE,
  INDEX `fk_transactions_exchangeRate1_idx` (`exchangeRateId` ASC) VISIBLE,
  INDEX `fk_transactions_currencies1_idx` (`currencyId` ASC) VISIBLE,
  CONSTRAINT `fk_transactions_payments1`
    FOREIGN KEY (`paymentsid`)
    REFERENCES `paymentAssistant`.`payments` (`paymentsid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transactions_exchangeRate1`
    FOREIGN KEY (`exchangeRateId`)
    REFERENCES `paymentAssistant`.`exchangeRate` (`exchangeRateId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transactions_currencies1`
    FOREIGN KEY (`currencyId`)
    REFERENCES `paymentAssistant`.`currencies` (`currencyId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`notificationtype`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`notificationtype` (
  `notificationtypeid` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `description` TEXT NOT NULL,
  PRIMARY KEY (`notificationtypeid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`notificationtemplate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`notificationtemplate` (
  `templateid` TINYINT NOT NULL AUTO_INCREMENT,
  `notificationtypeid` TINYINT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `content` TEXT NOT NULL,
  `channel` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`templateid`),
  INDEX `fk_notificationtemplate_notificationtype1_idx` (`notificationtypeid` ASC) VISIBLE,
  CONSTRAINT `fk_notificationtemplate_notificationtype1`
    FOREIGN KEY (`notificationtypeid`)
    REFERENCES `paymentAssistant`.`notificationtype` (`notificationtypeid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`notifications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`notifications` (
  `idnotifications` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(20) NOT NULL,
  `userid` INT NOT NULL,
  `sentat` TIMESTAMP NOT NULL,
  `templateid` TINYINT NOT NULL,
  PRIMARY KEY (`idnotifications`),
  INDEX `fk_notifications_users1_idx` (`userid` ASC) VISIBLE,
  INDEX `fk_notifications_notificationtemplate1_idx` (`templateid` ASC) VISIBLE,
  CONSTRAINT `fk_notifications_users1`
    FOREIGN KEY (`userid`)
    REFERENCES `paymentAssistant`.`users` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_notifications_notificationtemplate1`
    FOREIGN KEY (`templateid`)
    REFERENCES `paymentAssistant`.`notificationtemplate` (`templateid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`entityfile`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`entityfile` (
  `entityid` INT NOT NULL AUTO_INCREMENT,
  `entitytype` ENUM('user', 'payment', 'transaction', 'subscription') NOT NULL,
  `userid` INT NOT NULL,
  `payments_paymentsid` TINYINT NOT NULL,
  `plansid` TINYINT NOT NULL,
  PRIMARY KEY (`entityid`),
  INDEX `fk_entityfile_users1_idx` (`userid` ASC) VISIBLE,
  INDEX `fk_entityfile_payments1_idx` (`payments_paymentsid` ASC) VISIBLE,
  INDEX `fk_entityfile_plans1_idx` (`plansid` ASC) VISIBLE,
  CONSTRAINT `fk_entityfile_users1`
    FOREIGN KEY (`userid`)
    REFERENCES `paymentAssistant`.`users` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_entityfile_payments1`
    FOREIGN KEY (`payments_paymentsid`)
    REFERENCES `paymentAssistant`.`payments` (`paymentsid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_entityfile_plans1`
    FOREIGN KEY (`plansid`)
    REFERENCES `paymentAssistant`.`plans` (`plansid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`files`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`files` (
  `idfile` INT NOT NULL AUTO_INCREMENT,
  `file_name` VARCHAR(250) NOT NULL,
  `file_type` VARCHAR(100) NOT NULL,
  `storage_url` VARCHAR(500) NOT NULL,
  `update_date` DATETIME NOT NULL,
  `entityid` INT NOT NULL,
  PRIMARY KEY (`idfile`),
  INDEX `fk_files_entityfile1_idx` (`entityid` ASC) VISIBLE,
  CONSTRAINT `fk_files_entityfile1`
    FOREIGN KEY (`entityid`)
    REFERENCES `paymentAssistant`.`entityfile` (`entityid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`transactionType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`transactionType` (
  `transTypeId` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `transactionid` INT NOT NULL,
  `description` VARCHAR(250) NULL,
  `createdat` DATETIME NOT NULL DEFAULT NOW(),
  PRIMARY KEY (`transTypeId`),
  INDEX `fk_transactionType_transactions1_idx` (`transactionid` ASC) VISIBLE,
  CONSTRAINT `fk_transactionType_transactions1`
    FOREIGN KEY (`transactionid`)
    REFERENCES `paymentAssistant`.`transactions` (`transactionid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`transactionSubTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`transactionSubTypes` (
  `transactionSubTypesId` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `transTypeId` TINYINT NOT NULL,
  `description` VARCHAR(250) NULL,
  `createdat` DATETIME NOT NULL DEFAULT NOW(),
  PRIMARY KEY (`transactionSubTypesId`),
  INDEX `fk_transactionSubTypes_transactionType1_idx` (`transTypeId` ASC) VISIBLE,
  CONSTRAINT `fk_transactionSubTypes_transactionType1`
    FOREIGN KEY (`transTypeId`)
    REFERENCES `paymentAssistant`.`transactionType` (`transTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`features`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`features` (
  `featureid` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` TEXT NOT NULL,
  `featuretype` VARCHAR(100) NOT NULL,
  `isactive` BIT(1) NOT NULL DEFAULT 1,
  `createdat` TIMESTAMP NOT NULL,
  `updatedat` TIMESTAMP NOT NULL,
  PRIMARY KEY (`featureid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`planfeatures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`planfeatures` (
  `planfeatureid` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` TEXT NOT NULL,
  `isactive` BIT(1) NOT NULL DEFAULT 1,
  `createdat` TIMESTAMP NOT NULL,
  `updatedat` TIMESTAMP NOT NULL,
  `plansid` TINYINT NOT NULL,
  `featureid` TINYINT NOT NULL,
  PRIMARY KEY (`planfeatureid`),
  INDEX `fk_planfeatures_plans1_idx` (`plansid` ASC) VISIBLE,
  INDEX `fk_planfeatures_features1_idx` (`featureid` ASC) VISIBLE,
  CONSTRAINT `fk_planfeatures_plans1`
    FOREIGN KEY (`plansid`)
    REFERENCES `paymentAssistant`.`plans` (`plansid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_planfeatures_features1`
    FOREIGN KEY (`featureid`)
    REFERENCES `paymentAssistant`.`features` (`featureid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`planxperson`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`planxperson` (
  `planxpersonid` TINYINT NOT NULL AUTO_INCREMENT,
  `limitvalue` INT NOT NULL,
  `usedvalue` INT NOT NULL,
  `resetperiod` VARCHAR(20) NOT NULL,
  `createdat` TIMESTAMP NOT NULL,
  `updatedat` TIMESTAMP NOT NULL,
  `iduserssubscriptions` INT NOT NULL,
  `featureid` TINYINT NOT NULL,
  PRIMARY KEY (`planxpersonid`),
  INDEX `fk_planxperson_userssubscriptions1_idx` (`iduserssubscriptions` ASC) VISIBLE,
  INDEX `fk_planxperson_planfeatures1_idx` (`featureid` ASC) VISIBLE,
  CONSTRAINT `fk_planxperson_userssubscriptions1`
    FOREIGN KEY (`iduserssubscriptions`)
    REFERENCES `paymentAssistant`.`userssubscriptions` (`usersubsid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_planxperson_planfeatures1`
    FOREIGN KEY (`featureid`)
    REFERENCES `paymentAssistant`.`planfeatures` (`planfeatureid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`languages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`languages` (
  `languageid` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `culture` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`languageid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`translation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`translation` (
  `translationid` TINYINT NOT NULL AUTO_INCREMENT,
  `translationkey` VARCHAR(100) NOT NULL,
  `translationvalue` TEXT NOT NULL,
  `moduleid` INT NOT NULL,
  `languageid` TINYINT NOT NULL,
  PRIMARY KEY (`translationid`),
  INDEX `fk_translation_modules1_idx` (`moduleid` ASC) VISIBLE,
  INDEX `fk_translation_languages1_idx` (`languageid` ASC) VISIBLE,
  CONSTRAINT `fk_translation_modules1`
    FOREIGN KEY (`moduleid`)
    REFERENCES `paymentAssistant`.`modules` (`moduleid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_translation_languages1`
    FOREIGN KEY (`languageid`)
    REFERENCES `paymentAssistant`.`languages` (`languageid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`logtypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`logtypes` (
  `logtypeid` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `description` TEXT NOT NULL,
  PRIMARY KEY (`logtypeid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`logsources`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`logsources` (
  `logsourceid` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `description` TEXT NOT NULL,
  PRIMARY KEY (`logsourceid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`logseverity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`logseverity` (
  `logseverityid` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `description` TEXT NOT NULL,
  PRIMARY KEY (`logseverityid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`logs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`logs` (
  `logid` TINYINT NOT NULL AUTO_INCREMENT,
  `logtypeid` TINYINT NOT NULL,
  `logsourceid` TINYINT NOT NULL,
  `logseverityid` TINYINT NOT NULL,
  `description` TEXT NOT NULL,
  `posttime` TIMESTAMP NOT NULL,
  `details` JSON NOT NULL,
  `ipaddress` VARCHAR(45) NULL,
  `useragent` VARCHAR(250) NULL,
  `relatedentity` VARCHAR(50) NULL,
  `relatedentityid` INT NULL,
  `userid` INT NOT NULL,
  PRIMARY KEY (`logid`),
  INDEX `fk_logs_logtypes1_idx` (`logtypeid` ASC) VISIBLE,
  INDEX `fk_logs_logsources1_idx` (`logsourceid` ASC) VISIBLE,
  INDEX `fk_logs_logseverity1_idx` (`logseverityid` ASC) VISIBLE,
  INDEX `fk_logs_users1_idx` (`userid` ASC) VISIBLE,
  CONSTRAINT `fk_logs_logtypes1`
    FOREIGN KEY (`logtypeid`)
    REFERENCES `paymentAssistant`.`logtypes` (`logtypeid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_logs_logsources1`
    FOREIGN KEY (`logsourceid`)
    REFERENCES `paymentAssistant`.`logsources` (`logsourceid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_logs_logseverity1`
    FOREIGN KEY (`logseverityid`)
    REFERENCES `paymentAssistant`.`logseverity` (`logseverityid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_logs_users1`
    FOREIGN KEY (`userid`)
    REFERENCES `paymentAssistant`.`users` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`state`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`state` (
  `stateid` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(40) NOT NULL,
  `countryid` TINYINT NOT NULL,
  PRIMARY KEY (`stateid`),
  INDEX `fk_state_country1_idx` (`countryid` ASC) VISIBLE,
  CONSTRAINT `fk_state_country1`
    FOREIGN KEY (`countryid`)
    REFERENCES `paymentAssistant`.`country` (`countryid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`city` (
  `cityid` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  `stateid` INT NOT NULL,
  PRIMARY KEY (`cityid`),
  INDEX `fk_city_state1_idx` (`stateid` ASC) VISIBLE,
  CONSTRAINT `fk_city_state1`
    FOREIGN KEY (`stateid`)
    REFERENCES `paymentAssistant`.`state` (`stateid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`addresses` (
  `addressid` INT NOT NULL AUTO_INCREMENT,
  `line1` VARCHAR(200) NOT NULL,
  `line2` VARCHAR(100) NOT NULL,
  `zipcode` VARCHAR(9) NULL,
  `cityid` INT NOT NULL,
  `latitude` DECIMAL(10,8) NULL,
  `longitude` DECIMAL(11,8) NULL,
  `isdefault` BIT(1) NOT NULL,
  `createdat` DATETIME NOT NULL DEFAULT NOW(),
  `updatedat` DATETIME NOT NULL DEFAULT NOW(),
  PRIMARY KEY (`addressid`),
  INDEX `fk_addresses_city1_idx` (`cityid` ASC) VISIBLE,
  CONSTRAINT `fk_addresses_city1`
    FOREIGN KEY (`cityid`)
    REFERENCES `paymentAssistant`.`city` (`cityid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`useraddresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`useraddresses` (
  `userid` INT NOT NULL,
  `addressid` INT NOT NULL,
  `useraddressid` TINYINT NOT NULL AUTO_INCREMENT,
  `enabled` BIT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`useraddressid`, `userid`, `addressid`),
  INDEX `fk_users_has_useraddresses_useraddresses1_idx` (`addressid` ASC) VISIBLE,
  INDEX `fk_users_has_useraddresses_users1_idx` (`userid` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_useraddresses_users1`
    FOREIGN KEY (`userid`)
    REFERENCES `paymentAssistant`.`users` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_useraddresses_useraddresses1`
    FOREIGN KEY (`addressid`)
    REFERENCES `paymentAssistant`.`addresses` (`addressid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`userfeatureusage`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`userfeatureusage` (
  `usageid` INT NOT NULL AUTO_INCREMENT,
  `usagecount` VARCHAR(50) NOT NULL,
  `lastreset` DATETIME NOT NULL,
  `nextreset` DATETIME NOT NULL,
  `usersubsid` INT NOT NULL,
  `featureid` TINYINT NOT NULL,
  PRIMARY KEY (`usageid`),
  INDEX `fk_userfeatureusage_userssubscriptions1_idx` (`usersubsid` ASC) VISIBLE,
  INDEX `fk_userfeatureusage_features1_idx` (`featureid` ASC) VISIBLE,
  CONSTRAINT `fk_userfeatureusage_userssubscriptions1`
    FOREIGN KEY (`usersubsid`)
    REFERENCES `paymentAssistant`.`userssubscriptions` (`usersubsid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_userfeatureusage_features1`
    FOREIGN KEY (`featureid`)
    REFERENCES `paymentAssistant`.`features` (`featureid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`conversations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`conversations` (
  `idconversations` INT NOT NULL AUTO_INCREMENT,
  `startdate` DATETIME NOT NULL,
  `enddate` DATETIME NULL,
  `status` ENUM('activa', 'finalizada', 'fallida') NOT NULL,
  `lastmessagge` TEXT NOT NULL,
  `language` VARCHAR(45) NOT NULL,
  `userid` INT NOT NULL,
  PRIMARY KEY (`idconversations`),
  INDEX `fk_conversations_users1_idx` (`userid` ASC) VISIBLE,
  CONSTRAINT `fk_conversations_users1`
    FOREIGN KEY (`userid`)
    REFERENCES `paymentAssistant`.`users` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`conversationinteractions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`conversationinteractions` (
  `idinteractions` INT NOT NULL AUTO_INCREMENT,
  `sequencenumber` INT NOT NULL,
  `datetime` TIMESTAMP NOT NULL,
  `idfile` INT NOT NULL,
  `idconversations` INT NOT NULL,
  PRIMARY KEY (`idinteractions`),
  INDEX `fk_conversationinteractions_files1_idx` (`idfile` ASC) VISIBLE,
  INDEX `fk_conversationinteractions_conversations1_idx` (`idconversations` ASC) VISIBLE,
  CONSTRAINT `fk_conversationinteractions_files1`
    FOREIGN KEY (`idfile`)
    REFERENCES `paymentAssistant`.`files` (`idfile`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_conversationinteractions_conversations1`
    FOREIGN KEY (`idconversations`)
    REFERENCES `paymentAssistant`.`conversations` (`idconversations`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`transcription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`transcription` (
  `idtranscription` INT NOT NULL AUTO_INCREMENT,
  `fulltranscript` TEXT NOT NULL,
  `audiofilename` VARCHAR(45) NOT NULL,
  `createddate` DATETIME NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `idinteractions` INT NOT NULL,
  PRIMARY KEY (`idtranscription`),
  INDEX `fk_transcription_conversationinteractions1_idx` (`idinteractions` ASC) VISIBLE,
  CONSTRAINT `fk_transcription_conversationinteractions1`
    FOREIGN KEY (`idinteractions`)
    REFERENCES `paymentAssistant`.`conversationinteractions` (`idinteractions`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`paymententities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`paymententities` (
  `identities` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  `value` VARCHAR(245) NOT NULL,
  `confidence` FLOAT NOT NULL,
  `verified` BIT(1) NOT NULL,
  `detecttime` DATETIME NOT NULL,
  `idtranscription` INT NOT NULL,
  PRIMARY KEY (`identities`),
  INDEX `fk_paymententities_transcription1_idx` (`idtranscription` ASC) VISIBLE,
  CONSTRAINT `fk_paymententities_transcription1`
    FOREIGN KEY (`idtranscription`)
    REFERENCES `paymentAssistant`.`transcription` (`idtranscription`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`aierrorclass`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`aierrorclass` (
  `errorclassid` INT NOT NULL AUTO_INCREMENT,
  `categoryname` VARCHAR(100) NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`errorclassid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`transcriptionerrors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`transcriptionerrors` (
  `iderrors` INT NOT NULL AUTO_INCREMENT,
  `errorcode` VARCHAR(120) NOT NULL,
  `errortype` VARCHAR(45) NOT NULL,
  `trytime` DATETIME NOT NULL,
  `errordescription` VARCHAR(250) NOT NULL,
  `idtranscription` INT NOT NULL,
  `errorclassid` INT NOT NULL,
  PRIMARY KEY (`iderrors`),
  INDEX `fk_transcriptionerrors_transcription1_idx` (`idtranscription` ASC) VISIBLE,
  INDEX `fk_transcriptionerrors_aierrorclass1_idx` (`errorclassid` ASC) VISIBLE,
  CONSTRAINT `fk_transcriptionerrors_transcription1`
    FOREIGN KEY (`idtranscription`)
    REFERENCES `paymentAssistant`.`transcription` (`idtranscription`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transcriptionerrors_aierrorclass1`
    FOREIGN KEY (`errorclassid`)
    REFERENCES `paymentAssistant`.`aierrorclass` (`errorclassid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`contactinfotype`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`contactinfotype` (
  `contactinfotypeid` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`contactinfotypeid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`contactinfoperperson`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`contactinfoperperson` (
  `userid` INT NOT NULL,
  `contactinfotypeid` INT NOT NULL,
  `value` VARCHAR(100) NOT NULL,
  `enabled` BIT(1) NOT NULL DEFAULT 1,
  `lastupdate` DATETIME NOT NULL,
  PRIMARY KEY (`userid`, `contactinfotypeid`),
  INDEX `fk_users_has_contactinfotype_contactinfotype1_idx` (`contactinfotypeid` ASC) VISIBLE,
  INDEX `fk_users_has_contactinfotype_users1_idx` (`userid` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_contactinfotype_users1`
    FOREIGN KEY (`userid`)
    REFERENCES `paymentAssistant`.`users` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_contactinfotype_contactinfotype1`
    FOREIGN KEY (`contactinfotypeid`)
    REFERENCES `paymentAssistant`.`contactinfotype` (`contactinfotypeid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentAssistant`.`appusage`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paymentAssistant`.`appusage` (
  `usageid` INT NOT NULL AUTO_INCREMENT,
  `userid` INT NOT NULL,
  `logindate` DATETIME NOT NULL,
  `logoutdate` DATETIME NULL,
  `sessionduration` INT NULL,
  `actionsperformed` INT NOT NULL DEFAULT 0,
  `ipaddress` VARCHAR(45) NULL,
  PRIMARY KEY (`usageid`),
  INDEX `fk_appusage_users1_idx` (`userid` ASC) VISIBLE,
  CONSTRAINT `fk_appusage_users1`
    FOREIGN KEY (`userid`)
    REFERENCES `paymentAssistant`.`users` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

