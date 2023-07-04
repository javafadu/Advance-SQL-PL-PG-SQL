-- ******** EXIT in LOOP ***********

-- opt1: (best and short way)
exit when counter>10 then

-- opt2:
if counter>10 then
	exit;
END if;


do $$
begin
	<<inner_block>>
	begin
		exit inner_block;
		raise notice 'inner block hello'; --not print, already ended above line
	end;
	raise notice 'outer block hello';
end $$;