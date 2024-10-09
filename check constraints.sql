select
	cc.name as constraint_name,
	o.name as table_name,
	cc.[definition] as constraint_definition
from sys.check_constraints as cc
inner join sys.objects as o on o.[object_id] = cc.parent_object_id
where 1 = 1
	and o.name like '%pog%'
