/*
12.07.2024 VladimirG; created

Locate columns that causes `String or binary data would be truncated` error.
The script checks if the longest text in the table columns is longer than maximum allowed.
Results are inserted in the temporary table ##trunc_check
Names of columns in the temporary table must be same as names in the target table
*/

if object_id('tempdb..##trunc_check') is not null drop table ##trunc_check
go

if object_id('tempdb..#col') is not null drop table #col
go

create table #col
  (
    col_name varchar(1000) null,
    sys_type varchar(1000) null,
    col_len int null
  )
go


-- #region query to check

-- don't forget to add `into ##trunc_check`
select
  c.CurrencyCode,
  c.Name,
  c.ModifiedDate
into ##trunc_check
from (
  values
    ('jeOzXQ', 'currency jeOzXQ', getdate()),
    ('9SHq0F', 'currency 9SHq0F', getdate()),
    ('bMigMw', 'currency bMigMw', getdate()),
    ('p7ak8uQDfe', 'currency p7ak8u', getdate()),
    ('DMaQ3r', 'currency DMaQ3r', getdate()),
    ('Wr41KW', 'currency Wr41KW', getdate())
) c(CurrencyCode, [Name], ModifiedDate)
go

-- #endregion

declare
  @columns varchar(max),
  @query varchar(max),

  -- schema and table name
  @schema_name varchar(1000) = 'Sales',
  @table_name varchar(1000) = 'Currency'


set @columns = (
  select
    'select ''' + t.[name] + ''' as col_name, ''' + type_name(system_type_id) + ''' as sys_type, max(len(' + t.[name] + ')) as col_len from ##trunc_check union all '
  from tempdb.sys.columns as t
  where 1 = 1
    and t.object_id = object_id('tempdb..##trunc_check')
  for xml path('')
)

set @columns = left(@columns, len(@columns) - 10)

set @query = @columns

insert into #col
  (col_name, sys_type, col_len)
exec sp_sqlexec @query


-- final select
select
  c.*,
  i.character_maximum_length
from #col as c
inner join information_schema.columns as i on c.col_name = i.column_name
    and i.table_name = @table_name and i.table_schema = @schema_name
where 1 = 1
  and i.character_maximum_length is not null
  and c.col_len > i.character_maximum_length

/*
select type_name(system_type_id), * from sys.columns
select * from information_schema.columns where table_name = 'Currency'
select * from Sales.Currency
*/
