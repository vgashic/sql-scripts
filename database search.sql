/*
06.03.2024 VladimirG; created

@search_pattern - Tekst koji se trazi.
  Dodati % na pocetak i kraj jer se za pretragu koristi like

#ignore - Ovde dodati tabele i kolone koje ne treba pretrazivati.
  Format je tabla.kolona
  Mogu se koristiti wildcard karakteri (%, [], _)
  Underscore pisati kao [_] (jer je samo _ wildcard koji menja bilo koji karakter)
*/

if object_id('tempdb..#results') is not null drop table #results
if object_id('tempdb..#columns') is not null drop table #columns
if object_id('tempdb..#ignore') is not null drop table #ignore
go

declare
  @search_pattern nvarchar(max) = '%http:%',
  @message varchar(1000)

create table #results (
  table_name varchar(1000) not null,
  column_name varchar(1000) not null,
  match_count int not null default(0),
  sql_query varchar(max) not null
)

select
  ignore_pattern
into #ignore
from (
  values
    ('arh[_]%'),
    ('executing_tasks_results.%'),
    ('gv[_]%'),
    ('[_]%'),
    ('queue_archive.%'),
    ('cube[_]%'),
    ('bisnode[_]%'),
    ('aktivirane.%'),
    ('ba[_]%'),
    ('gams[_]%'),
    ('lsk.%'),
    ('hdm%'),
    ('hr[_]%'),
    ('kredbiro[_]%'),
    ('mail_attachment.attachment'),
    ('reports.%'),
    ('reports_b2.%'),
    ('queue_archive.%'),
    ('db_access_log.%'),
    ('mail_register.xml_data'),
    ('oc[_]%'),
    ('reprogram.%'),
    ('Sheet%')
  ) as t(ignore_pattern)

select
  c.table_name,
  c.column_name,
  c.data_type,
  ltrim(rtrim(c.table_name)) + '.' + ltrim(rtrim(c.column_name)) as full_name,
  '[' + ltrim(rtrim(c.table_name)) + '].[' + ltrim(rtrim(c.column_name)) + ']' as full_name2,
  cast(null as nvarchar(max)) as sql_query
into #columns
from information_schema.columns as c
where 1 = 1
  and c.data_type in ('char', 'nchar', 'nvarchar', 'varchar', 'text', 'xml')
order by table_name, column_name

update c set
  sql_query = 'select @var = count(0) from [' + c.table_name + '] where [' + c.column_name + '] like ''' + @search_pattern + ''''
from #columns as c
where 1 = 1
  and c.data_type != 'xml'
  and c.sql_query is null

update c set
  sql_query = 'select @var = count(0) from [' + c.table_name + '] where cast([' + c.column_name + '] as varchar(max)) like ''' + @search_pattern + ''''
from #columns as c
where 1 = 1
  and c.data_type = 'xml'
  and sql_query is null



delete c
--select *
from #columns as c
left join #ignore as i on c.full_name like i.ignore_pattern
where 1 = 1
  and i.ignore_pattern is not null

--select * from #columns order by 1


declare
  @table_name varchar(1000),
  @column_name varchar(1000),
  @sql_query nvarchar(max)

declare cur_search cursor for
select
  table_name,
  column_name,
  sql_query
from #columns
order by table_name, column_name

open cur_search

fetch next from cur_search into @table_name, @column_name, @sql_query

while @@fetch_status = 0
begin

  declare @cnt int = 0

  set @message = @table_name + '.' + @column_name
  raiserror(@message, 0, 1) with nowait
  exec sp_executesql @sql_query, N'@var int output', @var = @cnt output


  if (@cnt > 0)
    insert into #results values (@table_name, @column_name, @cnt, @sql_query)

  fetch next from cur_search into @table_name, @column_name, @sql_query
end

close cur_search
deallocate cur_search


select * from #results

/*
select distinct data_type from information_schema.columns order by 1
select * from #columns
select distinct table_name from #columns order by 1
select * from vrst_opr


declare @cnt int
exec sp_executesql N'select @var = count(0) from VRST_OPR where naziv like ''%oprem%''', N'@var int output', @var = @cnt output
select @cnt

*/
