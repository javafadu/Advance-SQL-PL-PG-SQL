-- ******** FOR LOOP for DB ***********
-- syntax
/*
[<<label>>]
for target in query loop
	statements;
end loop [label];
*/
-- TASK: print the longest 2 movies ordered by length

do $$
declare
	counter integer := 0;
	movies record;
begin
	for movies in 
		select title,length
		from movie 
		order by length DESC
		limit 2
	loop
		raise notice '%  ( % minutes)', movies.title, movies.length;
	END loop;
end $$;
