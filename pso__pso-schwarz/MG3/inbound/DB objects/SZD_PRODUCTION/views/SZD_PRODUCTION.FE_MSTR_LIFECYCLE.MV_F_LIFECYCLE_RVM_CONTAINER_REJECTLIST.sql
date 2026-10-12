create or replace view SZD_PRODUCTION.FE_MSTR_LIFECYCLE.MV_F_LIFECYCLE_RVM_CONTAINER_REJECTLIST(
	EAN_CNT,
	REJECT_DT,
	RVM_SID,
	DEPOSIT_ITEM_CAT_CD,
	EAN,
	REJECT_REASON_GROUP_ID
) as
SELECT
COUNT(core.t_fact_deposit_rejectlist.ean) AS ean_cnt
,core.t_fact_deposit_rejectlist.reject_dt
,core.t_fact_deposit_rejectlist.rvm_sid
,core.t_fact_deposit_rejectlist.deposit_item_cat_cd
,core.t_fact_deposit_rejectlist.ean
,core.t_fact_deposit_rejectlist.reject_reason_group_id
FROM
core.t_fact_deposit_rejectlist
GROUP BY
 reject_dt
,rvm_sid
,deposit_item_cat_cd
,reject_reason_group_id
,ean
;