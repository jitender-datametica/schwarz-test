CREATE OR REPLACE VIEW FE_MSTR_LIFECYCLE.MV_F_LIFECYCLE_RVM_CONTAINER_REJECTLIST_1
AS
SELECT
COUNT(core.t_fact_deposit_rejectlist.ean_1) AS ean_cnt
,core.t_fact_deposit_rejectlist.reject_dt
,core.t_fact_deposit_rejectlist.rvm_sid
,core.t_fact_deposit_rejectlist.deposit_item_cat_cd
,core.t_fact_deposit_rejectlist.ean_1
,core.t_fact_deposit_rejectlist.reject_reason_group_id
FROM
core.t_fact_deposit_rejectlist_1
GROUP BY
 reject_dt
,rvm_sid
,deposit_item_cat_cd
,reject_reason_group_id
,ean_1
;