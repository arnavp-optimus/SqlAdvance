------------------------------------CASE STATEMENT---------------------------

Select First_Name,Last_Name,"Verdict" =
CASE 

When salary >=50000 and age < 35 THEN 'Yes'
Else 'No'
END
 from Employee

 ------------------------------STORED PROCEDURE--------------------------

 CREATE TABLE product
( 
productid INT NOT NULL PRIMARY KEY,
name VARCHAR(50),
unitprice INT,
qty_available INT
)




Insert into product values(1, 'Laptops', 2340, 100)
Insert into product values(2, 'Desktops', 3467, 50)


CREATE TABLE sale
( 
salesid INT NOT NULL PRIMARY KEY,
productid INT,
qty_sold INT
)

Insert into sale values(1, 1, 50)

sp_Rename 'SALE.productid','s_productid','Column';



select * from sale
select * from product

CREATE PROCEDURE spSellProduct
@ProductId int,
@QuantityToSell int
AS
BEGIN

Declare @StockAvailable int
Select @StockAvailable = qty_available
from product where productid = @ProductId


IF(@StockAvailable < @QuantityToSell)
  BEGIN
 RAISERROR('Not enough stock available',16,1)
  END

ELSE
  BEGIN
   Begin Try
    Begin Transaction
        
         Update product set qty_available= (qty_available - @QuantityToSell)
         where productid = @ProductId
 
         Declare @MaxProductSalesId int

          Select @MaxProductSalesId = 
            Case 
              When MAX(s_productid) IS NULL Then 0 
              else MAX(s_productid) 
            end 
           from sale
           --Set @MaxProductSalesId = @MaxProductSalesId + 1

           Insert into sale values(@MaxProductSalesId, @ProductId, @QuantityToSell)
      Commit Transaction
    End Try
   Begin Catch 
      Rollback Transaction
        Select 
         ERROR_NUMBER() as ErrorNumber,
         ERROR_MESSAGE() as ErrorMessage,
         ERROR_PROCEDURE() as ErrorProcedure,
         ERROR_STATE() as ErrorState,
         ERROR_SEVERITY() as ErrorSeverity,
         ERROR_LINE() as ErrorLine
   End Catch 
  End
End

spSellProduct 1,5

----------------Triggers------------------------


ALTER TABLE Employee ADD gross int;

SELECT * From Employee;

CREATE TRIGGER tr_EMployee_Insert
ON employee
FOR INSERT
AS
BEGIN
Declare @Id int
Select @Id = Employee_Id from inserted

 update employee set gross= pf+PF_2 WHERE Employee_Id = @Id ;

END


Insert into Employee 
 (First_Name, Last_Name, Sex, Active_Status, designation, Salary, age, Dateofjoining, designation_id, pf, gross) 
 values ('Varun','Gupta','M',1,'student',77000,19,'2000-07-29',373,9432.5,18865)