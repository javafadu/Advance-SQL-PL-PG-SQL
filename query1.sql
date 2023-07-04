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
-- selling_price := net_price*1.18;
-- selling_price := net_price + net_price * vat;
do $$
declare
	vat constant numeric := 0.18;
	net_price numeric := 20.5;
begin
	raise notice 'Sellin Price : %', net_price*(1+vat);
	-- vat := 0.08; constant variable can not be changed, there will be an exception
end $$;

-- ******** SET CONSTANT in RUN TIME ***********
do $$
declare
	start_at constant time := now();
begin
	raise notice 'Run Tİme of Block : %', start_at;
end $$;

-- ///////////// CONTROL STRUCTURES //////////////

-- ******** IF STATEMENT ***********
/*
if condition then
	statement;
end if;
*/

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


-- ******** CASE STATEMENT ***********
/*
case search-expression
	when expression_1 [, expression_2,...] then
		statements
	[...]
	[else
		else-statements]
END case;
*/

/*
TASK : According to the genre of movie, print it is suitable for children or not
	
*/
do $$
declare
	genre movie.type%type;
	warning_comment varchar(50);
begin
	select type into genre
	from movie
	where id = 1;
	
	if found then
		case genre
			when 'Horror' then
				warning_comment = 'It is not suitable for children';
			when 'Adventure' then
				warning_comment = 'It is suitable for children';
			when 'Animation' then
				warning_comment = 'It is recommended for children';
			else
				warning_comment = 'It is not defined';
		END case;	
		
		raise notice '%', warning_comment;
	END if;
end $$;


-- ******** LOOP ***********
-- syntax
/*
<<label>>
loop
	statement;
end loop;
*/

-- to end loop, we can use if statement in the block
/*
<<label>>
loop
	statement;
	if condition then
		exit;
	end if;
end loop;
*/

-- nested loop
/*
<<outer>>
loop
	statements;
	<<inner>>
	loop
		.....
		exit <<inner>>
	end loop;
end loop;
*/

-- TASK : fibonacci numbers 1-1-2-3-5-8-....., get the index n element of fibonacci
do $$
declare
	n integer := 4;
	counter integer := 0;
	i integer := 0;
	j integer := 1;
	fib integer :=0;
begin
	if(n<1) then
		fib = 0;
	END if;
	
	loop
		exit when counter = n;
		counter := counter +1;
		select j,i+j into i,j;
	END loop;
	fib := i;
	
	raise notice '%',fib;
	
end $$;


-- ******** WHILE LOOP ***********
-- syntax
/*
[<<label>>]
while condition loop
	statements;
end loop;
*/

-- TASK : print counter values from 1 to 4
do $$
declare
	n integer := 4;
	counter integer := 0;
begin
	while counter<n loop
		counter := counter +1;
		raise notice '%', counter;
	end loop;
end $$;


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


-- ******** EXIT ***********

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

-- ******** CONTINUE ***********
-- used to skip the current iteration
-- syntax
/*
continue [loop_label] [when_condition] -> [] these are optional
*/
do $$
declare
	counter integer := 0;	--variable with 0 default value
begin
	loop 
		counter := counter+1;	-- increase counter 1 in each 	
		exit when counter>10;	-- exit loop when counter >10
		continue when mod(counter,2)=0;	-- if the counter is even, exit and go next iteration
		raise notice '%',counter; -- ifthe counter is odd, print it
	end loop;
end $$;

