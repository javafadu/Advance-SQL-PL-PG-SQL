-- comment
-- ******* Variable Declaration ******
do $$ -- anonymous block, dolar dolar add them not to use '' for special chars
declare
	counter integer := 1 ; -- variable: counter and default value is 1
	first_name varchar(50) := 'Ahmet' ;
	last_name varchar(50) := 'Yilmaz' ;
	payment numeric(4,2) := 20.5 ;  -- 20.50 (4,2) -> precision 4 number, scale 2 decimal
begin
 raise notice '% % % has been paid % USD',
 	counter,
	first_name,
	last_name,
	payment;
end $$ ;


-- TASK1 : declare variables and print this: "Ahmet and Mehmet bought tickets for 1200 TRY"
do $$ 
declare
	first_person varchar(50) := 'Ahmet' ;
	second_person varchar(50) := 'Mehmet' ;
	payment numeric(4,0) := 1200 ;  -- 20.50 (4,2) -> precision 4 number, scale 2 decimal
begin
 raise notice '% and % bought tickets for % TRY',
	first_person,
	second_person,
	payment;
end $$ ;


-- ********* WAIT COMMAND *********
do $$
declare 
	create_at time := now();
begin
	raise notice '%', create_at;
	perform pg_sleep(5); -- wait 5 seconds
	raise notice '%', create_at;
end $$;


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
	
-- ******** RECORD TYPE ********
do $$
declare
	rec record;
begin
	-- select a movie with id no 1
	select id, title, type
	into rec
	from movie
	where id=2;
	
	raise notice '% - % - % ', rec.id, rec.title, rec.type;
end $$;
	

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
	
-- ******** CONSTANT ********



