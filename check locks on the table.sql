/*
09.07.2024 VladimirG; created

Check locks on database object
*/

select
  *
from sys.dm_tran_locks as l
inner join sys.objects o on l.resource_associated_entity_id = o.object_id
where 1 = 1
  and l.resource_database_id = db_id()
  and o.schema_id = schema_id('dbo')
  and o.object_id = object_id('contract')
go

/*
select * from sys.objects order by object_id
*/
