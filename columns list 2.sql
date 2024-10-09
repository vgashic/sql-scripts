select string_agg(column_name, ', ')
from information_schema.columns
where 1 = 1
  and table_name = 'io_channels'
go

/*
select * from information_schema.columns
*/
