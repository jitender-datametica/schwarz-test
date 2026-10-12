create or replace view `daia-d-sdi-sdiidq-0.kfl_ret_sk.mamt`(
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
 where country_code in ('SK','sk');
