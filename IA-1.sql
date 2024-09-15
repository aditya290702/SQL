create Database Pharmacy_DB;
use Pharmacy_DB;

create table Customer(SSN int primary key, Name varchar(20) not null, Gender char(1) not null, Address varchar(100));

create table Employee(SSN int primary key,Company_ID int unique,Name varchar(20) not null, Salary float,DOB date,
Role varchar(10),
CHECK(Salary > 10000));

create table Prescription(PrescriptionID int,Customer_SSN int,Doctor_SSN int,Drug_Name varchar(20),Qty int,
Prescribed_date datetime not null, PRIMARY KEY(PrescriptionID,Drug_Name),FOREIGN KEY(Customer_SSN) references Customer
(SSN) on update cascade on delete set null,FOREIGN KEY(Doctor_SSN) references Employee(SSN) on update cascade on
delete set null
  );

create table Order1(Order_id int ,Drug_Name varchar(20),Prescription_ID int,Ordered_qty int,Price float,Employee_SSN
int,
Order_Date date,PRIMARY KEY(Order_id,Drug_Name));



insert into Customer values
(123456789,"Suraj Joshi","M","10%,Opp Rhythm House,Hutatma Chowk,Mumbai");

insert into Customer values
(333445555,"Prakash Mistri","M","10,G.m. Road,Opp Pestom Sagar,Chembur, Mumbai");
insert into Customer values(999887777,"Mira Bano","F",null);



insert into Employee
values(666884444, 1234, "Malti Sangma", 30000, "1992-09-15", "Chemist");
insert into Employee
values(453453453, 5678, "Mira Rao", 50000, "1996-07-31", "Doctor");
insert into Employee values(987987987, 2345, "Vikas Kumar", 25000, "1990-09-15", "Chemist");
insert into Employee values(888665555, 3421, "Santhosh Rai", 53000, "1982-07-31", "Doctor");


insert into Prescription values (1001, 123456789, 453453453, "Amoxicillin", 15, "2023-09-15");

insert into Prescription values (1001, 123456789, 453453453, "Paracetamol", 9, "2023-09-15");

insert into Prescription values (1001, 123456789, 453453453, "Ibuprofen", 9, "2023-09-15");

insert into Prescription values (1002, 123456789, 888665555, "Ondansetron", 9, "2023-12-12");

insert into Prescription values (1002, 123456789, 888665555, "Dexamethasone", 6, "2023-12-12");

insert into Prescription values (1003, 333445555, 888665555, "Ciprofloxacin", 1, "2023-02-25");

insert into Prescription values (1004, 333445555, 888665555, "Naproxen", 9, "2023-01-20");

insert into Prescription values (1005, 333445555, 888665555, "Paracetamol", 9, "2023-01-13");

insert into Prescription values (1006, 333445555, 888665555, "Matamucil", 9, "2024-01-13");

insert into Prescription values (1006, 333445555, 888665555, "Docusate sodium", 9, "2024-01-13");


insert into Order1 values(5001,"Amoxicillin",1001,12,120,666884444,"2023-09-16");
insert into Order1 values(5001,"Paracetamol",1001,9,72,666884444,"2023-09-16");
insert into Order1 values(5002,"Ondansetron",1002,9,59.5,987987987,"2023-12-12");
insert into Order1 values(5002,"Dexamethasone",1002,9,54.3,987987987,"2023-12-12");
insert into Order1 values(5003,"Paracetamol",1005,9,72,666884444,"2023-10-13");
insert into Order1 values(5004,"Naproxen",1004,6,53.28,888665555,"2023-01-21");


alter table Order1 add constraint fk1 FOREIGN KEY(Prescription_ID,Drug_Name) references Prescription(PrescriptionID,
Drug_Name) on
update
cascade on
delete cascade;

alter table Order1 add constraint fk3  FOREIGN KEY(Employee_SSN) references Employee(SSN) on update cascade on delete
cascade;

select * from Customer;

select * from Employee;

select * from Order1;

select * from Prescription;

-- Q1 :

select *
from Customer
where Address like "10\%%" or Address is null;

-- -- +-----------+-------------+--------+-------------------------------------------+
-- | SSN       | Name        | Gender | Address                                   |
-- +-----------+-------------+--------+-------------------------------------------+
-- | 123456789 | Suraj Joshi | M      | 10%,Opp Rhythm House,Hutatma Chowk,Mumbai |
-- | 999887777 | Mira Bano   | F      | NULL                                      |
-- +-----------+-------------+--------+-------------------------------------------+


-- Q2 :

alter table Order1 add CHECK(Price>=10);

-- Q3 :

select P.PrescriptionID,P.Drug_Name,C.Name
from Customer C ,Prescription P
where SSN=Customer_SSN
and P.PrescriptionID is not null
and not exists(select Order_id from Order1 O where O.Prescription_ID=P.PrescriptionID and O.Drug_Name=P.Drug_Name);

-- Ans:

-- +----------------+-----------------+----------------+
-- | PrescriptionID | Drug_Name       | Name           |
-- +----------------+-----------------+----------------+
-- |           1001 | Ibuprofen       | Suraj Joshi    |
-- |           1003 | Ciprofloxacin   | Prakash Mistri |
-- |           1006 | Docusate sodium | Prakash Mistri |
-- |           1006 | Matamucil       | Prakash Mistri |
-- +----------------+-----------------+----------------+



-- Q4 :

create view Order_Report as
(select Order_id,E.Name as "Employee Name",Order_Date,sum(Ordered_qty) as "Total Qty",sum(Price) as "Total Price"
from Order1 as O,Employee E where O.Employee_SSN=E.SSN
group by Order_id,E.Name,Order_Date);


-- Ans:
-- +----------+---------------+------------+-----------+--------------------+
-- | Order_id | Employee Name | Order_Date | Total Qty | Total Price        |
-- +----------+---------------+------------+-----------+--------------------+
-- |     5001 | Malti Sangma  | 2023-09-16 |        21 |                192 |
-- |     5003 | Malti Sangma  | 2023-10-13 |         9 |                 72 |
-- |     5004 | Santhosh Rai  | 2023-01-21 |         6 | 53.279998779296875 |
-- |     5002 | Vikas Kumar   | 2023-12-12 |        18 | 113.79999923706055 |
-- +----------+---------------+------------+-----------+--------------------+

-- Q5

select distinct O.Order_id,E.Name
from Prescription P,Order1 O,Employee E
where P.Doctor_SSN=E.SSN and O.Employee_SSN=P.Doctor_SSN;

-- +----------+--------------+
-- | Order_id | Name         |
-- +----------+--------------+
-- |     5004 | Santhosh Rai |
-- +----------+--------------+


--- Q6

select Drug_Name,count(distinct Doctor_SSN)
from Prescription
group by Drug_Name
having count(distinct Doctor_SSN)>1;

-- Ans
-- +-------------+----------------------------+
-- | Drug_Name   | count(distinct Doctor_SSN) |
-- +-------------+----------------------------+
-- | Paracetamol |                          2 |
-- +-------------+----------------------------+


-- Q7

select E.Name
from Employee E
where not exists(
(select Drug_Name from Prescription where year(Prescribed_date)=2024)
except
(select Drug_Name from Prescription P2 where year(Prescribed_date)=2024
and P2.Doctor_SSN=E.SSN));

-- Ans

-- +--------------+
-- | Name         |
-- +--------------+
-- | Santhosh Rai |
-- +--------------+







