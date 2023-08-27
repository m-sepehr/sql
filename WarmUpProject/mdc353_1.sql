-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mdc353_1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mdc353_1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mdc353_1` DEFAULT CHARACTER SET utf8 ;
USE `mdc353_1` ;

-- -----------------------------------------------------
-- Table `mdc353_1`.`Person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mdc353_1`.`Person` (
  `medicareID` CHAR(11) NOT NULL,
  `firstName` VARCHAR(45) NULL,
  `lastName` VARCHAR(60) NULL,
  `dateOfBirth` DATE NULL,
  `medicareExpiry` DATE NULL,
  `citizenship` VARCHAR(100) NULL,
  `email` VARCHAR(80) NULL,
  `phone` VARCHAR(16) NULL,
  `address` VARCHAR(100) NULL,
  `city` VARCHAR(100) NULL,
  `province` VARCHAR(100) NULL,
  `postalCode` CHAR(7) NULL,
  PRIMARY KEY (`medicareID`),
  UNIQUE INDEX `medicareID_UNIQUE` (`medicareID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mdc353_1`.`Facility`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mdc353_1`.`Facility` (
  `facilityName` VARCHAR(60) NOT NULL,
  `ministryID` INT NOT NULL,
  `type` VARCHAR(60) NULL,
  `subType` VARCHAR(60) NULL,
  `presidentID` CHAR(11) NULL,
  `webAddress` VARCHAR(80) NULL,
  `address` VARCHAR(100) NULL,
  `city` VARCHAR(100) NULL,
  `province` VARCHAR(100) NULL,
  `postalCode` CHAR(7) NULL,
  `phone` VARCHAR(16) NULL,
  PRIMARY KEY (`facilityName`, `ministryID`),
  UNIQUE INDEX `facilityName_UNIQUE` (`facilityName` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mdc353_1`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mdc353_1`.`Employee` (
  `medicareID` CHAR(11) NOT NULL,
  `facilityName` VARCHAR(60) NOT NULL,
  `occupation` VARCHAR(60) NULL,
  `specialty` VARCHAR(60) NULL,
  `startDate` DATE NULL,
  `endDate` DATE NULL,
  INDEX `fk_Employee_Facility1_idx` (`facilityName` ASC) VISIBLE,
  INDEX `fk_Employee_Person1_idx` (`medicareID` ASC) VISIBLE,
  CONSTRAINT `fk_Employee_Facility1`
    FOREIGN KEY (`facilityName`)
    REFERENCES `mdc353_1`.`Facility` (`facilityName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee_Person1`
    FOREIGN KEY (`medicareID`)
    REFERENCES `mdc353_1`.`Person` (`medicareID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mdc353_1`.`Student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mdc353_1`.`Student` (
  `medicareID` CHAR(11) NOT NULL,
  `facilityName` VARCHAR(60) NOT NULL,
  `currentLevel` VARCHAR(30) NULL,
  `startDate` DATE NULL,
  `endDate` DATE NULL,
  INDEX `fk_Student_Person1_idx` (`medicareID` ASC) VISIBLE,
  INDEX `fk_Student_Facility1_idx` (`facilityName` ASC) VISIBLE,
  CONSTRAINT `fk_Student_Person1`
    FOREIGN KEY (`medicareID`)
    REFERENCES `mdc353_1`.`Person` (`medicareID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Student_Facility1`
    FOREIGN KEY (`facilityName`)
    REFERENCES `mdc353_1`.`Facility` (`facilityName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mdc353_1`.`Infections`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mdc353_1`.`Infections` (
  `infectionID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `medicareID` CHAR(11) NOT NULL,
  `typeOfInfection` VARCHAR(60) NULL,
  `dateOfInfection` DATE NULL,
  PRIMARY KEY (`infectionID`),
  UNIQUE INDEX `infectionID_UNIQUE` (`infectionID` ASC) VISIBLE,
  INDEX `fk_Infections_Person1_idx` (`medicareID` ASC) VISIBLE,
  CONSTRAINT `fk_Infections_Person1`
    FOREIGN KEY (`medicareID`)
    REFERENCES `mdc353_1`.`Person` (`medicareID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mdc353_1`.`Vaccinations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mdc353_1`.`Vaccinations` (
  `vaxID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `medicareID` CHAR(11) NOT NULL,
  `vaxType` VARCHAR(60) NULL,
  `dateOfVax` DATE NULL,
  `doseNumber` INT NULL,
  PRIMARY KEY (`vaxID`),
  INDEX `fk_Vaccinations_Person1_idx` (`medicareID` ASC) VISIBLE,
  UNIQUE INDEX `vaxID_UNIQUE` (`vaxID` ASC) VISIBLE,
  CONSTRAINT `fk_Vaccinations_Person1`
    FOREIGN KEY (`medicareID`)
    REFERENCES `mdc353_1`.`Person` (`medicareID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
