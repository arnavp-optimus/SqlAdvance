Alter table Employee add constraint def DEFAULT 18 for age;
Alter table Employee add constraint defa DEFAULT 'trainee' for designation;
Insert into Employee (Employee_ID,First_Name,Last_Name,Sex,Active_Status) values (7,'Sneh', 'Rathore', 'F',1);
Select * from Employee;
Update Employee set designation='Managers' ,Salary='50000' where salary>40000 and age>35;
Select * from Employee;
Delete from Employee where Active_Status=1 and designation='trainee';
Select * from Employee;