-- SQL Queries

/*Part 2 a)
List the details of all the clients that are volunteer employees and donors as well. 
Details include client ID, first-name, last-name, middle-initial, date-of-birth, address, gender, 
phone-number, email-address, social-security-number, job-title, and the start date of membership.*/

SELECT Member.memberID, firstName, lastName, middleInitial, dateOfBirth, address, gender, phone, email, ssn, jobTitle, memberStartDate
FROM Member, Employee, Donations
WHERE Member.memberType = 'employee' AND Member.memberID = Employee.memberID AND Member.memberID = Donations.donorID
AND Employee.salary = 0;
