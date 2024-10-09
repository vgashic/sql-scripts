if object_id('tempdb..#frag_before') is not null drop table #frag_before
go

if object_id('tempdb..#frag_after') is not null drop table #frag_after
go



-- fragmentation before script
select
	o.name,
	max(s.avg_fragmentation_in_percent) as avg_frag,
	max(s.page_count) as max_page_count
into #frag_before
from sys.dm_db_index_physical_stats(db_id(), object_id(null), null, null, null) s
inner join sys.objects o on o.object_id = s.object_id
where 1 = 1
	and schema_name(schema_id) = 'dbo'
group by o.name
having max(s.avg_fragmentation_in_percent) > 5
order by o.name

/*
if we need to start the script at specific time
waitfor time '14:05'
*/

exec sp_msforeachtable @command1 = "print '?' dbcc dbreindex('?', ' ', 80)"
go
exec sp_updatestats
go


-- fragmentation after script
select
	o.name,
	max(s.avg_fragmentation_in_percent) as avg_frag,
	max(s.page_count) as max_page_count
into #frag_after
from sys.dm_db_index_physical_stats(db_id(), object_id(null), null, null, null) s
inner join sys.objects o on o.object_id = s.object_id
where 1 = 1
	and schema_name(schema_id) = 'dbo'
group by o.name
order by o.name




-- summary
select
	b.name as table_name,
	b.avg_frag as fragmentation_before,
	a.avg_frag as fragmentation_after,
	a.avg_frag - b.avg_frag as diff,
	a.max_page_count
from #frag_before b
inner join #frag_after a on b.name = a.name
--where a.avg_frag - b.avg_frag > 0



/*

select * from #frag_before

*/