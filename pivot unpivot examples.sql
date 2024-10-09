/*
Examples using database AdventureWorks2022
*/


-- #region unpivot

select
	unp.ProductID,
	unp.QtyName,
	unp.QtyValue
from (
	select
		ProductID,
		OrderQty,
		StockedQty,
		cast(ScrappedQty as int) as ScrappedQty
	from Production.WorkOrder
) wo
unpivot (
	QtyValue for QtyName in
		(OrderQty, StockedQty, ScrappedQty) -- all columns must have same type
) unp

--select * from Production.WorkOrder

-- #endregion unpivot


--#region pivot

select
	'SalesYTD' as Description,
	US,
	CA,
	FR,
	DE,
	AU,
	GB
from (
	select
		CountryRegionCode,
		sum(SalesYTD) as SalesYTD
	from Sales.SalesTerritory
	group by CountryRegionCode
) s
pivot (
	sum(SalesYTD) for CountryRegionCode in
		(US, CA, FR, DE, AU, GB)
) pvt

--select * from Sales.SalesTerritory

--#endregion pivot


