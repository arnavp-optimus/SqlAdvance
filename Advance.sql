use Employee;

Select MAX(salary) AS salary
From Employee where salary < (Select MAX(salary) from Employee
 where 
salary < (select MAX(salary)
from Employee));

Select * from Employee;

SELECT * FROM Employee
WHERE First_Name LIKE 'A%';

SELECT Salary
FROM Employee
WHERE Salary BETWEEN 30000 AND 50000;

SELECT Employee_Id AS Id
FROM Employee;

Create table Department
(
dept_id int,
dept_name varchar(50)
);


 Insert into Department values(303,'Manager');
 Insert into Department values(304,'Kid');
 Insert into Department values(305,'student');
 Insert into Department values(306,'intern');

 Select * from Employee;
 Select * from Department;
 sp_rename 'Department.dept_id','Id','Column';


 SELECT First_Name
FROM Employee
INNER JOIN Department ON Employee.Employee_Id = Department.Id;

SELECT First_Name
FROM Employee
LEFT JOIN Department ON Employee.Employee_Id = Department.Id;

SELECT Employee.First_Name
FROM Department
Right JOIN Employee ON Employee.Employee_Id = Department.Id;


alter table Department add location varchar(50);
alter table Department add shipperId int;
select * from Department;

UPDATE Department
SET location = 'delhi'
WHERE Id=303;
UPDATE Department
SET location = 'gurugram'
WHERE Id=304;
UPDATE Department
SET location = 'puducherry'
WHERE Id=305;
UPDATE Department
SET location = 'bengaluru'
WHERE Id=306;

UPDATE Department
SET shipperId= '001'
WHERE Id=303;
UPDATE Department
SET shipperId= '002'
WHERE Id=304;
UPDATE Department
SET shipperId= '003'
WHERE Id=305;
UPDATE Department
SET shipperId= '004'
WHERE Id=306;


SELECT Employee.First_Name,Department.dept_name,Department.location
FROM Employee
LEFT JOIN Department ON Employee.designation = Department.dept_name;

SELECT Employee.First_Name,Department.dept_name,Department.location
FROM Employee
Right JOIN Department ON Employee.designation = Department.dept_name;

SELECT Employee.First_Name,Department.dept_name,Department.location
FROM Employee
FULL outer JOIN Department ON Employee.designation = Department.dept_name;


Create table ABC
(
firstname varchar(50),
location varchar(50)
);

Insert into ABC values('shaun','canada');
Insert into ABC values('lucy','america');
Insert into ABC values('nick','europe');

select * from ABC;

Create table XYZ
(
firstname varchar(50),
qualification varchar(50)
);

Insert into XYZ values('linda','ug');
Insert into XYZ values('lucka','pg');
Insert into XYZ values('loky','btech');

select * from XYZ;

Create table LMN
(
firstname varchar(50),
designation varchar(50)
);

Insert into LMN values('john','employee');
Insert into LMN values('jin','intern');
Insert into LMN values('jan','trainee');

select * from LMN;
Drop table LMN;

Create table LMN
(
firstname varchar(50),
designation varchar(50)
);

Insert into LMN values('john','employee');
Insert into LMN values('jin','intern');
Insert into LMN values('jan','trainee');

select * from LMN;

SELECT firstname FROM ABC
UNION
SELECT firstname FROM XYZ
UNION
SELECT firstname FROM LMN;



SELECT COUNT(Employee.First_Name),Department.dept_name
FROM Employee
RIGHT JOIN Department ON Employee.designation = Department.dept_name Group by  Department.dept_name;

select count(First_Name),designation from Employee  GROUP BY designation having count(First_name) >= 2;

SELECT * INTO BACKUPEMPLOYEE
FROM Employee;

Select * from BACKUPEMPLOYEE;

Select * into NEWBACKUP.dbo.Employee from
Employee.dbo.Employee;

alter table Department alter column Id int NOT NULL;
alter table Department add constraint df_p PRIMARY KEY (Id);

Create table const
(
 Id int NOT NULL PRIMARY KEY,
    LastName varchar(255) ,
    FirstName varchar(255)  ,
    Phonenumber int UNIQUE ,
	age int CHECK (age > 18),
	FOREIGN KEY (Id) REFERENCES Department(Id)
	);


	CREATE UNIQUE INDEX indexing
ON Employee (First_Name,Last_Name);

Alter table Employee add Dateofjoining date; 


UPDATE Employee
SET Dateofjoining= '1995-02-12'
WHERE Employee_Id=1;

Select * from Employee;

UPDATE Employee
SET Dateofjoining= '1996-03-13'
WHERE Employee_Id=2;
UPDATE Employee
SET Dateofjoining= '1997-04-14'
WHERE Employee_Id=3;
UPDATE Employee
SET Dateofjoining= '1998-05-15'
WHERE Employee_Id=4;
UPDATE Employee
SET Dateofjoining= '1999-06-16'
WHERE Employee_Id=5;
UPDATE Employee
SET Dateofjoining= '2000-07-17'
WHERE Employee_Id=6;

UPDATE Employee
SET Salary= 80000
WHERE Employee_Id=6;

CREATE VIEW view_name1 AS
SELECT Dateofjoining
FROM Employee
WHERE Salary>60000;

select * from view_name1;


drop table ABC;

Create table designation
(
 
    DesignationName varchar(255) ,
   Designation_id int
	
	);

	Insert into designation values ('student',301);
	Insert into designation values ('teacher',302);
	Insert into designation values ('kid',303);
	Insert into designation values ('managers',304);

	Select * from designation;



	Alter table Employee add designation_id int ;

	select * from Employee;

	UPDATE Employee
SET designation_id= 301
WHERE designation= 'student' ;

	UPDATE Employee
SET designation_id= 302
WHERE designation= 'teacher' ;

	UPDATE Employee
SET designation_id= 303
WHERE designation= 'kid' ;

	UPDATE Employee
SET designation_id= 304
WHERE designation= 'managers' ;

	SELECT CAST(GETDATE() AS BINARY(8));
	SELECT CAST(GETDATE() AS DATE);
	Select convert(varchar(30),getdate()) as DateConvert;

	select format(getdate(),'dddd  dd MMM,yy hh:mm:ss tt');
	
	CONVERT(datetime(), expression	, style)
	
	Alter table Employee add pf decimal;		

	select * from Employee;
	 alter table Employee drop column pf;

	 Alter table Employee add pf decimal(10,2);

	 	UPDATE Employee
SET pf= salary*0.1275;

