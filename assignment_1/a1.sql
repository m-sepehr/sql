/*The database schema is as follows, where the underlined attribute(s) in each relation collectively form 
the primary key of that relation:
1. Donors (donorID, firstName, lastName, middleInitial, dateOfBirth, address*, city, postalCode, province, gender, SSN)
2. Donations (dID, donorID, date, type, amount)
3. Products (pID, description, date, price, weight, inStock)
4. Sales (sID, date, amount, deliveryFee**)
5. salesItems(sID, pID)
* Address consists of civic number.
** deliveryFee is set to 0 if the sales is picked up directly by the buyer, or it holds the value of the delivery fee for the sales.
*/

--------part I, a)-----------
/*Write SQL “CREATE TABLE” statements for the above schema using appropriate data
types for the various attributes.*/

CREATE TABLE Donors (
    donorID INT PRIMARY KEY,
    firstName VARCHAR(40),
    lastName VARCHAR(60),
    middleInitial CHAR(1),
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
--A declaration to alter the Donors relation schema by deleting the attribute middleInitial.

ALTER TABLE Donors 
DROP COLUMN middleInitial;

-------part I, c)-----------
/*A declaration to alter the Donors relation schema by adding attributes phone and email. 
Use Unknown as the default value for these attributes.*/

ALTER TABLE Donors
ADD phone VARCHAR(16) DEFAULT 'Unknown';

ALTER TABLE Donors
ADD email VARCHAR(80) DEFAULT 'Unknown';

-------part I, d)-----------
--Provide three INSERT statements with data that will populate the table Products

INSERT INTO Products (pID, description, date, price, weight, inStock)
VALUES 
    (1, 'Soccer Ball', '2023-07-16', 25.00, 0.5, true),
    (2, 'Vintage Rolex', '2023-07-16', 25000.00, 0.2, true),
    (3, 'Master tape of The Dark Side of the Moon', '2023-07-16', 12560.00, 0.3, true);

-------part I, e)-----------
--Provide SQL statements that delete all data that you populated in table Products.

DELETE FROM Products
WHERE date = '2023-07-16';

-------part I, f)-----------
--Provide several SQL statements that delete all tables that you created in the database.

DROP TABLE Donors;
DROP TABLE Donations;
DROP TABLE Products;
DROP TABLE Sales;
DROP TABLE salesItems;


-------part II, a)----------
/*List the information of all the female Donors that live in the province of Québec.
Information includes donorID, first name, last name, date of birth, phone, email, and SSN.*/

SELECT donorID, firstName, lastName, dateOfBirth, phone, email, SSN
FROM Donors
WHERE gender = 'f' AND province = 'QC';


-------part II, b)----------
/* Give details of all the products that were delivered on July 1st, 2023. 
Details include sale ID, product ID, description, price, weight.*/

SELECT salesItems.sID, Products.pID, description, price, weight
FROM salesItems, Products, Sales
WHERE Products.pID = salesItems.pID AND salesItems.sID = Sales.sID AND Sales.date = '2023-07-01';

-------part II, c)----------
--Give the total amount of delivery fees that have been paid in the month of June of 2023

SELECT SUM(deliveryFee)
FROM Sales
WHERE date >= '2023-06-01' AND date <= '2023-06-30';

-------part II, d)---------
/*Give a monthly report of sales for 2022. The report includes for every month in 2022, the total number of sales, 
the total amount of sales, and the total amount of the delivery fees.*/

SELECT SUBSTRING (date, 6, 2) AS month, SUM(amount), SUM(deliveryFee)
FROM Sales
WHERE SUBSTRING (date, 0, 4) = '2022'
GROUP BY month

-------part II, e)--------
/*For every Donor who lives in the city of Montréal, give the total amount of donations she/he donated in 2022. 
Results should be displayed in ascending order by gender, then by last name then by first name.*/

SELECT Donors.donorID, gender, lastName, firstName, SUM(amount)
FROM Donors, Donations
WHERE Donors.donorID = Donations.donorID AND city = 'Montreal'
GROUP BY Donors.donorID
ORDER BY gender ASC, lastName ASC, firstName ASC;
