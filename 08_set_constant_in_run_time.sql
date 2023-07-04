-- ******** SET CONSTANT in RUN TIME ***********
do $$
declare
	start_at constant time := now();
begin
	raise notice 'Run Tİme of Block : %', start_at;
end $$;