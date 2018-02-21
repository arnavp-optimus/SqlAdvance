use Assignment1

 select * from t_product_master;
  select * from A;
 select * from temp1;
  select * from temp2;


 SELECT A.*,((A.Orderq * t_product_master.Cost_per_item)-COALESCE(A.Amountp,0)) AS Balance FROM A
 INNER JOIN t_product_master on A.Pid=t_product_master.Product_Id

 CREATE TABLE TEMP3
 (
 Uid varchar(50),
 Pid varchar(50),
 Orderq int,
 Amountp int,
 Balanace int
 );

 insert into TEMP3  SELECT A.*,((A.Orderq * t_product_master.Cost_per_item)-COALESCE(A.Amountp,0)) AS Balance FROM A
 INNER JOIN t_product_master on A.Pid=t_product_master.Product_Id

 
 select * from TEMP3;


 SELECT t_user_master.User_Name,t_product_master.Product_Name,temp3.Orderq,temp3.Amountp,TEMP3.Balanace
 FROM TEMP3 INNER JOIN t_user_master
ON TEMP3.Uid=t_user_master.User_Id
Inner join t_product_master on temp3.Pid=t_product_master.Product_Id;

create table temp4
(
User_Name varchar(50),
Product_Name varchar(50),
Ordered_Quantity int,
Amount_Paid int,
Balance int
);

insert into temp4  SELECT t_user_master.User_Name,t_product_master.Product_Name,temp3.Orderq,temp3.Amountp,TEMP3.Balanace
 FROM TEMP3 INNER JOIN t_user_master
ON TEMP3.Uid=t_user_master.User_Id
Inner join t_product_master on temp3.Pid=t_product_master.Product_Id;

SELECT t_user_master.User_Name,t_product_master.Product_Name,A.Orderq,A.Amountp,
((A.Orderq * t_product_master.Cost_per_item)-COALESCE(A.Amountp,0)) AS Balance,
MAX(Transaction_Date) as Last_Transaction
 FROM A INNER JOIN t_user_master
ON A.Uid=t_user_master.User_Id
Inner join t_product_master on A.Pid=t_product_master.Product_Id inner join t_transaction
on t_transaction.Product_Id = t_product_master.Product_Id
group by t_product_master.Product_Name,
t_user_master.User_Name,
A.Orderq,
a.Amountp,
t_product_master.Cost_per_item


SELECT A.*,((A.Orderq * t_product_master.Cost_per_item)-COALESCE(A.Amountp,0)) AS Balance FROM A
 INNER JOIN t_product_master on A.Pid=t_product_master.Product_Id

select * from temp4;
select * from t_transaction) x;

--select t_transaction.MAX(Transaction_Date), temp4.User_Name, temp4.Product_Name, temp4.Ordered_Quantity, temp4.Amount_Paid,
--temp4.Balance from temp4 inner join t_transaction on

select * from t_transaction

alter table temp4 add Last_Transaction date
insert into temp4 (
select MAX(Transaction_Date) from t_transaction group by User_Id, Product_Id 
update temp4 set Last_Transaction = ;
-- Query to craete table
