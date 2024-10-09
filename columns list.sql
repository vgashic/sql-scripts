select lower(cast(
  (
    select column_name + ', '
    from information_schema.columns
    where 1 = 1
      and table_name = 'SalesTaxRate'
    order by ordinal_position
    for xml path('')
  ) as nvarchar(max)))


go
