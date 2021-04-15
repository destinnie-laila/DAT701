CREATE VIEW

vProfitPerYear

AS

SELECT
  salesYear,
  salesMonth,
  countryName AS Country,
  segmentName AS Segment,
  profit
FROM DimRegion AS Region
JOIN FACT_SalesProfit factsales
  ON Region.regionID = factsales.regionID
JOIN DimDate dates
  ON factsales.dateID = dates.dateID

GROUP BY salesYear,
         salesMonth,
         countryName,
         segmentName,
         profit

GO

SELECT * FROM vProfitPerYear

