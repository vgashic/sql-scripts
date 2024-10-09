declare
  @id int

set @id = isnull((select max(id_gl_napoved) from dbo.gl_napoved), 0)

dbcc checkident('gl_napoved', reseed, @id)
go


declare
  @id int

set @id = isnull((select max(id_porocila) from dbo.porocila), 0)

dbcc checkident('porocila', reseed, @id)
go