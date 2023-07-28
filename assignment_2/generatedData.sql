-- GENERATED DATA FOR NLPO DATABASE

INSERT INTO `NLPO`.`Member` (`memberID`, `firstName`, `lastName`, `middleInitial`, `dateOfBirth`, `memberType`, `address`, `gender`, `phone`, `email`, `ssn`, `memberStartDate`)
VALUES
    ('M0001', 'John', 'Doe', 'A', '1990-05-15', 'employee', '123 Main St', 'm', '123-456-7890', 'john.doe@example.com', 123456789, '2020-01-01'),
    ('M0002', 'Jane', 'Smith', 'B', '1985-09-20', 'donor', '456 Oak St', 'f', '987-654-3210', 'jane.smith@example.com', 987654321, '2019-03-15'),
    ('M0003', 'Michael', 'Johnson', 'C', '1988-12-10', 'client', '789 Elm St', 'm', '111-222-3333', 'michael.johnson@example.com', 111222333, '2020-06-30'),
    ('M0004', 'Emily', 'Williams', 'D', '1992-07-25', 'donor', '456 Pine St', 'f', '444-555-6666', 'emily.williams@example.com', 444555666, '2021-02-18'),
    ('M0005', 'David', 'Lee', 'E', '1984-03-12', 'employee', '321 Birch St', 'm', '777-888-9999', 'david.lee@example.com', 777888999, '2018-11-22'),
    ('M0006', 'Sarah', 'Miller', 'F', '1995-11-02', 'client', '678 Maple St', 'f', '222-333-4444', 'sarah.miller@example.com', 222333444, '2022-04-10'),
    ('M0007', 'James', 'Taylor', 'G', '1998-09-05', 'donor', '890 Cedar St', 'm', '555-666-7777', 'james.taylor@example.com', 555666777, '2017-07-05'),
    ('M0008', 'Olivia', 'Anderson', 'H', '1993-06-18', 'client', '432 Walnut St', 'f', '999-111-2222', 'olivia.anderson@example.com', 999111222, '2019-09-28'),
    ('M0009', 'William', 'Martinez', 'I', '1987-02-09', 'employee', '765 Oak St', 'm', '888-999-0000', 'william.martinez@example.com', 888999000, '2023-01-05'),
    ('M0010', 'Emma', 'Harris', 'J', '1991-04-30', 'donor', '654 Elm St', 'f', '666-777-8888', 'emma.harris@example.com', 666777888, '2021-07-15');


INSERT INTO `NLPO`.`Employee` (`memberID`, `jobTitle`, `salary`)
VALUES ('M0001', president, 65000),
       ('M0005', manager, 52000),
       ('M0009', customer service representative, null);

INSERT INTO `NLPO`.`Expenses` (`expenseID`, `approvedByID`, `dateOfPayment`, `amountOfExpense`, `typeOfExpense`, `descriptionOfExpense`)
VALUES
    (1001, 'M0001', '2023-07-01', 500.00, 'rent', 'Office Rent Payment'),
    (1002, 'M0001', '2023-07-05', 250.00, 'bill', 'Utilities Bill'),
    (1003, 'M0001', '2023-07-10', 1000.00, 'charity', 'Donation to Local Charity'),
    (1004, 'M0001', '2023-07-15', 750.00, 'rent', 'Office Rent Payment'),
    (1005, 'M0001', '2023-07-20', 300.00, 'bill', 'Internet Bill'),
    (1006, 'M0001', '2023-07-25', 50.00, 'charity', 'Food Drive Donation'),
    (1007, 'M0001', '2023-07-30', 800.00, 'rent', 'Office Rent Payment'),
    (1008, 'M0001', '2023-08-02', 100.00, 'bill', 'Phone Bill'),
    (1009, 'M0001', '2023-08-06', 200.00, 'charity', 'Community Center Donation'),
    (1010, 'M0001', '2023-08-10', 600.00, 'rent', 'Office Rent Payment');

INSERT INTO `NLPO`.`Donations` (`donationID`, `donorID`, `dateOfDonation`, `typeOfDonation`, `amountOfDonation`)
VALUES
    (1, 'M0002', '2023-07-27', 'money', 500.00),
    (2, 'M0004', '2023-07-26', 'product', 100.00),
    (3, 'M0002', '2023-07-25', 'money', 200.00),
    (4, 'M0010', '2023-07-24', 'product', 150.00),
    (5, 'M0004', '2023-07-23', 'money', 300.00),
    (6, 'M0007', '2023-07-22', 'product', 50.00),
    (7, 'M0002', '2023-07-21', 'money', 400.00),
    (8, 'M0004', '2023-07-20', 'product', 75.00),
    (9, 'M0002', '2023-07-19', 'money', 250.00),
    (10, 'M0010', '2023-07-18', 'product', 125.00);
    (11, 'M009', '2023-07-18', 'money', 100.00);

INSERT INTO `NLPO`.`Products` (`productID`, `donationID`, `donorID`, `productDescription`, `donationDate`, `sellingPrice`, `weight`, `inStock`)
VALUES
    (1, 2, 'M0004', 'Gadget B', '2023-07-26', 150.00, 1.2, 'yes'),
    (2, 4, 'M0010', 'Widget D', '2023-07-24', 230.00, 0.8, 'yes'),
    (3, 6, 'M0007', 'Accessory F', '2023-07-22', 120.00, 0.4, 'yes'),
    (4, 8, 'M0004', 'Gadget H', '2023-07-20', 145.00, 1.5, 'yes'),
    (5, 10, 'M0010', 'Widget J', '2023-07-18', 228.00, 0.6, 'yes');


INSERT INTO `NLPO`.`SalesItems` (`productID`, `saleID`)
VALUES
    -- Sale 1 with multiple products
    (1, 1),
    (2, 1),
    (3, 1),

    -- Sale 2 with one product
    (4, 2),

    -- Sale 3 with one product
    (5,3)

INSERT INTO `NLPO`.`Sales` (`saleID`, `dateOfSale`, `amountOfSale`, `deliveryType`, `deliveryFee`)
VALUES
    (1, '2023-07-01', 500.00, 'pickup', 0.00),
    (2, '2023-07-05', 145.00, 'delivery', 7.50),
    (3, '2023-07-10', 228.00, 'pickup', 0.00);