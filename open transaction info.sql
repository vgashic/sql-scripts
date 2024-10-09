if object_id('tempdb..#open_transactions') is not null begin drop table #open_transactions end
go

create table #open_transactions (
   active_transaction varchar(25),
   details sql_variant)

-- execute the command, putting the results in the table.
insert into #open_transactions 
   exec ('dbcc opentran with tableresults, no_infomsgs');

-- display the results.
select * from #open_transactions;
go

exec sp_who2
go
