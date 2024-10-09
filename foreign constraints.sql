-- all constraints that references table

select
	o.name as fk_name,
	fk.name as fk_in_table,
	col.column_name as fk_column_name,
	rk.name as ref_table
from sysforeignkeys as f
inner join sysobjects as o on o.id = f.constid
inner join sysobjects as fk on f.fkeyid = fk.id
inner join sysobjects as rk on f.rkeyid = rk.id
inner join information_schema.columns as col on fk.name = col.table_name
		and f.fkey = col.ordinal_position
where 1 = 1
	and rk.name = 'partner'
order by fk.name
