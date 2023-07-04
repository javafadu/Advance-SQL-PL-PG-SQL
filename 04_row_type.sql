-- ******** ROW TYPE ********
do $$
declare
	selected_actor actor%rowtype;
begin
	select *
	from actor
	into selected_actor
	where id =1;
	
	raise notice 'The actor name is : % %', 
			selected_actor.first_name, selected_actor.last_name;
	
end $$