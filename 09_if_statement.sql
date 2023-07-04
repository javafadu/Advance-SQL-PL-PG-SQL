-- ******** IF STATEMENT ***********
if condition then
	statement;
end if;

-- TASK: find the movie with id no = 0, if it is not exist write a notice
do $$
declare
	selected_movie movie%rowtype;
	input_movie_id movie.id%type :=0;
begin
	select * 
	from movie
	into selected_movie
	where id = input_movie_id;
	
	if not found then 
		raise notice 'The movie id with % is not found', input_movie_id;
	end if;
end $$;