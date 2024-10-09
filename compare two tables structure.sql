select
  rc.table_name,
  rc.column_name,
  rc.data_type as local_data_type,
  rc.character_maximum_length as local_length,
  rc.is_nullable as local_nullable,
  pc.data_type as podrska_data_type,
  pc.character_maximum_length as podrska_length,
  pc.is_nullable as podrska_nullable
from information_schema.columns as rc
left join podrska.nova_support.information_schema.columns as pc on rc.table_name = pc.table_name and rc.column_name = pc.column_name
where 1 = 1
  and rc.table_name like 'cube[_]%'
  and (rc.data_type != pc.data_type
      or isnull(rc.character_maximum_length, '') != isnull(pc.character_maximum_length, '')
      or rc.is_nullable != pc.is_nullable
      )


/*
select * from podrska.nova_support.information_schema.columns
*/
