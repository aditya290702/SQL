-- Create a database named "Company"
create database Company;
use Company;

-- Define the Employee table
create table Employee
(
Fname varchar(10) not null,
Minit varchar(1),
Lname varchar(15) not null,
SSN int,
Bdate date,
Adress varchar(30),
Sex varchar(1),
Salary int(7),
Super_ssn int(10),
Dno int not null,
primary key(SSN));
 
-- Define the Department table
create table Department
(Dname varchar(20) not null,
Dnumber int,
Mgr_SSN int not null,
Mgr_start_date date,
primary key(Dnumber));

-- Define the Project table
create table Project
(Pname varchar(15) not null,
Pnumber int primary key,
Plocation varchar(30),
Dnum int(10));

-- Define the Works_on table
create table Works_on
(Essn int,
Pno int,
Hours float not null,
primary key(Essn, Pno));

-- Define the Dependent table
create table Dependent
(Essn int,
Dependent_name varchar(20) not null,
Sex varchar(2),
Bdate date,
Relationship varchar(20),
primary key (Essn, Dependent_name));

-- Define the Dept_Locations table
create table Dept_Locations
(Dnumber int,
Dlocations varchar(30),
primary key(Dnumber,Dlocations));


-- Insert data into the Employee table
insert into Employee values 
("John","B","Smith",123456789,"1965-01-09","731 Fondren, Houston TX","M",30000,333445555,5),
("Franklin","T","Wong",333445555,"1965-12-08","638 Voss, Houston TX","M",40000,888665555,5),	
("Alicia","J","Zelaya",999887777,"1968-01-19","3321 Castle, Spring TX","F",25000,987654321,4),
("Jennifer","S","Wallace",987654321,"1941-06-20","291 Berry, Bellaire TX","F",43000,888665555,4),
("Ramesh","K","Narayan",666884444,"1962-09-15","975 Fire Oak, Humble TX","M",38000,333445555,5),
("Joyce","A","English",453453453,"1972-07-31","5631 Rice, Houston TX","F",25000,333445555,5),
("Ahmad","V","Jabbar",987987987,"1969-03-29","980 Dallas, Houston TX","M",25000,987654321,4),
("James","E","Borg",888665555,"1937-11-10","450 Stone, Houston TX","M",55000,null,1);

-- Insert data into the Department table
insert into Department values ("Research", "5", "333445555", "1988-05-22");
insert into Department values ("Administration", "4", "987654321", "1995-01-01");
insert into Department values ("Headquarters", "1", "888665555", "1981-06-19");

-- Insert data into the Project table
insert into Project values("ProductX", 1, "Bellaire", 5);
insert into Project values("ProductY", 2, "Sugarland", 5);
insert into Project values("ProductZ", 3, "Houston", 5);
insert into Project values("Computerization", 10, "Stafford", 4);
insert into Project values("Reorganization", 20, "Houston", 1);
insert into Project values("Newbenefits", 30, "Stafford", 4);


-- Insert data into the Works_on table
insert into Works_on values ("123456789", "2", "7.5");
insert into Works_on values ("666884444", "3", "40");
insert into Works_on values ("453453453", "1", "20");
insert into Works_on values ("453453453", "2", "20");
insert into Works_on values ("333445555", "2", "10");
insert into Works_on values ("333445555", "3", "10");
insert into Works_on values ("333445555", "10", "10");
insert into Works_on values ("333445555", "20", "10");
insert into Works_on values ("999887777", "30", "30");
insert into Works_on values ("999887777", "10", "10");
insert into Works_on values ("987987987", "10", "35");
insert into Works_on values ("987987987", "30", "5");
insert into Works_on values ("987654321", "30", "20");
insert into Works_on values ("987654321", "20", "15");
insert into Works_on values ("888665555", "20", "16");


-- Insert data into the Dependent table
insert into Dependent values(333445555,"Alice","F","1986-04-04","Daughter");
insert into Dependent values(333445555,"Theodore","M","1983-10-25","Son");
insert into Dependent values(333445555,"Joy","F","1958-05-03","Spouse");
insert into Dependent values(987654321,"Abner","M","1942-02-28","Spouse");
insert into Dependent values(123456789,"Michael","M","1988-01-04","Son");
insert into Dependent values(123456789,"Alice","F","1988-12-30","Daughter");
insert into Dependent values(123456789,"Elizabeth","F","1967-05-05","Spouse");


-- Insert data into the Dept_locations table
insert into Dept_Locations values(1,"Houston");
insert into Dept_Locations values(4,"Stafford");
insert into Dept_Locations values(5,"Bellaire");
insert into Dept_Locations values(5,"Sugarland");
insert into Dept_Locations values(5,"Houston");


-- Alter the Employee table 
alter table Employee
add constraint supervisor_key foreign key(Super_ssn) references Employee(SSN) on delete set null on update cascade;

alter table Employee
add constraint dept_key foreign key(Dno) references Department(Dnumber) on delete cascade on update cascade;


-- Alter the Department table
alter table Department
add constraint mgr_ssn_fk foreign key(Mgr_SSN) references Employee(SSN) on delete cascade on update cascade;

-- Alter the Project table
alter table Project
add constraint dnum_fk foreign key (Dnum) references Department(Dnumber) on delete set null on update cascade;

-- Alter the Works_on table
alter table Works_on
add constraint Essn_fk foreign key (Essn) references Employee(SSN) on delete cascade on update cascade;

alter table Works_on
add constraint pno_fk foreign key (Pno) references Project(Pnumber) on delete cascade on update cascade;


-- Alter the Department table
alter table Dependent
add constraint essn_fk2 foreign key (Essn) references Employee(SSN) on delete cascade on update cascade;


-- Alter the Dept_locations table
alter table Dept_Locations
add constraint Dnumber_fk foreign key (Dnumber) references Department(Dnumber) on delete cascade on update cascade;


-- Queries
-- Add a constraint to ensure that department number is between 0 and 20.
alter table Department
add constraint chk_dnum check (Dnumber between 0 and 20);

-- Retrieve the birthdate and address of employee named “John B Smith”
select Bdate, Adress
from Employee 
where Fname="John" and Minit="B" and Lname="Smith";

-- Retrieve the name and address of employees working for the Research Department.
select Fname, Minit, Lname, Adress
from Employee, Department
where Dname="Research" and Dnumber=Dno;

-- For each employee, retrieve their first and last name and their Supervisor’s first name and last name.
select E.Fname as EFname, E.Lname as ELname, S.Fname as SFname, S.Lname as SLname
from Employee as E, Employee as S
where E.Super_ssn=S.SSN;

-- Make a list of all project numbers involving an employee with last name “Smith” either as a worker or as a manager of the controlling department.
select distinct Pnumber
from Project, Employee, Works_on, Department
where Lname="Smith" and Essn=SSN or SSN=Mgr_SSN and Pno=Pnumber;

-- Display the resulting salaries of every employee working on “Product X” project with a 10% raise.
select Fname, Lname, 1.1 * Salary
from Employee, Works_on, Project
where SSN=Essn and Pno=Pnumber and Pname="ProductX";

-- Change the location and controlling department number of project number 10 to “Bellaire” and 5 respectively.
update Project
set Plocation="Bellaire", Dnum=5
where Pnumber=10;

-- Report the first and last name of each female employee who works on Project 7 at least 10 hours per week.
select Fname, Lname
from Employee, Works_on as w
where  w.Essn=SSN and Sex="F" and Hours>=10 and Pno=7;

-- For each employee, retrieve their first and last name and the number of dependents.
Select Fname, Lname, count(Dependent_name) as no_dependents
from Employee, Dependent
where Essn=SSN
group by Essn;

-- For each department name, retrieve the number of employees working in it using a nested query.
select Dname,
(select count(*) 
from Employee 
where Dno=Dnumber) as no_of_employee
from Department;

-- Retrieve the names of employees working on all projects controlled by department number 5 (Correlated Subquery).
select Fname, Lname
from Employee
Where not exists (select Pnumber from Project where Pnumber=5 except
select Pno from Works_on where Essn=SSN);

-- Retrieve names of employees without a supervisor.
select Fname, Lname
from Employee
where Super_ssn is null;

-- Find the max, min, and average salary of employees working in the Research department.
select max(Salary) as max_salary, min(Salary) as min_salary, avg(Salary) as avg_salary 
from Employee, Department
where Dno=Dnumber and Dname="Research";

-- For each project with more than two employees, retrieve the project details.
select Project.*
from Project, Works_on as w
where Pnumber=Pno 
group by Pnumber
having count(w.Essn) > 2;

-- Retrieve all employees with an address containing “Houston TX”.
select * from Employee
where Adress like "%Houston TX%";


show databases;
use company;

-- 1. Update the Department of the EMPLOYEE whose Ssn = ‘999887777’ to 7

UPDATE employee SET Dno = 7 WHERE Super_ssn = 999887777;

-- 2. Modify the Mgr_ssn and Mgr_start_date of the DEPARTMENT tuple with Dnumber = 5 to ‘123456789’ and ‘2007-10-01’, respectively.

 UPDATE department Set Mgr_SSN = 123456789,Mgr_start_date = '2007-10-01' WHERE Dnumber = 5;

-- 3.Find all employees who were born during the 1950s.

 select * from employee where year(Bdate) = '1950';

-- 4. Retrieve a list of employees and the projects they are working on, ordered by department and, within each department, ordered alphabetically by last name, then first name.

SELECT employee.Fname, employee.Minit, employee.Lname, works_on.Pno
FROM employee
JOIN works_on ON employee.SSN = works_on.Essn
ORDER BY employee.Lname, employee.Fname;

-- 5.Using ALL construct, display the first name and last name of employees whose salary is greater than salary of all employees who work in department 5.

select employee.Fname,employee.Minit,employee.Lname from employee where employee.Salary > (select max(Salary) from employee where employee.Dno= 5);


-- 6. Using EXISTS clause, Retrieve the name of each employee who has a dependent with the same first name and is the same sex as the employee.

SELECT Fname, Lname FROM employee e WHERE EXISTS (SELECT * FROM dependent d WHERE d.Essn = e.SSN AND d.Sex = e.Sex AND d.Dependent_name = e.Fname);

-- 7. Solve the 6th question using IN clause query.


-- 8.Retrieve the names of employees who have no dependents.

SELECT Fname, Lname FROM employee e WHERE NOT EXISTS (SELECT * FROM dependent d WHERE d.Essn = e.SSN);


-- 9.Using exists clause, List the names of managers who have at least one dependent.

SELECT Fname, Lname FROM employee e WHERE EXISTS (SELECT * FROM dependent d WHERE d.Essn = e.SSN) ;


-- 10. Retrieve the Social Security numbers of all employees who work on project numbers 1, 2, or 3

SELECT Essn FROM works_on WHERE Pno IN ('1', '2', '3');

-- 11. Using Left outer join, list the employees and their supervisor's name.

SELECT e.Fname AS EmployeeFirstName, e.Lname AS EmployeeLastName, s.Fname AS SupervisorFirstName, s.Lname AS SupervisorLastName FROM employee e LEFT JOIN employee s ON e.Super_ssn = s.Ssn;

-- 12.Retrieve the total number of employees in the company

select count(*) as Total from employee;

-- 13. Count the number of distinct salary values in the database.

SELECT COUNT(DISTINCT Salary) AS Distinct_Salary from employee;

-- 14. For each department that has more than three employees, retrieve the department number and the number of its employees who are making more than $35,000.

SELECT Dno, COUNT(*) AS EmployeeCount FROM employee WHERE Salary > 35000 GROUP BY Dno HAVING EmployeeCount > 1;


