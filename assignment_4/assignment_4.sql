-- -----------------------------------------------------
-- Assignment 4
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Database schema

/*The database schema is as follows, where the underlined attribute(s) in each relation collectively form the primary key of that relation:
1. HSO_Location (locID, locName, address*, city, postal code, province)
2. Animals (aID, type, gender, chipNo)
3. Admission (animalID, dateAdmitted, locID, prevOwnerSIN)
4. Adopter (SIN, name, address*, city, postal code, province, phone, animalCount)
5. Adoption (animalID, SIN, adoptDate)
* address consists of civic number.*/
-- -----------------------------------------------------

CREATE TABLE HSO_Location (
    locID INT PRIMARY KEY,
    locName VARCHAR(255),
    address VARCHAR(255),
    city VARCHAR(255),
    postalCode VARCHAR(10),
    province VARCHAR(255)
);

CREATE TABLE Animals (
    aID INT PRIMARY KEY,
    type VARCHAR(255),
    gender VARCHAR(10),
    chipNo VARCHAR(50)
);

CREATE TABLE Admission (
    animalID INT,
    dateAdmitted DATE,
    locID INT,
    prevOwnerSIN VARCHAR(15),
    PRIMARY KEY (animalID, dateAdmitted,locID),
    FOREIGN KEY (animalID) REFERENCES Animals(aID),
    FOREIGN KEY (locID) REFERENCES HSO_Location(locID)
);

CREATE TABLE Adopter (
    SIN VARCHAR(15) PRIMARY KEY,
    name VARCHAR(255),
    address VARCHAR(255),
    city VARCHAR(255),
    postalCode VARCHAR(10),
    province VARCHAR(255),
    phone VARCHAR(20),
    animalCount INT
);

CREATE TABLE Adoption (
    animalID INT,
    SIN VARCHAR(15),
    adoptDate DATE,
    PRIMARY KEY (animalID, SIN),
    FOREIGN KEY (animalID) REFERENCES Animals(aID),
    FOREIGN KEY (SIN) REFERENCES Adopter(SIN)
);



-- -----------------------------------------------------
-- Queries
-- -----------------------------------------------------

-- part a) ---------------------------------------------
/*Provide the Animal type, Animal gender, Location Name, name of the adopter of all the animals that have been adopted between 20 January 2021 and 20 February 2021.
Assume that an animal can be admitted at most twice over the lifetime of the animal). */

SELECT anim.type, anim.gender , h.locName, adop.name
FROM Animals anim, HSO_Location h, Adopter adop, Admission adm, Adoption x
WHERE anim.aID = adm.animalID AND h.locID = adm.locID AND x.animalID = anim.aID AND x.SIN = adop.SIN AND adoptDate BETWEEN '2021-01-20' AND '2021-02-20';

-- part b) ---------------------------------------------
/*Provide the animal id, type, gender and chip number of animals that have been adopted by at least three 
different adopters. */

SELECT DISTINCT anim.aID, anim.type, anim.gender, anim.chipNo
FROM Animals anim
WHERE anim.aID IN (SELECT animalID FROM Adoption GROUP BY animalID HAVING COUNT(DISTINCT SIN) >= 3);

-- part c) ---------------------------------------------
/*Provide the name and phone of adopters that adopted an animal from locations that are 
located in different provinces that they reside in. */

SELECT DISTINCT adop.name, adop.phone 
FROM Adopter adop, Adoption x, Admission adm, HSO_Location h
WHERE adop.SIN = x.SIN AND x.animalID = adm.animalID AND adm.locID = h.locID AND adop.province <> h.province;

-- part d) ---------------------------------------------
/*Provide the name and phone of adopters that only adopted female animals. 
(They have never adopted male animals) */

SELECT DISTINCT adop.name, adop.phone
FROM Adopter adop
WHERE adop.SIN NOT IN (SELECT DISTINCT x.SIN FROM Adoption x, Animals anim WHERE x.animalID = anim.aID AND gender = 'Male');

-- part e) ---------------------------------------------
/*Provide the name and phone number of adopters that adopted all type of animals.*/
SELECT A.name, A.phone
FROM Adopter A
WHERE NOT EXISTS (
    SELECT DISTINCT AN.type
    FROM Animals AN
    WHERE NOT EXISTS (
        SELECT AD.animalID
        FROM Adoption AD
        WHERE AD.SIN = A.SIN AND AD.animalID = AN.aID
    )
    AND AN.type NOT IN (
        SELECT AN2.type
        FROM Animals AN2
        JOIN Adoption AD2 ON AN2.aID = AD2.animalID
        WHERE AD2.SIN = A.SIN
    )
);


-- -----------------------------------------------------
-- Sample data for the tables
-- -----------------------------------------------------

-- Insert sample data into HSO_Location table
INSERT INTO HSO_Location (locID, locName, address, city, postalCode, province)
VALUES
    (1, 'Main Center', '123 Main St', 'Cityville', '12345', 'Province A'),
    (2, 'North Branch', '456 North Ave', 'Townville', '67890', 'Province B'),
    (3, 'West Branch', '789 West Rd', 'Villageville', '54321', 'Province C');

-- Insert sample data into Animals table
INSERT INTO Animals (aID, type, gender, chipNo)
VALUES
    (101, 'Dog', 'Male', '123456789'),
    (102, 'Cat', 'Female', '987654321'),
    (103, 'Dog', 'Female', '456789123'),
    (104, 'Bird', 'Male', '789123456'),
    (105, 'Dog', 'Male', '567891234'),
    (106, 'Cat', 'Male', '234567891'),
    (107, 'Dog', 'Female', '891234567'),
    (108, 'Cat', 'Female', '345678912'),
    (109, 'Bird', 'Male', '678912345'),
    (110, 'Dog', 'Male', '456789123');

-- Insert sample data into Admission table
INSERT INTO Admission (animalID, dateAdmitted, locID, prevOwnerSIN)
VALUES
    (101, '2021-01-21', 1, '123-456-789'),
    (102, '2021-02-15', 2, NULL),
    (103, '2021-01-30', 1, '234-567-890'),
    (104, '2021-02-10', 3, NULL),
    (105, '2021-01-25', 2, '345-678-901'),
    (106, '2021-02-05', 1, NULL),
    (107, '2021-02-18', 3, '456-789-012'),
    (108, '2021-01-29', 2, '567-890-123'),
    (109, '2021-01-27', 1, NULL),
    (110, '2021-02-01', 3, NULL);

-- Insert sample data into Adopter table
INSERT INTO Adopter (SIN, name, address, city, postalCode, province, phone, animalCount)
VALUES
    ('123-456-789', 'John Doe', '456 Elm St', 'Cityville', '12345', 'Province A', '555-1234', 2),
    ('234-567-890', 'Jane Smith', '789 Oak Ave', 'Townville', '67890', 'Province B', '555-5678', 1),
    ('345-678-901', 'Alice Johnson', '123 Maple Rd', 'Villageville', '54321', 'Province C', '555-9876', 0),
    ('456-789-012', 'Robert White', '789 Pine St', 'Cityville', '12345', 'Province A', '555-2468', 3),
    ('567-890-123', 'Emily Brown', '456 Cedar Ave', 'Townville', '67890', 'Province B', '555-1357', 1);

-- Insert sample data into Adoption table
INSERT INTO Adoption (animalID, SIN, adoptDate)
VALUES
    (101, '123-456-789', '2021-01-25'),
    (101, '234-567-890', '2021-02-05'),
    (102, '123-456-789', '2021-02-18'),
    (101, '345-678-901', '2021-02-15'),
    (102, '456-789-012', '2021-02-02'),
    (106, '234-567-890', '2021-01-30'),
    (107, '456-789-012', '2021-01-28'),
    (108, '123-456-789', '2021-02-10'),
    (102, '234-567-890', '2021-01-27'),
    (110, '345-678-901', '2021-02-08'),
    (104, '123-456-789', '2021-02-01'),
    (109, '234-567-890', '2021-02-01'),
