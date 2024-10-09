declare @encrypt varbinary(200)
select @encrypt = EncryptByPassPhrase('3656555', '{"id":"1234","place":"office"}' )
select @encrypt

select convert(varchar(100),DecryptByPassPhrase('3656555', @encrypt ))