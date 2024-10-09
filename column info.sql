select
	t.name as table_name,
	c.name as column_name,
	upper(isnull(st.name, ut.name)) as [type],
	c.max_length as max_length,
	c.[precision] as [precision],
	c.[scale] as [scale],
	case when c.is_nullable = 1 then 'null' else 'not null' end as nullable,
	case when c.is_identity = 1 then 'yes' else 'no' end as identity_column,
	case when c.is_computed = 1 then cc.[definition] else 'no' end as computed_column,
	isnull(dc.[definition], 'not set') as default_value,
	c.column_id as column_id
from sys.columns as c
inner join sys.tables as t on t.[object_id] = c.[object_id]
left join sys.types as st on st.system_type_id = c.system_type_id
		and st.is_user_defined = 0
		and st.system_type_id = st.user_type_id
left join sys.types as ut on ut.user_type_id = c.user_type_id
		and st.is_user_defined = 1
		and st.system_type_id <> st.user_type_id
left join sys.default_constraints as dc on dc.[object_id] = c.default_object_id
left join sys.computed_columns as cc on cc.[column_id] = c.[column_id]
		and cc.[object_id] = c.[object_id]
where 1 = 1
	--and c.name like '%xml%'
	--or c.name like '%dav_stev%'
	--and isnull(st.name, ut.name) = 'char'
	--and t.name not like 'arh[_]%'
	--and t.name not like '[_]%'
	--and c.is_nullable = 1
	--and lower(t.name) like '%report%'
  and isnull(st.name, ut.name) = 'nvarchar'
order by table_name--, columnname
