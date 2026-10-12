create or replace view IDQ_PRODUCTION.kfl_ret_ro.mamt(
	mandt,
	matnr,
	spras,
	meinh,
	mtxid,
	lfdnr,
	maktm,
	country_code,
	td_insert,
	td_update
) as select
	mandt,
	matnr,
	spras,
	meinh,
	mtxid,
	lfdnr,
	maktm,
	country_code,
	td_insert,
	td_update
from kfl_ret.mamt
 where country_code in ('RO','ro');
