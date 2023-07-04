-- ******** CONTINUE ***********
-- used to skip the current iteration
-- syntax
/*
continue [loop_label] [when_condition] -> [] these are optional
*/
do $$
declare
	counter integer := 0;	--variable with 0 default value
begin
	loop 
		counter := counter+1;	-- increase counter 1 in each 	
		exit when counter>10;	-- exit loop when counter >10
		continue when mod(counter,2)=0;	-- if the counter is even, exit and go next iteration
		raise notice '%',counter; -- ifthe counter is odd, print it
	end loop;
end $$;