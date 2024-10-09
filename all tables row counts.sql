select
	substring(obj.name, 1, 50) as table_name,
	ind.rows as number_of_rows,
	'select * from '+ lower(obj.name) + '  --' + cast(ind.rows as varchar(20)) + ' rows' as select_query
from sysobjects as obj
inner join sysindexes as ind on obj.id = ind.id
where 1 = 1
	and obj.xtype = 'u'
	and ind.indid < 2
	and ind.rows > 0
order by obj.name
