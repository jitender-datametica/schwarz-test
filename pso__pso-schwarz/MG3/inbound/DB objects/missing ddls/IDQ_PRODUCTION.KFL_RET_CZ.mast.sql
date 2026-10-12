create or replace view `daia-d-sdi-sdiidq-0.kfl_ret_cz.mast`(
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
    from kfl_ret.mast
where country_code in ('CZ','cz');
