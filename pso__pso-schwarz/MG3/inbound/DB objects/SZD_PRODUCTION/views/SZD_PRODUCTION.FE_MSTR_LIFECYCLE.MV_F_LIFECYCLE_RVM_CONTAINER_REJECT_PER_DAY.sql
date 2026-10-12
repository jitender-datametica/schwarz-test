create or replace view SZD_PRODUCTION.FE_MSTR_LIFECYCLE.MV_F_LIFECYCLE_RVM_CONTAINER_REJECT_PER_DAY(
	REJECT_DT,
	RVM_SID,
	DEPOSIT_ITEM_CAT_CD,
	REJECT_CNT
) as 
SELECT 
 core.t_fact_deposit_reject_per_day.reject_dt
,core.t_fact_deposit_reject_per_day.rvm_sid
,core.t_fact_deposit_reject_per_day.deposit_item_cat_cd
,core.t_fact_deposit_reject_per_day.reject_cnt
FROM 
core.t_fact_deposit_reject_per_day
;