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