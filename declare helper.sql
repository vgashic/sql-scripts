if object_id('tempdb..#columns') is not null drop table #columns
go


select
	cast('@{column_name} {type}{size}, ' as varchar(2000)) as declare_variable,
	c.column_name,
	c.data_type,
	c.character_maximum_length,
	c.numeric_precision,
	c.numeric_scale
into #columns
from information_schema.columns as c
where 1 = 1
	and c.table_name = 'pogodba'
go

update #columns set
	declare_variable = replace(declare_variable, '{column_name}', column_name)
go

update #columns set
	declare_variable = replace(declare_variable, '{type}', data_type)
go

update #columns set
	declare_variable = replace(declare_variable, '{size}', '')
where data_type in (
	'bigint',
	'bit',
	'datetime',
	'float',
	'image',
	'int',
	'money',
	'ntext',
	'numeric',
	'smalldatetime',
	'smallint',
	'text',
	'timestamp',
	'tinyint',
	'uniqueidentifier',
	'varbinary'
	)
go


update #columns set
	declare_variable = replace(declare_variable, '{size}', '(' + cast(character_maximum_length as varchar(20)) + ')')
where data_type in (
	'char',
	'nchar',
	'nvarchar',
	'varchar'
	)
go


update #columns set
	declare_variable = replace(declare_variable, '(-1)', '(max)')
where data_type in (
	'char',
	'nchar',
	'nvarchar',
	'varchar'
	)
	and character_maximum_length = -1
go


update #columns set
	declare_variable = replace(declare_variable, '{size}', '(' + cast(numeric_precision as varchar(10)) + ',' + cast(numeric_scale as varchar(10)) + ')')
where data_type in (
	'decimal'
	)
go

select * from #columns



/*
select *
from information_schema.columns as c
where 1 = 1
	and c.table_name = 'pogodba'

select distinct data_type from information_schema.columns as c

*/

