create or replace view IDQ_PRODUCTION.kfl_ret_ro.mast_1(
	mandt,
	matnr,
	werks,
	stlan,
	stlnr,
	stlal,
	losvn,
	losbs,
	andat,
	annam,
	aedat,
	aenam,
	cslty,
	country_code,
	td_insert,
	td_update
) as
select
	mandt,
	matnr,
	werks,
	stlan,
	stlnr,
	stlal,
	losvn,
	losbs,
	andat,
	annam,
	aedat,
	aenam,
	cslty,
	country_code,
	td_insert,
	td_update
    from kfl_ret.mast_1
where country_code in ('RO','ro');
