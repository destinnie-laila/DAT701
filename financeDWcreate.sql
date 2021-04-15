Drop Database if exists FinanceDW;

Create Database FinanceDW;
go

use FinanceDW;
go

---- Dimension Tables

Create Table DimStaff (
staffID int Primary KEY,
firstName varchar (100),
lastName varchar (100)
);

Create Table DimDate (
dateID int Identity Primary Key,
salesYear int,
salesMonth int
);

Create Table DimRegion (
regionID int Primary Key,
segmentName varchar (100),
countryName varchar (100)
);
use FinanceDW
go
---- Fact Tables

Create Table FACT_SalesKPI (
fsKPI_ID int identity Primary key,
KPI float,
performance float,
regionID int,
dateID int,
staffID int,

FOREIGN KEY (regionID) REFERENCES DimRegion (regionID),
FOREIGN KEY (dateID) REFERENCES DimDate (dateID),
FOREIGN KEY (staffID) REFERENCES DimStaff (staffID)

);

SELECT * FROM FACT_SalesKPI



Create Table FACT_SalesProfit (
fspID int identity primary key,
profit float,
regionID int,
dateID int,

FOREIGN KEY (regionID) REFERENCES DimRegion (regionID),
FOREIGN KEY (dateID) REFERENCES DimDate (dateID)

);



