create or replace view `daia-d-sdi-sdiidq-0.kfl_ret_sk.mean_1`(
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
from kfl_ret.mean_1
 where country_code in ('SK','sk');
