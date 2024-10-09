select
	k_table = fk.table_name,
	fk_column = cu.column_name,
	pk_table = pk.table_name,
	pk_column = pt.column_name,
	constraint_name = c.constraint_name
from information_schema.referential_constraints as c
inner join information_schema.table_constraints as fk on c.constraint_name = fk.constraint_name
inner join information_schema.table_constraints as pk on c.unique_constraint_name = pk.constraint_name
inner join information_schema.key_column_usage as cu on c.constraint_name = cu.constraint_name
inner join (
		select
			i1.table_name,
			i2.column_name
		from information_schema.table_constraints as i1
		inner join information_schema.key_column_usage as i2 on i1.constraint_name = i2.constraint_name
		where i1.constraint_type = 'primary key'
		) pt on pt.table_name = pk.table_name
where 1 = 1
	and pk.table_schema = 'Sales'
	and pk.table_name = 'Currency'


--select * from information_schema.table_constraints
