---------1.CREATING TABLE Train_Details-----------

CREATE TABLE Train_Details
(
Train_Id int,
Train_Name varchar(50)
);

INSERT INTO Train_Details VALUES (11404,'Shatabdi');

INSERT INTO Train_Details VALUES (22505,'Rajdhani');

INSERT INTO Train_Details VALUES (33606,'Passenger');

SELECT * FROM Train_Details;

alter table Train_Details alter column Train_Id int NOT NULL;
alter table  Train_Details add constraint df_p PRIMARY KEY (Train_Id);


-----------2.CREATING TABLE Station_Details ------------------

CREATE TABLE Station_Details
(
Station_Id int,
Station_Name varchar(50)
);

INSERT INTO Station_Details VALUES (101,'Delhi');

INSERT INTO Station_Details VALUES (102,'Aligarh');

INSERT INTO Station_Details VALUES (103,'Lucknow');

INSERT INTO Station_Details VALUES (104,'Kanpur');

SELECT * FROM Station_Details;

alter table Station_Details alter column Station_Id int NOT NULL;
alter table Station_Details  add constraint def_p PRIMARY KEY (Station_Id);



-----------------------3. CREATING TABLE Journey_Details--------------------------------


CREATE TABLE Journey_Details
(
Train_Id int,
Station_Id int,
Distance varchar(50),
Schedule_Arrival datetime,
Departure datetime
);

ALTER TABLE Journey_Details
ALTER COLUMN Distance int;

INSERT INTO Journey_Details VALUES (11404, 101, 0, NULL, '2012/01/25 03:00:00');

INSERT INTO Journey_Details VALUES (11404, 103, 750, '2012/1/25 09:30:00', NULL);

INSERT INTO Journey_Details VALUES (22505, 101, 0, NULL, '2012/1/25 15:04:00');

INSERT INTO Journey_Details VALUES (22505, 102, 225, '2012/1/25 5:30:00', '2012/1/25 06:00:00');

INSERT INTO Journey_Details VALUES (22505, 104, 150, '2012/01/25  07:10:00', '2012/01/25 07:50:00');

INSERT INTO Journey_Details VALUES (22505, 103, 100, '2012/01/25 08:30:00', NULL);

INSERT INTO Journey_Details VALUES (33606, 102, 0, NULL, '2012/01/25 10:45:00');

INSERT INTO Journey_Details VALUES (33606, 104, 150, '2012/01/25 13:20:00', '2012/01/25 13:45:00');

INSERT INTO Journey_Details VALUES (33606, 103, 100,  '2012/01/25 17:20:00', NULL);

SELECT Train_Id,Station_Id,Distance,        
  FORMAT(Schedule_Arrival, 'dd/MM/yyyy hh:mm:ss')AS Schedule_Arrival,
  FORMAT(Departure, 'dd/MM/yyyy hh:mm:ss')AS Departure
FROM Journey_Details


SELECT * FROM Journey_Details;


-----------------SECTION-A-------------------------


-----QUESTION-1-------

CREATE TABLE Initial_Point
 (
 Train_Name varchar(max),
 Station_Name varchar(max),
 )

 INSERT INTO Initial_Point
 
 SELECT Train_Details.Train_Name,Station_Details.Station_Name from Journey_Details join
 Station_Details on Station_Details.Station_Id=Journey_Details.Station_Id  
 join Train_Details on Train_Details.Train_Id=Journey_Details.Train_Id where Journey_Details.Distance=0

 SELECT * FROM Initial_Point

 ======================================================================================

  CREATE TABLE Intermediate
 (
 Train_Name varchar(max),
 Station_Name varchar(max),
 )

 INSERT INTO Intermediate

  SELECT Train_Details.train_name,Station_Details.station_name from Journey_Details join
 Station_Details on Station_Details.station_id=Journey_Details.station_id  join 
 Train_Details on Train_Details.train_Id=Journey_Details.train_id where
  convert(int,Schedule_Arrival)!=0 and convert(int,Departure)!=0 group by 
  Train_Details.train_name,Station_Details.station_name

  SELECT * from Intermediate

  ========================================================================================

   CREATE TABLE Final_Point
 (
 Train_Name varchar(MAX),
 Station_Name varchar(MAX),
 )

  INSERT INTO Final_Point

 SELECT Train_Details.train_name,Station_Details.station_name from Journey_Details join
 Station_Details on Station_Details.station_id=Journey_Details.station_id  join 
 Train_Details on Train_Details.train_Id=Journey_Details.train_id where  convert(varchar,Departure) is null

  SELECT * FROM Final_Point
  
  ==========================================================================================

--THIS TABLE WILL GIVE THE STATION NAME COLUMN--------

 CREATE TABLE ROUTING
 ( 
 Train_Name varchar(max),
 Station_Name varchar(max)
 )

 INSERT INTO ROUTING
SELECT DISTINCT Initial_Point.train_name as train_name,concat(Initial_Point.station_name,',',Intermediate.station_name,',',Final_Point.station_name) 
as stations from Initial_Point  
 left join Intermediate on Initial_Point.train_name=Intermediate.train_name
 left join Final_Point on Initial_Point.train_name=Final_Point.train_name 

 
  SELECT * FROM ROUTING

  ==============================================================================================

  -------THIS TABLE WILL GIVE THE DISTANCE COLUMN------

CREATE TABLE Distance
  ( 
  train_name varchar(50),
  distance int
 )

INSERT into Distance

  select Train_Details.train_name,sum(Journey_Details.distance )as distance from Journey_Details 
  join Train_Details on Journey_Details.train_id=Train_Details.train_Id group by Train_Details.train_name 


SELECT * from Distance

SELECT ROUTING.train_name,ROUTING.station_name,Distance.distance from ROUTING 
left join Distance on ROUTING.train_name=Distance.train_name

===================================================================================================


 -------------THIS IS THE FINAL TABLE---------------

CREATE TABLE Avg_Speed
(
Train_Name varchar(60),
Station_Name varchar(60),
Distance int,
avg_speed int
);
 
INSERT INTO Avg_Speed select B.train_name, B.station_name, B.distance,A.avg_speed from
(
select ROUTING.train_name,ROUTING.station_name,Distance.distance 
from ROUTING left join Distance on ROUTING.train_name=Distance.train_name
 ) B

 left join
(
select avg_speed = abs(Distance.distance/C.diff),C.train_name from Distance left join

(
select DATEDIFF(hh,T1.Departure,T2.Schedule_Arrival) as diff,T1.train_name from 
( select train_details.train_name,station_details.station_name,journey_details.Departure from journey_details join
 station_details on station_details.station_id=journey_details.station_id  join 
 train_details on train_details.train_id=journey_details.train_id where journey_details.distance=0) t1

 left join
(select train_details.train_name,station_details.station_name,journey_details.Schedule_Arrival from journey_details join
 station_details on station_details.station_id=journey_details.station_id  join train_details on train_details.train_Id=journey_details.train_id where  convert(varchar,Departure) is null) t2
  on
  t1.train_name =t2.train_name
  ) C
on Distance.train_name =C.train_name

) A
on B.train_name =A.train_name

SELECT * FROM Avg_Speed


-------------Question2--------------------

--(A)  Name of the train which covered the maximum distance during its journey. 


SELECT TOP 1 Train_Name, SUM(Journey_Details.Distance) from Train_Details 
Left join Journey_Details on Train_Details.Train_Id = Journey_Details.Train_Id 
Group by(Train_Name) 
ORDER BY Train_Name DESC;

--(B) Name of the train which has the max Average speed. 

Select Train_Name,avg_speed from Avg_Speed where avg_speed=(SELECT MAX(avg_speed) as max1 from Avg_Speed)

--(C)Name those trains which stop at least at three stations. 

select train_name from Journey_details left join Train_Details on Train_Details.Train_id=Journey_details.Train_Id 
group by(train_name) having count(Station_Id)>2  ;

--(D) Name those trains whose stoppage is not Aligarh and Kanpur. 

select Train_Name from Train_Details Except 
(select train_name from train_details TD inner join journey_details JD on TD.train_id=JD.train_id 
where station_id  IN (102, 104) group by train_name);

-------------Question3--------------------

CREATE Table temp
 (
 Train_Id int,
 Train_Name varchar(60)
 );

 Insert into temp SELECT DISTINCT J.Train_Id , T.Train_Name  
 FROM Journey_Details J INNER JOIN Train_Details T
ON J.Train_Id = T.Train_Id

select * from temp;


 CREATE TABLE temp1
 (
 S_Id int,
 T_Id int,
 Boarding varchar(50)
 );


 INSERT INTO temp1 SELECT DISTINCT J.Station_Id , J.Train_Id ,S.Station_Name AS Boarding
FROM JOURNEY_DETAILS J INNER JOIN STATION_DETAILS S
ON J.Station_Id = S.Station_Id
 WHERE J.Schedule_Arrival IS NULL;

 select * from temp1;

 SELECT temp.Train_Id, temp.Train_Name, temp1.S_Id, temp1.Boarding
FROM temp
INNER JOIN temp1 ON temp.Train_Id = temp1.T_Id;

 CREATE TABLE temp2
 (
 St_Id int,
 Tr_Id int,
 Destination varchar(50)
 );


 INSERT INTO temp2 SELECT DISTINCT J.Station_Id , J.Train_Id ,S.Station_Name AS Destination
FROM Journey_Details J INNER JOIN Station_Details S
ON J.Station_Id = S.Station_Id
 WHERE J.Departure IS NULL


 Create table temp3
 (
 Train_Id int,Train_Name varchar(60),S_Id int,Boarding varchar(60));


  Insert into temp3  SELECT temp.Train_Id, temp.Train_Name, temp1.S_Id, temp1.Boarding
FROM temp
INNER JOIN temp1 ON temp.Train_Id = temp1.T_Id;
 select * from temp2;
Select * from temp3;



SELECT temp3.Train_Id, temp3.Train_Name, temp3.Boarding, temp2.Destination
FROM temp2
INNER JOIN temp3 ON temp2.Tr_Id = temp3.Train_Id;

-------------SECTION B --------------------------------

---------------------------1--------------------------------


--------CREATING DEPARTMENT TABLE----------

CREATE TABLE Department
(
Dept_id int PRIMARY KEY NOT null,
Dept_name varchar(50),
Num_of_Projects int not null CHECK (Num_of_Projects>2)
);

--------CREATING Project TABLE----------


CREATE TABLE Project
(
Project_id int PRIMARY KEY not null,
Project_name varchar(50) not null,
Project_Dept varchar(50),
Num_of_Eng int not null CHECK (Num_of_Eng>1),
Num_of_hours int 
)

--------CREATING Engineer TABLE----------

CREATE TABLE Engineer
(
Eng_id int PRIMARY KEY not null,
Eng_name varchar(50),
Eng_proj_id int,
Num_of_hrs int 
)

-----------INSERTING VALUES IN Department----------------------

Insert into Department values(101, 'Manager', 3);

Insert into Department values(102, 'Developer', 4);

Insert into Department values(103, 'Trainee', 3);

-----------------------------INSERTING VALUES IN Project-----------------

Insert into Project values(1, 'Logo', 'Entertainment', 2, 76);

Insert into Project values(2, 'Enigma', 'Utility', 3, 90);

Insert into Project values(3, 'Captum', 'Official', 4, 82);

----------------------------INSERTING VALUES IN Engineer ---------------------------------------------

Insert into Engineer values(301, 'Paul', 1, 76);

Insert into Engineer values(302, 'Niel', 2, 90);

Insert into Engineer values(303, 'John', 3, 82);

---------------------------------------------------------------------------
SELECT * FROM Department;
SELECT * FROM Project;
SELECT * FROM Engineer;

---------2(A)number of hours spent as Each engineer in their respective project. --------------------------------------------------------------

SELECT Engineer.Eng_name,Project.Project_name,Engineer.Num_of_hrs from Engineer 
INNER JOIN 
Project on Engineer.Eng_proj_id = Project.Project_id ; 

---------2(B)number of hours spent as Each project in their respective department. --------------------------------------------------------------

SELECT Project.Project_name,Project.Num_of_hours,Project.Project_Dept from Project ;
