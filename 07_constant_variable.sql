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