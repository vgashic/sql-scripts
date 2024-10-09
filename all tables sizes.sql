if object_id('tempdb..#temptable') is not null drop table #temptable
go

declare
	@table_name varchar(100),
	@table_schema varchar(100),
	@table_full_name varchar(200)

--cursor to get the name of all user tables from the sysobjects listing
declare table_cursor cursor for 
	select
		table_schema,
		table_name
	from information_schema.tables 
	where 1 = 1
		and table_type = 'base table'
		--and table_name like 'arh[_]%'
for read only

--a procedure level temp table to store the results
create table #temptable
(
    table_name varchar(100),
    number_of_rows varchar(100),
    reserved_size varchar(50),
    data_size varchar(50),
    index_size varchar(50),
    unused_size varchar(50)
)

--open the cursor
open table_cursor

--get the first table name from the cursor
fetch next from table_cursor into @table_schema, @table_name

--loop until the cursor was not able to fetch
while (@@fetch_status >= 0)
begin
	set @table_full_name = '[' + @table_schema + ']' + '.' + '[' + @table_name + ']'

	print @table_full_name
    --dump the results of the sp_spaceused query to the temp table
    insert  #temptable
        exec sp_spaceused @table_full_name

    --get the next table name
    fetch next from table_cursor into @table_schema, @table_name
end

--get rid of the cursor
close table_cursor
deallocate table_cursor


--select all records so we can use the reults
select
	table_name as table_name,
	number_of_rows as number_of_rows,
	cast(cast(replace(reserved_size, ' kb', '') as decimal(18,2)) / 1024 as varchar(100)) + ' mb' as reserved_size,
	cast(cast(replace(data_size, ' kb', '') as decimal(18,2)) / 1024 as varchar(100)) + ' mb' as data_size,
	index_size as index_size,
	cast(cast(replace(unused_size, ' kb', '') as decimal(18,2)) / 1024 as varchar(100)) + ' mb' as unused_size
from #temptable
where 1 = 1
	and number_of_rows != 0
order by cast(number_of_rows as int) desc
--order by cast(replace(data_size, ' kb', '') as int) desc

--final cleanup!
--drop table #temptable