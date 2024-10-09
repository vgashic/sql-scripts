/*
20.03.2023 VladimirG; reseed tables if needed
*/

declare
  @column_name varchar(1000),
  @table_name varchar(1000),
  @cmd nvarchar(4000)

declare ident_fix cursor for
	select
    ic.name,
    object_name(ic.object_id) as table_name
  from sys.identity_columns as ic
  inner join sys.objects as ot on ic.object_id = ot.object_id
  where 1 = 1
    and ot.type_desc = 'USER_TABLE'

open ident_fix

fetch next from ident_fix into @column_name, @table_name

while @@fetch_status = 0
begin
	
	set @cmd = '-- setting identity for table ' + @table_name + '
declare @max_id int = isnull((select max(' + @column_name + ') from dbo.' + @table_name + '), 0)
dbcc checkident(' + @table_name + ', reseed, @max_id)

'
  
  print @cmd
  exec (@cmd)

	fetch next from ident_fix into @column_name, @table_name
end

close ident_fix
deallocate ident_fix

