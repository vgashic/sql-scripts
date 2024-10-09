declare @search nvarchar(max)

set @search = 'NeverSkipHolidays'

select
	o.name
	,m.[definition]
	,substring(m.[definition], charindex(@search, m.[definition]) - 50, charindex(@search, m.[definition]) + 50)
from sys.sql_modules as m
inner join sys.objects as o on o.[object_id] = m.[object_id]
where 1 = 1
	and m.[definition] like '%' + @search + '%'
	--and o.name like '%sync%'
order by o.name
