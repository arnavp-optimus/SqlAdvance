select top 5 First_Name, salary , rank() over(order by salary desc) as rank from Employee;


with cte_alternate
as
(
select First_Name, salary, rank() over(order by salary desc) as ranks from Employee
)
select top 3  * from cte_alternate where ranks%2 <>0;

select * from Employee;


select designation,count(*) from Employee group by rollup(designation);
select designation,count(*) from Employee group by cube(designation);
select designation ,count(*),designation_id from Employee group by cube(designation,designation_id);

SELECT First_Name,designation
FROM Employee
EXCEPT
SELECT First_Name,designation
FROM Employee
where Dateofjoining >= '2017-07-24'
order by First_Name;


Create Proc sp 
as 
begin
select First_Name, Sex from Employee
end

exec sp;