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
  `maxCapacity` INT UNSIGNED NULL,
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

-- -----------------------------------------------------
-- Trigger

-- After Insert On 'Infections'
-- Veryify if new COVID-19 is inserted for a teacher
-- Cancel teacher's schedules for the next two weeks
-- Send email to the principal of the facility
-- -----------------------------------------------------

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

-- -----------------------------------------------------
-- Trigger

-- Before Insert On 'Schedule'
-- Check for start time not greater than end time
-- Check for one-hour gap between shifts on the same day
-- Check for conflicts with existing schedule
-- -----------------------------------------------------

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
	-- Check if new schedule is within the next 4 weeks
    SET time_conflict = IF((NEW.startTime > NEW.endTime) OR (NEW.workDate < CURDATE() OR NEW.workDate >= DATE_ADD(CURDATE(), INTERVAL 4 WEEK)), 1, 0);
    
    -- Check for one-hour gap between shifts on the same day
    SELECT COUNT(*) INTO gap_conflict
    FROM Schedule
    WHERE medicareID = NEW.medicareID
        AND workDate = NEW.workDate
        AND TIME_TO_SEC(TIMEDIFF(NEW.startTime, endTime)) < 3600;
    
    IF conflict_count > 0 OR time_conflict = 1 OR gap_conflict > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Schedule conflict or constraint violation';
    END IF;
    
END;

-- -----------------------------------------------------
-- Trigger

-- Before Insert On 'Schedule'
-- Check if the employee was vaccinated with at least one 
-- dose of COVID-19 in the past six months
-- -----------------------------------------------------

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

-- -----------------------------------------------------
-- Procedure

-- When called, this procedure will send weekly schedule emails
-- to all employees of all facilities
-- -----------------------------------------------------

DELIMITER $$

CREATE DEFINER = CURRENT_USER PROCEDURE `SendWeeklyScheduleEmails`()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE employee_id CHAR(11);
    DECLARE facility_id VARCHAR(5);
    DECLARE facility_name VARCHAR(60);
    DECLARE facility_address VARCHAR(100);
    DECLARE employee_first_name VARCHAR(45);
    DECLARE employee_last_name VARCHAR(60);
    DECLARE employee_email VARCHAR(80);
    DECLARE email_subject VARCHAR(100);
    DECLARE email_body VARCHAR(1024);
    DECLARE start_date DATE;
    DECLARE end_date DATE;
    DECLARE work_date DATE;
    DECLARE start_time TIME;
    DECLARE end_time TIME;
    
    -- Declare a cursor to loop through all employees
    DECLARE employee_cursor CURSOR FOR
        SELECT DISTINCT e.medicareID, e.facilityID, f.facilityName, f.address, p.firstName, p.lastName, p.email
        FROM Employee e
        INNER JOIN Facility f ON e.facilityID = f.facilityID
        INNER JOIN Person p ON e.medicareID = p.medicareID;
    
    -- Declare a handler to close the cursor when done
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    -- Open the cursor
    OPEN employee_cursor;
    
       -- Loop through all employees
    employee_loop: LOOP
    
        -- Fetch the next employee from the cursor
        FETCH employee_cursor INTO employee_id, facility_id, facility_name, facility_address, employee_first_name, employee_last_name, employee_email;
        
        -- Check if done
        IF done THEN
            LEAVE employee_loop;
        END IF;
        
        -- Set the start date and end date of the week (Sunday to Saturday)
        SET start_date = CURDATE() + INTERVAL 1 - DAYOFWEEK(CURDATE()) DAY;
        SET end_date = start_date + INTERVAL 6 DAY;
        
        -- Create the email subject
        SET email_subject = CONCAT(facility_name, ' Schedule for ', DATE_FORMAT(start_date, '%d-%b-%Y'), ' to ', DATE_FORMAT(end_date, '%d-%b-%Y'));
        
        -- Create the email body header
        SET email_body = CONCAT('Facility Name: ', facility_name, '\n');
        SET email_body = CONCAT(email_body, 'Facility Address: ', facility_address, '\n');
        SET email_body = CONCAT(email_body, 'Employee: ', employee_first_name, ' ', employee_last_name, ' (', employee_email, ')', '\n\n');
        
        -- Loop through all days of the week
        WHILE start_date <= end_date DO
        
            -- Append the day of the week to the email body
            SET email_body = CONCAT(email_body, DATE_FORMAT(start_date, '%W'), ': ');
            
            -- Get the start time and end time of the schedule for that day and facility
            SELECT startTime, endTime INTO start_time, end_time
            FROM Schedule
            WHERE medicareID = employee_id AND facilityID = facility_id AND workDate = start_date;
            
            -- Check if there is a schedule for that day and facility
            IF start_time IS NOT NULL AND end_time IS NOT NULL THEN
            
                -- Append the start time and end time to the email body
                SET email_body = CONCAT(email_body, 'Start Time: ', start_time, ' End Time: ', end_time);
                
            ELSE
            
                -- Append "No Assignment" to the email body
                SET email_body = CONCAT(email_body, 'No Assignment');
                
            END IF;
            
            -- Add a new line to the email body
            SET email_body = CONCAT(email_body, '\n');
            
            -- Increment the start date by one day
            SET start_date = start_date + INTERVAL 1 DAY;
            
        END WHILE;
        
        -- Insert the email record into the Email table
        INSERT INTO Email (subject, body) VALUES (email_subject, email_body);
        
        -- Insert the email log record into the EmailLog table
        INSERT INTO EmailLog (emailID, facilityID, medicareID, emailDate, bodySummary)
        VALUES (LAST_INSERT_ID(), facility_id, employee_id, NOW(), LEFT(email_body, 80));
        
    END LOOP employee_loop;
    
    -- Close the cursor
    CLOSE employee_cursor;
    
END$$

-- -----------------------------------------------------
-- Event

-- This event will occur every Sunday at 12:00 AM
-- and will call the SendWeeklyScheduleEmails procedure
-- -----------------------------------------------------

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
