-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema NLPO
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema NLPO
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `NLPO` DEFAULT CHARACTER SET utf8 ;
USE `NLPO` ;

-- -----------------------------------------------------
-- Table `NLPO`.`Member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NLPO`.`Member` (
  `memberID` VARCHAR(10) NOT NULL,
  `firstName` VARCHAR(100) NULL,
  `lastName` VARCHAR(100) NULL,
  `middleInitial` CHAR(1) NULL,
  `dateOfBirth` DATE NULL,
  `memberType` VARCHAR(45) NULL,
  `address` VARCHAR(100) NULL,
  `gender` CHAR(1) NULL,
  `phone` VARCHAR(16) NULL,
  `email` VARCHAR(100) NULL,
  `ssn` INT NULL,
  `memberStartDate` VARCHAR(45) NULL,
  PRIMARY KEY (`memberID`),
  UNIQUE INDEX `memberID_UNIQUE` (`memberID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NLPO`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NLPO`.`Employee` (
  `memberID` VARCHAR(10) NOT NULL,
  `jobTitle` INT NOT NULL,
  `salary` INT NULL,
  PRIMARY KEY (`memberID`),
  INDEX `fk_Employee_Member_idx` (`memberID` ASC) VISIBLE,
  CONSTRAINT `fk_Employee_Member`
    FOREIGN KEY (`memberID`)
    REFERENCES `NLPO`.`Member` (`memberID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NLPO`.`Expenses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NLPO`.`Expenses` (
  `expenseID` INT NOT NULL,
  `approvedByID` VARCHAR(10) NOT NULL,
  `dateOfPayment` DATE NULL,
  `amountOfExpense` DECIMAL(8,2) NULL,
  `typeOfExpense` VARCHAR(45) NULL,
  `descriptionOfExpense` VARCHAR(255) NULL,
  PRIMARY KEY (`expenseID`, `approvedByID`),
  UNIQUE INDEX `expenseID_UNIQUE` (`expenseID` ASC) VISIBLE,
  INDEX `fk_Expenses_Employee1_idx` (`approvedByID` ASC) VISIBLE,
  CONSTRAINT `fk_Expenses_Employee1`
    FOREIGN KEY (`approvedByID`)
    REFERENCES `NLPO`.`Employee` (`memberID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NLPO`.`Donations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NLPO`.`Donations` (
  `donationID` INT NOT NULL,
  `donorID` VARCHAR(10) NOT NULL,
  `dateOfDonation` DATE NULL,
  `typeOfDonation` VARCHAR(45) NULL,
  `amountOfDonation` DECIMAL(8,2) NULL,
  PRIMARY KEY (`donationID`, `donorID`),
  UNIQUE INDEX `donationID_UNIQUE` (`donationID` ASC) VISIBLE,
  INDEX `fk_Donations_Member1_idx` (`donorID` ASC) VISIBLE,
  CONSTRAINT `fk_Donations_Member1`
    FOREIGN KEY (`donorID`)
    REFERENCES `NLPO`.`Member` (`memberID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NLPO`.`Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NLPO`.`Products` (
  `productID` INT NOT NULL,
  `donationID` INT NOT NULL,
  `donorID` VARCHAR(10) NOT NULL,
  `productDescription` VARCHAR(255) NULL,
  `donationDate` DATE NULL,
  `sellingPrice` DECIMAL(8,2) NULL,
  `weight` DECIMAL(8,2) NULL,
  `inStock` VARCHAR(3) NULL,
  PRIMARY KEY (`productID`, `donationID`, `donorID`),
  INDEX `fk_Products_Donations1_idx` (`donationID` ASC, `donorID` ASC) VISIBLE,
  CONSTRAINT `fk_Products_Donations1`
    FOREIGN KEY (`donationID` , `donorID`)
    REFERENCES `NLPO`.`Donations` (`donationID` , `donorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NLPO`.`Sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NLPO`.`Sales` (
  `saleID` INT NOT NULL,
  `dateOfSale` DATE NULL,
  `amountOfSale` DECIMAL(8,2) NULL,
  `deliveryType` VARCHAR(45) NULL,
  `deliveryFee` DECIMAL(8,2) GENERATED ALWAYS AS (),
  PRIMARY KEY (`saleID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NLPO`.`SalesItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NLPO`.`SalesItems` (
  `productID` INT NOT NULL,
  `saleID` INT NOT NULL,
  PRIMARY KEY (`productID`, `saleID`),
  INDEX `fk_Products_has_Sales_Sales1_idx` (`saleID` ASC) VISIBLE,
  INDEX `fk_Products_has_Sales_Products1_idx` (`productID` ASC) VISIBLE,
  CONSTRAINT `fk_Products_has_Sales_Products1`
    FOREIGN KEY (`productID`)
    REFERENCES `NLPO`.`Products` (`productID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Products_has_Sales_Sales1`
    FOREIGN KEY (`saleID`)
    REFERENCES `NLPO`.`Sales` (`saleID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
