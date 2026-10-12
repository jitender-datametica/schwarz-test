create or replace view `daia-d-sdi-sdiidq-0.kfl_ret_de.zek_muki_wb_2`(
	mandt,
	anrki,
	datab,
	anrmu,
	datbi,
	lastchange,
	username,
	lasttime,
	country_code,
	td_insert,
	td_update
) as
select 
    mandt,
	anrki,
	datab,
	anrmu,
	datbi,
	lastchange,
	username,
	lasttime,
	country_code,
	td_insert,
	td_update
    from kfl_ret.zek_muki_wb_2
where country_code in ('DE', 'de');
