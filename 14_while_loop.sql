-- ******** WHILE LOOP ***********
-- syntax
/*
[<<label>>]
while condition loop
	statements;
end loop;
*/

-- TASK : print counter values from 1 to 4
do $$
declare
	n integer := 4;
	counter integer := 0;
begin
	while counter<n loop
		counter := counter +1;
		raise notice '%', counter;
	end loop;
end $$;