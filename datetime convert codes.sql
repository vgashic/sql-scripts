-- SQL Server 2012+
-- Codes for CONVERT function

select
  n.n,
  try_convert(varchar(100), getdate(), n) as date_format
from (
	select top 200
    row_number() over (order by name) as n
	from sys.objects
  ) as n
where try_convert(varchar(100), getdate(), n) is not null
