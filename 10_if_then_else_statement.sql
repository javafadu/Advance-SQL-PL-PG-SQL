-- ******** IF-THEN-ELSE STATEMENT ***********
/*
if condition then 
	statements;
else
	alternative-statements;
END if;
*/

do $$
declare
	selected_movie movie%rowtype;
	input_movie_id movie.id%type :=3;
begin
	select * from movie
	into selected_movie
	where id=input_movie_id;

	if not found then
		raise notice 'The movie with id % is not found', input_movie_id;
	else
		raise notice 'The movie with id % is : %', input_movie_id, selected_movie.title;
	END if;
end $$;