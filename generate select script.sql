-- Columns list with types
set nocount on
go

declare
  @schema varchar(250) = 'dbo',
  @table varchar(250),
  @columns varchar(max), 
  @select_columns varchar(max), 
  @query varchar(max)

set @columns = 'CustomerID,PersonID,StoreID'
set @schema = 'Sales'
set @table = 'Customer'
set @select_columns = ''

select  
  @select_columns = @select_columns + '	,' + lower(c.name) + ' as ' + lower(c.name) + ' --'
    + 'type: ' + lower(isnull(st.name, ut.name)) + '(' + cast(c.max_length as varchar(20)) + ', p:' + cast(c.[precision] as varchar(20)) + ', s:' + cast(c.[scale] as varchar(20)) + '); '
    + case when c.is_nullable = 1 then 'null' else 'not null' end + '; '
    + 'default: ' + isnull(dc.[definition], 'not set') + '
'
from sys.columns as c
inner join string_split(@columns, ',') as cl on c.[name] = cl.[value]
inner join sys.tables t on t.[object_id] = c.[object_id]
left join sys.types st on st.system_type_id = c.system_type_id
    and st.is_user_defined = 0
left join sys.types ut on ut.user_type_id = c.user_type_id
    and st.is_user_defined = 1
left join sys.default_constraints dc on dc.[object_id] = c.default_object_id
left join sys.computed_columns cc on cc.[column_id] = c.[column_id]
    and cc.[object_id] = c.[object_id]
where 1 = 1
  and schema_name(t.schema_id) = @schema
  and t.name = @table
order by c.column_id


set @query = replace('select ' + stuff(@select_columns, 1, 1, '') + 'from dbo.' + @table, 'select ,', 'select ')

print @query
select @query

set nocount off
go

/*
select * from sys.tables
select object_name(9)
select schema_name(9)
*/
