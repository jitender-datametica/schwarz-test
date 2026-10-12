create or replace view IDQ_PRODUCTION.kfl_ret_ro.makt(
	mandt,
	matnr,
	spras,
	maktx,
	maktg,
	country_code,
	td_insert,
	td_update
) as select
	mandt,
	matnr,
	spras,
	maktx,
	maktg,
	country_code,
	td_insert,
	td_update
from kfl_ret.makt 
 where country_code in ('RO','ro');
