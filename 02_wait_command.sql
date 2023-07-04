-- ********* WAIT COMMAND *********
do $$
declare 
	create_at time := now();
begin
	raise notice '%', create_at;
	perform pg_sleep(5); -- wait 5 seconds
	raise notice '%', create_at;
end $$;