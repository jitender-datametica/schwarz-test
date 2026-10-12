create or replace view IDQ_PRODUCTION.kfl_ret_ro.mean(
	mandt,
	matnr,
	meinh,
	lfnum,
	ean11,
	eantp,
	hpean,
	sgt_catv,
	country_code,
	td_insert,
	td_update
) as select
mandt,
matnr,
meinh,
lfnum,
ean11,
eantp,
hpean,
sgt_catv,
country_code,
td_insert,
td_update
from kfl_ret.mean
 where country_code in ('RO','ro');
