CREATE OR REPLACE VIEW FE_MSTR_LIFECYCLE.MV_F_LIFECYCLE_RVM_CONTAINER_RETURN_PER_DAY_2 
AS 
SELECT 
 SUM(core.t_fact_deposit_return_per_hour.deposit_item_cnt) AS RETURN_CNT
,core.t_fact_deposit_return_per_hour.cal_dt
,core.t_fact_deposit_return_per_hour.rvm_sid
,core.t_fact_deposit_return_per_hour.deposit_item_sub_cat_id
FROM 
core.t_fact_deposit_return_per_hour_2
GROUP BY 
 deposit_item_sub_cat_id,cal_dt
,rvm_sid
;