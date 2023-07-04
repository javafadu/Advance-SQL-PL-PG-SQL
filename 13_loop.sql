-- ******** LOOP ***********
-- syntax
/*
<<label>>
loop
	statement;
end loop;
*/

-- to end loop, we can use if statement in the block
/*
<<label>>
loop
	statement;
	if condition then
		exit;
	end if;
end loop;
*/

-- nested loop
/*
<<outer>>
loop
	statements;
	<<inner>>
	loop
		.....
		exit <<inner>>
	end loop;
end loop;
*/

-- TASK : fibonacci numbers 1-1-2-3-5-8-....., get the index n element of fibonacci
do $$
declare
	n integer := 4;
	counter integer := 0;
	i integer := 0;
	j integer := 1;
	fib integer :=0;
begin
	if(n<1) then
		fib = 0;
	END if;
	
	loop
		exit when counter = n;
		counter := counter +1;
		select j,i+j into i,j;
	END loop;
	fib := i;
	
	raise notice '%',fib;
	
end $$;