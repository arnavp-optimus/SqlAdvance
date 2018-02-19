---------1-----------

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


------2------------------

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



------3---------


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


 SELECT Train_Name  ,
(SELECT SUM(Distance) FROM Journey_Details WHERE  Train_Id = Train_Details.Train_Id ) 
AS Distance
FROM Train_Details 
ORDER BY Train_Name




--select    (Departure - Schedule_Arrival) from Journey_Details



-------------Question2--------------------


--(A)


SELECT TOP 1 Train_Name, SUM(Journey_Details.Distance) from Train_Details 
Left join Journey_Details on Train_Details.Train_Id = Journey_Details.Train_Id 
Group by(Train_Name) 
ORDER BY Train_Name DESC;

--(C)

SELECT Train_Id from Journey_Details group by(Train_Id) having count(Train_Id) > 2  ;


--(D)

SELECT DISTINCT Train_Details.Train_Name FROM Train_Details
INNER JOIN Journey_Details ON Train_Details.Train_Id=Journey_Details.Train_Id
WHERE Train_Details.Train_Id NOT IN(102-103);


-------------Question3--------------------


SELECT DISTINCT J.Train_Id , T.Train_Name  
 FROM Journey_Details J INNER JOIN Train_Details T
ON J.Train_Id = T.Train_Id


SELECT DISTINCT J.Station_Id , J.Train_Id ,S.Station_Name AS Boarding
FROM JOURNEY_DETAILS J INNER JOIN STATION_DETAILS S
ON J.Station_Id = S.Station_Id
 WHERE J.Schedule_Arrival IS NULL

 
SELECT DISTINCT J.Station_Id , J.Train_Id ,S.Station_Name AS Destination
FROM Journey_Details J INNER JOIN Station_Details S
ON J.Station_Id = S.Station_Id
 WHERE J.Departure IS NULL








-------------SECTION B --------------------------------

---------------------------1--------------------------------
CREATE TABLE Department
(
Dept_id int PRIMARY KEY NOT null,
Dept_name varchar(20),
Num_of_Projects int not null CHECK (Num_of_Projects>2)
);



CREATE TABLE Project(
Project_id int PRIMARY KEY not null,
Project_name varchar(50) not null,
Project_Dept varchar(20),
Num_of_Eng int not null CHECK (Num_of_Eng>1),
Num_of_hours int 
)

CREATE TABLE Engineer(
Eng_id int PRIMARY KEY not null,
Eng_name varchar(30),
Eng_proj_id int,
Num_of_hrs int 
)

SELECT * FROM Department;
SELECT * FROM Project;
SELECT * FROM Engineer;

Insert into Department values(101, 'Manager', 3);

Insert into Department values(102, 'Developer', 4);

Insert into Department values(103, 'Trainee', 3);
-------------------------------------------------------------------------

Insert into Project values(1, 'Logo', 'Entertainment', 2, 76);

Insert into Project values(2, 'Enigma', 'Utility', 3, 90);

Insert into Project values(3, 'Captum', 'Official', 4, 82);

-------------------------------------------------------------------------

Insert into Engineer values(301, 'Paul', 1, 76);

Insert into Engineer values(302, 'Niel', 2, 90);

Insert into Engineer values(303, 'John', 3, 82);

---------------------------------------------------------------------------


---------2(a)--------------------------------------------------------------


SELECT Eng_name ,SUM(Num_of_hrs)  
FROM Engineer GROUP BY  Eng_name





