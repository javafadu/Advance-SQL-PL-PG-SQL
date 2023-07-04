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