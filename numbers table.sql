if not exists (select * from information_schema.tables where table_name = 'numbers' and table_schema = 'dbo')
	select top 100000
		identity(int,1,1) as num
	into dbo.numbers
	from sys.objects a, sys.objects b, sys.objects c
go

--drop table numbers
--select * from numbers