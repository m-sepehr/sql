--------part I, a)-----------

CREATE TABLE Donors (
    donorID INT PRIMARY KEY,
    firstName VARCHAR(40),
    lastName VARCHAR(60),
    middeInitial CHAR(1),
    dateOfBirth DATE,
    address INT,
    city VARCHAR(40),
    postalCode CHAR(6), -- ex. H1S4A3
    province CHAR(2), --Abbreviations (ex. QC,ON,BC)
    gender CHAR(1) DEFAULT '?',
    SSN INT
);

CREATE TABLE Donations (
    dID INT PRIMARY KEY,
    donorID INT,
    date DATE NOT NULL,
    type CHAR(1), --'p' for product, 'm' for money
    amount DECIMAL (10,2)
);

CREATE TABLE Products (
    pID INT PRIMARY KEY,
    description VARCHAR(512),
    date DATE NOT NULL,
    price INT,
    weight INT, --in kg
    inStock BOOL
);

CREATE TABLE Sales (
    sID INT PRIMARY KEY,
    date DATE NOT NULL,
    amount INT,
    deliveryFee DECIMAL(10,2) DEFAULT 0 
);

CREATE TABLE salesItems (
    sID INT, 
    pID INT,
    PRIMARY KEY (sID, pID)
);

-------part I, b)-----------
ALTER TABLE Donors 
DROP COLUMN middeInitial;

-------part I, c)-----------
ALTER TABLE Donors
ADD phone VARCHAR(16) DEFAULT 'Unknown', 
ADD email VARCHAR(80) DEFAULT 'Unknown';

-------part I, d)-----------
INSERT INTO Products (pID, description, date, price, weight, inStock)
VALUES 
    (1, 'Soccer Ball', '2023-07-16', 25.00, 0.5, true),
    (2, 'Vintage Rolex', '2023-07-16', 25000.00, 0.2, true),
    (3, 'Master tape of The Dark Side of the Moon', '2023-07-16', 12560.00, 0.3, true);
