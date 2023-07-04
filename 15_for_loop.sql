-- ******** FOR LOOP ***********
-- syntax
/*
[<<label>>]
for loop_counter in [ reverse ] from.. to [ by step ] loop
	statements;
end loop [label];
*/

-- Sample for in
do $$
-- we do not need to declare counter here, due to defining in for loop
begin
	for counter in 1..5 loop
		raise notice 'counter: %',counter;
	end loop;
end $$;

-- Sample for reverse
do $$
begin
	for counter in reverse 5..1 loop
		raise notice 'counter: %', counter;
	END loop;
end $$;

-- Sample for by 
do $$
begin
	for counter in 1..10 by 2 loop
		raise notice 'counter: %', counter;
	END loop;
end $$;