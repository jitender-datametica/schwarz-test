create or replace view `daia-d-sdi-sdiidq-0.kfl_ret_sk.zek_owgt_1`(
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
    from kfl_ret.zek_owgt_1
where country_code in ('SK','sk');
