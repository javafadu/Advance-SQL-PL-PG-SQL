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