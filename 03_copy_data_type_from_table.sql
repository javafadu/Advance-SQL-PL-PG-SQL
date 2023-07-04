-- ******** COPY DATA TYPE from TABLE ********
do $$
declare
	movie_title public.movie.title%type;
	featured_title public.movie.title%type;
begin
	-- get title of movie with 1 id
	select title
	from public.movie
	into movie_title
	where id=1;
	
	raise notice 'Movie Title with id 1 : %', movie_title;
	
end $$;