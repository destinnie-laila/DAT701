CREATE VIEW

vStaffYearlyKPI

AS

SELECT
  countryName AS Country,
  segmentName AS Segment,
  KPI,
  firstName + ' ' + lastName as Staff,
  salesYear

FROM DimRegion AS Region
JOIN FACT_SalesKPI salesKPI
  ON Region.regionID = salesKPI.regionID
JOIN DimDate dates
  ON salesKPI.dateID = dates.dateID
JOIN DimStaff staff
  ON salesKPI.staffID = staff.staffID

GROUP BY    
         countryName,
         segmentName,
         firstName,
		 lastName,
		 KPI,
		 salesYear

GO

SELECT * FROM vStaffYearlyKPI
WHERE salesYear >= '2016'
