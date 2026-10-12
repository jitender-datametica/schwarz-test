CREATE OR REPLACE VIEW FE_MSTR_LIFECYCLE.MV_F_LIFECYCLE_RVM_CONTAINER_REJECTED_PER_WEEK_2 
AS 
SELECT 
 core.t_fact_deposit_reject_per_day.reject_dt
,core.t_fact_deposit_reject_per_day.rvm_sid
,core.t_fact_deposit_reject_per_day.deposit_item_cat_cd
,core.t_fact_deposit_reject_per_day.reject_cnt
FROM 
core.t_fact_deposit_reject_per_day_2
GROUP BY
 deposit_item_cat_cd
,reject_dt
,rvm_sid
,reject_cnt
;