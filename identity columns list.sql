select
	o.name as [owner],
	t.name as [tablename],
	i.name as [column]
from sys.schemas as o
inner join sys.tables as t on o.[schema_id] = t.[schema_id]
inner join sys.identity_columns as i on i.[object_id] = t.[object_id]
order by 1,2,3
