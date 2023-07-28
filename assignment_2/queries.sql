-- SQL Queries

/*Part 2 a)
List the details of all the clients that are volunteer employees and donors as well. 
Details include client ID, first-name, last-name, middle-initial, date-of-birth, address, gender, 
phone-number, email-address, social-security-number, job-title, and the start date of membership.*/

SELECT Member.memberID, firstName, lastName, middleInitial, dateOfBirth, address, gender, phone, email, ssn, jobTitle, memberStartDate
FROM Member, Employee, Donations
WHERE Member.memberType = 'employee' AND Member.memberID = Employee.memberID AND Member.memberID = Donations.donorID
AND Employee.salary = 0;

/*Part 2 b)
List the details of all the expenses that are paid in the month of June of 2023. 
Details includes expense ID, first name and last name of the president who approved the expense, 
the date of the payment of the expense, the amount of the expense, the type of the expense, 
and the description of the expense.*/

SELECT DISTINCT expenseID, firstName, lastName, dateOfPayment, amountOfExpense, typeOfExpense, descriptionOfExpense
FROM Member, Employee, Expenses
WHERE Member.memberID = Expenses.approvedByID AND Expenses.dateOfPayment BETWEEN '2023-06-01' AND '2023-06-30'
ORDER BY expenseID;

/*Part 2 c)
Give a report of the sales that have been delivered to the city of Brossard in June 2023. 
Details include sale ID, date of the sale, client’s first name and last name, product description, 
price and weight of the product. Results should be displayed in ascending order by saleID, 
then by first name, then by last name, then by weight of the product.*/

SELECT Sales.saleID, dateOfSale, firstName, lastName, productDescription, sellingPrice, weight
FROM Member, Sales, Products, SalesItems
WHERE Sales.deliveryType = 'delivery' AND Member.memberID = Sales.clientID AND Sales.saleID = SalesItems.saleID AND SalesItems.productID = Products.productID AND 
city = 'Brossard' 
AND dateOfSale BETWEEN '2023-06-01' AND '2023-06-30'
ORDER BY Sales.saleID, firstName, lastName, weight;

/*Part 2 d) 
Give a report of the sales that have been picked up by the buyers in June 2023. 
Details include sale ID, date of the sale, product description, price and weight of the product. 
Results should be displayed in ascending order by saleID, then by price of the product.*/

SELECT Sales.saleID, dateOfSale, productDescription, sellingPrice, weight
FROM Sales, Products, SalesItems
WHERE Sales.deliveryType = 'pickup' AND Sales.saleID = SalesItems.saleID AND SalesItems.productID = Products.productID 
AND Sales.dateOfSale BETWEEN '2023-06-01' AND '2023-06-30'
ORDER BY Sales.saleID, sellingPrice;

/*Part 2 e)
For every client who have made a purchase of at least 1000.00$ since the beginning of her/his membership, 
give a report of the sales she/he has done since her/his membership. The report should include the client’s 
first and last name, the date of the first sale she/he has made, the date of the last sale she/he has made, 
the total amount of sales she/he has made. The results should be displayed in increasing order by total amount 
of sales.*/

SELECT firstName,lastName, MIN(dateOfSale) AS firstSale, MAX(dateOfSale) AS lastSale, SUM(amountOfSale) AS totalSales
FROM Sales, Member
WHERE Member.memberID = Sales.clientID
GROUP BY firstName,lastName
HAVING totalSales >= 1000
ORDER BY totalSales;
