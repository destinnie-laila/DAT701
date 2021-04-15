
--- ETL staff

INSERT INTO FinanceDW.dbo.DimStaff (
staffID,
firstName,
lastName)

SELECT
SalesPersonID,
FirstName,
LastName

FROM

FinanceDB.dbo.SalesPerson;

----- ETL Region

INSERT INTO FinanceDW.dbo.DimRegion( regionID, segmentName, countryName)

SELECT 

RegionID,
SegmentName,
CountryName

FROM

FinanceDB.dbo.Region Region

JOIN

FinanceDB.dbo.Segment Segment ON Region.SegmentID = Segment.SegmentID

JOIN 

FinanceDB.dbo.Country Country ON Region.CountryID = Country.CountryID;

----- ETL Date
go

Create Procedure addDate 

AS

BEGIN

DECLARE @StartDate DATE = '2002-01-01';
DECLARE @EndDate DATE = '2016-12-31';

WHILE (@StartDate <= @EndDate)


BEGIN


 print @StartDate;


--- Do Something like call a proc with the variable @StartDate

INSERT INTO DimDate(salesMonth, salesYear)
values (Month(@StartDate),Year(@StartDate));

set @StartDate = DATEADD(month, 1, @StartDate);


 END;

END;

go

execute addDate;

select * FROM DimDate;



---ETL FactSalesKPI
INSERT INTO FinanceDW.dbo.FACT_SalesKPI( regionID, staffID, dateID, performance, KPI)

select RegionID,  staffID, Dates.dateID, MonthlyPerformance, KPI

FROM vMonthbyMonth AS Months

JOIN

FinanceDW.dbo.DimDate as Dates ON 
(Months.Month = Dates.salesMonth AND
Months.Year = Dates.salesYear
)
go



-- ETL FactSalesProfit 
INSERT INTO FinanceDW.dbo.FACT_SalesProfit( profit, regionID , dateID)

select profit,  regionID, Dates.dateID

FROM vSalesProfitYear AS Profits

JOIN

FinanceDW.dbo.DimDate as Dates ON 
(Profits.Month = Dates.salesMonth AND
Profits.Year = Dates.salesYear
)
go







