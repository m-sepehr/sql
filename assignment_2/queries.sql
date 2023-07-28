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