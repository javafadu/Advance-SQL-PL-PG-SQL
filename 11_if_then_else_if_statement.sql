-- ******** IF-THEN-ELSE-IF STATEMENT ***********
/*
if condition_1 then 
	statement_1;
elseif condition_2 then
	statement_2;
elseif condition_n then
	statement_n;
else 
	else-statement;
END if;
*/

/* 
TASK : 
- check if the movie is exist with id=1
- if the length is less than 90 -> Short
- 90<lengths<120 -> Medium
- length>120 -> LONG			
*/

do $$
declare
	selected_movie movie%rowtype;
	input_movie_id movie.id%type :=1;
begin

	select * from movie
	into selected_movie
	where id=input_movie_id;
	
	if not found then
		raise notice 'The movie with id % is not found', input_movie_id;
	else
		raise notice 'The Movie is : % - length is : %', selected_movie.title, selected_movie.length;
		if selected_movie.length>0 and selected_movie.length<90 then
			raise notice 'SHORT MOVIE';
		elseif selected_movie.length>=90 and selected_movie.length<120 then
			raise notice 'MEDIUM MOVIE';
		elseif selected_movie.length>=120 then
			raise notice 'LONG MOVIE';
		else
			raise notice 'Undefined';
		END if;	
	END if;
end $$;