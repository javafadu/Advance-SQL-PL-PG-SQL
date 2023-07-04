-- ******** NESTED BLOCK ********
do $$
<<outer_block>>  --naming of outer block
declare -- outer block
	counter integer :=0;
begin
	counter := counter + 1;
	raise notice 'counter : %',counter;
	
	declare -- inner block
		counter integer := 0;
	begin
		counter := counter + 10;
		raise notice 'inner block counter : %',counter;
		raise notice 'outer block counter : %',outer_block.counter; 
	end; -- end of inner block
	
	raise notice 'outer block counter : %', counter;

end outer_block $$;