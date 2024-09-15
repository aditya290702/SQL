-- LAB 2 :-

-- CREATING DATABASE
CREATE DATABASE IF NOT EXISTS Bank_db;

USE Bank_db;

-- CREATING TABLES
CREATE TABLE IF NOT EXISTS Customer(cust_name VARCHAR(20) NOT NULL, cust_street VARCHAR(20) NOT NULL, cust_city VARCHAR(20) NOT NULL, PRIMARY KEY(cust_name));
CREATE TABLE IF NOT EXISTS Loan(loan_number VARCHAR(15) NOT NULL, loan_amount FLOAT, branch_name VARCHAR(15), PRIMARY KEY(loan_number)); 
CREATE TABLE IF NOT EXISTS Branch(branch_name VARCHAR(20) NOT NULL, branch_city VARCHAR(20) NOT NULL, assets FLOAT NOT NULL, PRIMARY KEY(branch_name));
CREATE TABLE IF NOT EXISTS Account(account_number VARCHAR(15) NOT NULL, branch_name VARCHAR(20) NOT NULL, balance FLOAT NOT NULL, PRIMARY KEY(account_number));
CREATE TABLE IF NOT EXISTS Depositor(cust_name VARCHAR(20) NOT NULL, account_number VARCHAR(15) NOT NULL, PRIMARY KEY(account_number, cust_name));
CREATE TABLE IF NOT EXISTS Borrower(cust_name VARCHAR(20) NOT NULL, loan_number VARCHAR(15) NOT NULL, CONSTRAINT PK_borrower PRIMARY KEY(cust_name, loan_number));

-- INSERTING VALUES INTO TABLES
INSERT INTO Customer
VALUES
("Curry", "North", "Rye"),
("Lindsay", "Park", "Pittsfield"),
("Turner", "Putnam", "Stamford"),
("Williams", "Nassau", "Princeton"),
("Adams", "Spring", "Pittsfield"),
("Johnson", "Alma", "Palo Alto"),
("Glenn", "Sand Hill", "Woodside"),
("Brooks", "Senator", "Brooklyn"),
("Green", "Walnut", "Stamford"),
("Jackson", "University", "Salt Lake"),
("Majeris", "First", "Rye"),
("McBride", "Safety", "Rye");

INSERT INTO Branch VALUES("Downtown", "Brooklyn", 900000);
INSERT INTO Branch VALUES("Redwood", "Palo Alto", 2100000);
INSERT INTO Branch VALUES("Perriridge", "Horse Neck", 1700000);
INSERT INTO Branch VALUES("Mianus", "Horse Neck", 400200);
INSERT INTO Branch VALUES("Round Hill", "Horse Neck", 8000000);
INSERT INTO Branch VALUES("Pownal", "Benington", 400000);
INSERT INTO Branch VALUES("North Town", "Rye", 3700000);
INSERT INTO Branch VALUES("Brighton", "Brooklyn", 7000000);
INSERT INTO Branch VALUES("Central", "Rye", 400280);

INSERT INTO Account VALUES
("A-101", "Downtown", 500),
("A-215", "Mianus", 700),
("A-102", "Perriridge", 400),
("A-305", "Round Hill", 350),
("A-201", "Perriridge", 900),
("A-222", "Redwood", 700),
("A-217", "Brighton", 750),
("A-333", "Central", 850),
("A-444", "North Town", 625);

-- LAB 2 QUERIES
-- Q1) Find all customer details of customers who stay at Harrison city
SELECT cust_name FROM Customer WHERE cust_city ='Harrison';

-- Q2) Find account number with balances between 700 and 900 dollars
SELECT account_number FROM Account WHERE balance BETWEEN 700 AND 900;

-- Q3) Find all branch details whose assets are greater than 400000 dollars.
SELECT * FROM Branch WHERE assets > 400000;

-- Q4) Find borrower names and loan amount of customers who have taken loan amount greater than 900 dollars. Reduce their loan amount by 100 dollars in the query.
SELECT cust_name, (loan_amount - 100) FROM Borrower, Loan WHERE Loan.loan_number = Borrower.loan_number AND Loan.loan_amount > 900;

-- Q5) Display distinct cities of customers.
SELECT DISTINCT cust_city FROM Customer;

-- Q7) Delete all tuples of borrower table
DELETE FROM Borrower;

-- Q9) Find customer names who have an account in the same city branch that they reside in.
SELECT C.cust_name
FROM Customer C, Account A, Branch B, Depositor D
WHERE D.account_number = A.account_number AND A.branch_name = B.branch_name AND C.cust_name = D.cust_name AND B.branch_city = C.cust_city;

-- LAB 3:-

-- 1) Add data into borrower table
INSERT INTO Borrower(cust_name, loan_number) VALUES
('Jones','L-17'),
('Smith','L-23'),
('Hayes','L-15'),
('Jackson','L-14'),
('Curry','L-93'),
('Smith','L-11'),
('Williams','L-17'),
('Adams','L-16'),
('McBride','L-20'),
('Smith','L-21');

-- 2) Add foreign key constraints to Account, Depositor, Loan, and Borrower table.
ALTER TABLE Borrower ADD CONSTRAINT FK_loan_borrower FOREIGN KEY(loan_number) REFERENCES Loan(loan_number) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Loan ADD CONSTRAINT FK_loan_branch FOREIGN KEY(branch_name) REFERENCES Branch(branch_name) ON DELETE SET NULL ON UPDATE CASCADE;

-- 3) Update values of tables where the foreign keys creation is giving errors.
UPDATE Account SET branch_name = "Perriridge" WHERE branch_name = "Perriridge";

-- 4) Find the names and cities of all borrowers
SELECT DISTINCT C.cust_name, C.cust_city
FROM Customer AS C, Borrower AS B
WHERE C.cust_name = B.cust_name;

-- 5) Find the average account balance at Perriridge branch
SELECT AVG(balance) AS "Average balance at Perriridge"
FROM Account
WHERE branch_name="Perriridge";

-- 6) Find names of customers on streets with names ending in “Hill”
SELECT cust_name FROM Customer WHERE cust_street LIKE "%Hill";

-- 7) Find the names, loan_number, and loan amount of all customers. Rename loan_number as loan_id
SELECT DISTINCT B.cust_name, L.loan_number AS loan_id, L.loan_amount
FROM Loan L, Borrower B
WHERE B.loan_number = L.loan_number;

-- 8) Display all branch details of a branch with the highest assets
SELECT *
FROM Branch
ORDER BY assets DESC
LIMIT 1;

-- 9) Find the average account balance at each branch
SELECT branch_name AS Branch, AVG(Account.balance) AS "Average Balance"
FROM Account
GROUP BY branch_name;

-- 10) Find the number of unique depositors for each branch
SELECT A.branch_name AS Branch, COUNT(DISTINCT D.cust_name) AS "No. of unique depositors"
FROM Depositor D, Account A
WHERE A.account_number = D.account_number
GROUP BY A.branch_name;

-- 11) Find all customers who have at least two accounts
SELECT D.cust_name AS "Customers having at least two accounts"
FROM Depositor D
JOIN Account A ON D.account_number = A.account_number
GROUP BY D.cust_name
HAVING COUNT(DISTINCT D.account_number) >= 2;

-- LAB 3 CONTINUED

-- Q12) Find all customers who have a loan, an account, or both.
SELECT DISTINCT cust_name
FROM Customer
WHERE cust_name IN (SELECT cust_name FROM Borrower) OR cust_name IN (SELECT cust_name FROM Depositor);

-- Q13) Find all customers who have an account but not a loan.
SELECT DISTINCT D.cust_name
FROM Depositor D
WHERE cust_name NOT IN (SELECT cust_name FROM Borrower);

-- Q14) Display the names of the customers at Perriridge branch in alphabetical order.
SELECT DISTINCT C.cust_name
FROM Customer C, Branch Br, Account A, Depositor D, Borrower B, Loan L
WHERE A.branch_name = Br.branch_name
AND A.account_number = D.account_number
AND L.loan_number = B.loan_number
AND Br.branch_name = "Perriridge"
ORDER BY C.cust_name;

-- Q15) Display loan data, ordered by decreasing amount and increasing loan_number.
SELECT *
FROM Loan
ORDER BY loan_amount DESC, loan_number ASC;

-- Q16) Find the number of depositors for each branch.
SELECT B.branch_name, COUNT(DISTINCT D.cust_name) AS "No. of depositors"
FROM Branch B, Depositor D, Account A
WHERE B.branch_name = A.branch_name
AND D.account_number = A.account_number
GROUP BY B.branch_name;

-- Q17) Find the names of all branches where the average account balance is more than 1200.
SELECT branch_name, AVG(balance) 
FROM Account
GROUP BY branch_name
HAVING AVG(balance) > 1200;

-- Q18) Find all customers who have an account at all branches located in Brooklyn.
SELECT DISTINCT D.cust_name
FROM Depositor D, Account A, Branch B
WHERE A.branch_name = B.branch_name
AND A.account_number = D.account_number
GROUP BY D.cust_name
HAVING COUNT(DISTINCT B.branch_name) = (SELECT COUNT(branch_name) FROM Branch WHERE branch_city = "Brooklyn");


-- LAB 4

-- Q1) Find all customers who have a loan, an account or both.
SELECT DISTINCT cust_name
FROM Customer
WHERE cust_name IN (SELECT cust_name FROM Loan UNION SELECT cust_name FROM Account);

-- Q2) Find the names of all branches that have greater assets than all branches located in Brooklyn.
SELECT branch_name
FROM Branch
WHERE branch_city != 'Brooklyn'
AND assets > ALL (SELECT assets FROM Branch WHERE branch_city = 'Brooklyn');

-- Q4) Find all customers who have an account at all branches located at Brooklyn.
SELECT DISTINCT D.cust_name
FROM Depositor D
WHERE NOT EXISTS (
    (SELECT branch_name FROM Branch WHERE branch_city = 'Brooklyn')
    EXCEPT
    (SELECT branch_name FROM Account A, Depositor D1 WHERE D1.account_number = A.account_number AND D1.cust_name = D.cust_name)
);

-- Q5) Find the names of all branches and their cities who have loans using inner join construct.
SELECT DISTINCT B.branch_name, B.branch_city
FROM Branch B
INNER JOIN Loan L ON B.branch_name = L.branch_name;

-- Q6) Using left outer and right outer join construct, display all customer names and cities with their account numbers. Also display customers who don't have accounts.
SELECT C.cust_name, B.branch_city
FROM Customer C
LEFT JOIN Depositor D ON D.cust_name = C.cust_name
LEFT JOIN Account A ON A.account_number = D.account_number
LEFT JOIN Branch B ON B.branch_name = A.branch_name;

-- Q7) Insert a null branch name in Accounts table with account number A-102 and Balance 800.
INSERT INTO Account (account_number, branch_name, balance)
VALUES ('A-102', NULL, 800);

-- Q8) Display all branches and assets with their account numbers. Consider all account numbers (full outer join).
(SELECT B.branch_name, A.account_number, B.assets
FROM Branch B
LEFT JOIN Account A ON A.branch_name = B.branch_name)
UNION
(SELECT B.branch_name, A.account_number, B.assets
FROM Branch B
RIGHT JOIN Account A ON A.branch_name = B.branch_name);