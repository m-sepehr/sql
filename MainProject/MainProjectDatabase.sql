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
-- Table `mdc353_1`.`AddressDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mdc353_1`.`AddressDetails` (
  `postalCode` CHAR(7) NOT NULL,
  `province` VARCHAR(100) NULL,
  `city` VARCHAR(100) NULL,
  PRIMARY KEY (`postalCode`),
  UNIQUE INDEX `postalCode_UNIQUE` (`postalCode` ASC) VISIBLE)
ENGINE = InnoDB;


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
  `postalCode` CHAR(7) NOT NULL,
  PRIMARY KEY (`medicareID`),
  UNIQUE INDEX `medicareID_UNIQUE` (`medicareID` ASC) VISIBLE,
  INDEX `fk_Person_AddressDetails1_idx` (`postalCode` ASC) VISIBLE,
  CONSTRAINT `fk_Person_AddressDetails1`
    FOREIGN KEY (`postalCode`)
    REFERENCES `mdc353_1`.`AddressDetails` (`postalCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mdc353_1`.`Facility`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mdc353_1`.`Facility` (
  `facilityID` VARCHAR(5) NOT NULL,
  `facilityName` VARCHAR(60) NOT NULL,
  `ministryID` INT NOT NULL,
  `type` VARCHAR(60) NOT NULL,
  `subType` VARCHAR(60) NULL,
  `presidentID` CHAR(11) NULL,
  `webAddress` VARCHAR(80) NULL,
  `address` VARCHAR(100) NULL,
  `city` VARCHAR(100) NULL,
  `province` VARCHAR(100) NULL,
  `postalCode` CHAR(7) NOT NULL,
  `phone` VARCHAR(16) NULL,
  PRIMARY KEY (`facilityID`),
  UNIQUE INDEX `facilityID_UNIQUE` (`facilityID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mdc353_1`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mdc353_1`.`Employee` (
  `medicareID` CHAR(11) NOT NULL,
  `facilityID` VARCHAR(5) NOT NULL,
  `occupation` VARCHAR(60) NOT NULL,
  `specialty` VARCHAR(60) NULL,
  `secondRole` VARCHAR(60) NULL,
  `startDate` DATE NOT NULL,
  `endDate` DATE NULL,
  INDEX `fk_Employee_Person1_idx` (`medicareID` ASC) VISIBLE,
  PRIMARY KEY (`medicareID`, `facilityID`, `startDate`),
  INDEX `fk_Employee_Facility1_idx` (`facilityID` ASC) VISIBLE,
  CONSTRAINT `fk_Employee_Person1`
    FOREIGN KEY (`medicareID`)
    REFERENCES `mdc353_1`.`Person` (`medicareID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee_Facility1`
    FOREIGN KEY (`facilityID`)
    REFERENCES `mdc353_1`.`Facility` (`facilityID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mdc353_1`.`Student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mdc353_1`.`Student` (
  `medicareID` CHAR(11) NOT NULL,
  `facilityID` VARCHAR(5) NOT NULL,
  `currentLevel` VARCHAR(30) NULL,
  `startDate` DATE NOT NULL,
  `endDate` DATE NULL,
  INDEX `fk_Student_Person1_idx` (`medicareID` ASC) VISIBLE,
  PRIMARY KEY (`medicareID`, `facilityID`, `startDate`),
  INDEX `fk_Student_Facility1_idx` (`facilityID` ASC) VISIBLE,
  CONSTRAINT `fk_Student_Person1`
    FOREIGN KEY (`medicareID`)
    REFERENCES `mdc353_1`.`Person` (`medicareID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Student_Facility1`
    FOREIGN KEY (`facilityID`)
    REFERENCES `mdc353_1`.`Facility` (`facilityID`)
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


-- -----------------------------------------------------
-- Table `mdc353_1`.`Email`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mdc353_1`.`Email` (
  `emailID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `subject` VARCHAR(100) NULL,
  `body` VARCHAR(1024) NULL,
  PRIMARY KEY (`emailID`),
  UNIQUE INDEX `emailID_UNIQUE` (`emailID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mdc353_1`.`EmailLog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mdc353_1`.`EmailLog` (
  `emailID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `facilityID` VARCHAR(5) NOT NULL,
  `medicareID` CHAR(11) NOT NULL,
  `emailDate` VARCHAR(45) NULL,
  `bodySummary` VARCHAR(80) NULL,
  PRIMARY KEY (`emailID`),
  INDEX `fk_EmailLog_Email1_idx` (`emailID` ASC) VISIBLE,
  INDEX `fk_EmailLog_Person1_idx` (`medicareID` ASC) VISIBLE,
  INDEX `fk_EmailLog_Facility1_idx` (`facilityID` ASC) VISIBLE,
  UNIQUE INDEX `emailID_UNIQUE` (`emailID` ASC) VISIBLE,
  CONSTRAINT `fk_EmailLog_Email1`
    FOREIGN KEY (`emailID`)
    REFERENCES `mdc353_1`.`Email` (`emailID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EmailLog_Person1`
    FOREIGN KEY (`medicareID`)
    REFERENCES `mdc353_1`.`Person` (`medicareID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EmailLog_Facility1`
    FOREIGN KEY (`facilityID`)
    REFERENCES `mdc353_1`.`Facility` (`facilityID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mdc353_1`.`Schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mdc353_1`.`Schedule` (
  `medicareID` CHAR(11) NOT NULL,
  `facilityID` VARCHAR(5) NULL,
  `workDate` DATE NOT NULL,
  `startTime` TIME NOT NULL,
  `endTime` TIME NULL,
  PRIMARY KEY (`medicareID`, `workDate`, `startTime`),
  INDEX `fk_Person_has_Facility_Person1_idx` (`medicareID` ASC) VISIBLE,
  INDEX `fk_Schedule_Facility1_idx` (`facilityID` ASC) VISIBLE,
  CONSTRAINT `fk_Person_has_Facility_Person1`
    FOREIGN KEY (`medicareID`)
    REFERENCES `mdc353_1`.`Person` (`medicareID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Schedule_Facility1`
    FOREIGN KEY (`facilityID`)
    REFERENCES `mdc353_1`.`Facility` (`facilityID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mdc353_1`;

DELIMITER $$
USE `mdc353_1`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mdc353_1`.`Infections_AFTER_INSERT` AFTER INSERT ON `Infections` FOR EACH ROW
BEGIN
    DECLARE infected_person_type VARCHAR(60);
    DECLARE person_type VARCHAR(60);
    DECLARE schedule_date DATE;
    DECLARE facility_id VARCHAR(5);
    DECLARE facility_name VARCHAR(60);
    DECLARE principal_email VARCHAR(80);
    DECLARE principal_ID CHAR(11);
    DECLARE email_subject VARCHAR(100);
    DECLARE email_body VARCHAR(1024);
    DECLARE first_name VARCHAR(45);
    DECLARE last_name VARCHAR(60);
    
    -- Get the type of infection and the person's type
    SELECT typeOfInfection INTO infected_person_type
    FROM Infections
    WHERE infectionID = NEW.infectionID;

    -- Get the person's type (e.g., teacher, student, etc.)
    SELECT occupation INTO person_type
    FROM Employee
    WHERE medicareID = NEW.medicareID;

    -- Get the person's first and last name
    SELECT firstName, lastName INTO first_name, last_name
    FROM Person
    WHERE medicareID = NEW.medicareID;
    
    -- Check if the infection is COVID-19 and the person is a teacher
    IF infected_person_type = 'COVID-19' AND (person_type = 'teacher') OR (person_type = 'Teacher') OR (person_type = 'TEACHER') THEN
        SELECT DATE_ADD(NEW.dateOfInfection, INTERVAL 2 WEEK) INTO schedule_date;
        
        -- Cancel schedules for the infected person for the next two weeks
        UPDATE Schedule
        SET startTime = '00:00:00', endTime = '00:00:00'
        WHERE medicareID = NEW.medicareID
            AND workDate BETWEEN NEW.dateOfInfection AND schedule_date;
        
        -- Get facility information and principal's email
        SELECT f.facilityID, f.facilityName, p.email, p.medicareID INTO facility_id, facility_name, principal_email, principal_ID
        FROM Employee e
        INNER JOIN Facility f ON e.facilityID = f.facilityID
        INNER JOIN Person p ON f.presidentID = p.medicareID
        WHERE e.medicareID = NEW.medicareID;
        
        -- Create email subject and body
        SET email_subject = 'Warning';
        SET email_body = CONCAT(first_name, ' ', last_name, ' who teaches in your school has been infected with COVID-19 on ', NEW.dateOfInfection);
        
        -- Insert email record
        INSERT INTO Email (subject, body) VALUES (email_subject, email_body);
        
        -- Insert email log record
        INSERT INTO EmailLog (emailID, facilityID, medicareID, emailDate, bodySummary)
        VALUES (LAST_INSERT_ID(), facility_id, principal_ID, NOW(), LEFT(email_body, 80));
    END IF;
END$$

USE `mdc353_1`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mdc353_1`.`Schedule_BEFORE_INSERT_Time_Conflict` BEFORE INSERT ON `Schedule` FOR EACH ROW
BEGIN
	DECLARE conflict_count INT;
    DECLARE time_conflict INT;
    DECLARE gap_conflict INT;
    
    -- Check for conflicts with existing schedule
    SELECT COUNT(*) INTO conflict_count
    FROM Schedule
    WHERE medicareID = NEW.medicareID
        AND workDate = NEW.workDate
        AND ((NEW.startTime BETWEEN startTime AND endTime) OR (NEW.endTime BETWEEN startTime AND endTime));
    
    -- Check for start time not greater than end time
    SET time_conflict = IF(NEW.startTime > NEW.endTime, 1, 0);
    
    -- Check for one-hour gap between shifts on the same day
    SELECT COUNT(*) INTO gap_conflict
    FROM Schedule
    WHERE medicareID = NEW.medicareID
        AND workDate = NEW.workDate
        AND TIME_TO_SEC(TIMEDIFF(NEW.startTime, endTime)) < 3600;
    
    -- Check for conflicts with different facilities
    SELECT COUNT(*) INTO conflict_count
    FROM Schedule
    WHERE medicareID = NEW.medicareID
        AND workDate = NEW.workDate
        AND facilityID != NEW.facilityID
        AND ((NEW.startTime BETWEEN startTime AND endTime) OR (NEW.endTime BETWEEN startTime AND endTime));
    
    IF conflict_count > 0 OR time_conflict = 1 OR gap_conflict > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Schedule conflict or constraint violation';
    END IF;
    
END$$

USE `mdc353_1`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mdc353_1`.`Schedule_BEFORE_INSERT_Not_Vaxxed` BEFORE INSERT ON `Schedule` FOR EACH ROW
BEGIN
	DECLARE vaccination_date DATE;
    DECLARE six_months_ago DATE;

    -- Get the date of the most recent COVID-19 vaccination for the employee
    SELECT MAX(dateOfVax) INTO vaccination_date
    FROM Vaccinations
    WHERE medicareID = NEW.medicareID AND ((vaxType = 'Pfizer') OR (vaxType = 'Moderna') OR (vaxType = 'AstraZeneca') OR (vaxType = 'Johnson & Johnson'));

    -- Calculate the date six months ago from the current date
    SET six_months_ago = DATE_SUB(NOW(), INTERVAL 6 MONTH);

    -- Check if the employee was vaccinated with at least one dose of COVID-19 in the past six months
    IF vaccination_date IS NULL OR vaccination_date < six_months_ago THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Employee is not vaccinated with at least one dose of COVID-19 in the past six months.';
    END IF;
END$$

DELIMITER $$

CREATE DEFINER = CURRENT_USER PROCEDURE `SendWeeklyScheduleEmails`()
BEGIN
    DECLARE today_date DATE;
    DECLARE start_date DATE;
    DECLARE end_date DATE;
    DECLARE facility_id VARCHAR(5);
    DECLARE facility_name VARCHAR(60);
    DECLARE employee_id CHAR(11);
    DECLARE employee_first_name VARCHAR(45);
    DECLARE employee_last_name VARCHAR(60);
    DECLARE email_subject VARCHAR(100);
    DECLARE email_body VARCHAR(1024);
    
    -- Get current date
    SET today_date = NOW();
    SET start_date = DATE_ADD(today_date, INTERVAL 1 DAY); -- Start from tomorrow
    SET end_date = DATE_ADD(start_date, INTERVAL 6 DAY); -- Seven-day schedule
    
    -- Loop through facilities
    SET facility_id = '';
    facility_loop: LOOP
        SELECT facilityID, facilityName INTO facility_id, facility_name
        FROM Facility
        WHERE facilityID > facility_id
        LIMIT 1;
        
        IF facility_id IS NULL THEN
            LEAVE facility_loop;
        END IF;
        
        -- Loop through employees in the facility
        SET employee_id = '';
        employee_loop: LOOP
            SELECT e.medicareID, firstName, lastName INTO employee_id, employee_first_name, employee_last_name
            FROM Employee e, Person
            WHERE facilityID = facility_id AND e.medicareID > employee_id
            LIMIT 1;
            
            IF employee_id IS NULL THEN
                LEAVE employee_loop;
            END IF;
            
            -- Generate email subject
            SET email_subject = CONCAT(facility_name, ' Schedule for ', DATE_FORMAT(start_date, '%d-%b-%Y'), ' to ', DATE_FORMAT(end_date, '%d-%b-%Y'));
            
            -- Generate email body
            SET email_body = CONCAT('Facility Name: ', facility_name, '\n',
                                    'Address: ', (SELECT address FROM Facility WHERE facilityID = facility_id), '\n',
                                    'Employee: ', employee_first_name, ' ', employee_last_name, '\n',
                                    'Email: ', (SELECT email FROM Person WHERE medicareID = employee_id), '\n\n',
                                    'Schedule for the coming week:', '\n');
            
            -- Loop through days of the week
            SET @day := start_date;
            day_loop: WHILE @day <= end_date DO
                SET email_body = CONCAT(email_body, DATE_FORMAT(@day, '%W'), ': ');
                
                -- Get employee's schedule for the day
                SET @employee_schedule := '';
                SELECT GROUP_CONCAT(
                    IFNULL(DATE_FORMAT(startTime, '%H:%i'), 'No Assignment'), ' - ',
                    IFNULL(DATE_FORMAT(endTime, '%H:%i'), 'No Assignment')
                ) INTO @employee_schedule
                FROM Schedule
                WHERE medicareID = employee_id AND workDate = @day;
                
                SET email_body = CONCAT(email_body, @employee_schedule, '\n');
                
                SET @day := DATE_ADD(@day, INTERVAL 1 DAY);
            END WHILE day_loop;
            
            -- Send the email
            INSERT INTO Email (subject, body) VALUES (email_subject, email_body);
            
            -- Insert email log record
            INSERT INTO EmailLog (emailID, facilityID, medicareID, emailDate, bodySummary)
            VALUES (LAST_INSERT_ID(), facility_id, employee_id, NOW(), LEFT(email_body, 80));
        END LOOP employee_loop;
    END LOOP facility_loop;
    
END$$

CREATE EVENT SendWeeklyEmailsEvent
ON SCHEDULE EVERY 1 WEEK
STARTS TIMESTAMP('2023-01-01') -- first sunday of 2023
DO
BEGIN
    CALL SendWeeklyScheduleEmails();
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
