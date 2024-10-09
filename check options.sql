declare @options int
select @options = @@options

print @options
if ( (1 & @options) = 1 ) print 'disable_def_cnst_chk' 
if ( (2 & @options) = 2 ) print 'implicit_transactions' 
if ( (4 & @options) = 4 ) print 'cursor_close_on_commit' 
if ( (8 & @options) = 8 ) print 'ansi_warnings' 
if ( (16 & @options) = 16 ) print 'ansi_padding' 
if ( (32 & @options) = 32 ) print 'ansi_nulls' 
if ( (64 & @options) = 64 ) print 'arithabort' 
if ( (128 & @options) = 128 ) print 'arithignore'
if ( (256 & @options) = 256 ) print 'quoted_identifier' 
if ( (512 & @options) = 512 ) print 'nocount' 
if ( (1024 & @options) = 1024 ) print 'ansi_null_dflt_on' 
if ( (2048 & @options) = 2048 ) print 'ansi_null_dflt_off' 
if ( (4096 & @options) = 4096 ) print 'concat_null_yields_null' 
if ( (8192 & @options) = 8192 ) print 'numeric_roundabort' 
if ( (16384 & @options) = 16384 ) print 'xact_abort'
