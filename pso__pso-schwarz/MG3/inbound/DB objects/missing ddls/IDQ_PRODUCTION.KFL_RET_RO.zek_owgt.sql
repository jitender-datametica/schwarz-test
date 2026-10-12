create or replace view IDQ_PRODUCTION.kfl_ret_ro.zek_owgt(
	mandt,
	spras,
	matkl,
	owg,
	owg_desc,
	country_code,
	td_insert,
	td_update
) as
select 
	mandt,
	spras,
	matkl,
	owg,
	owg_desc,
	country_code,
	td_insert,
	td_update
    from kfl_ret.zek_owgt
where country_code in ('RO','ro');
