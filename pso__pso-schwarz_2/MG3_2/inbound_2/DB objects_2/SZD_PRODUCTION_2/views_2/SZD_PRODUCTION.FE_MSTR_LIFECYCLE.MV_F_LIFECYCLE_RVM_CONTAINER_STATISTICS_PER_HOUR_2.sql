create or replace view SZD_PRODUCTION.FE_MSTR_LIFECYCLE.MV_F_LIFECYCLE_RVM_CONTAINER_STATISTICS_PER_HOUR_2(
	RETURN_HOUR,
	DEPOSIT_ITEM_CNT,
	RVM_SID,
	CAL_DT,
	DEPOSIT_ITEM_SUB_CAT_ID
) as 
SELECT 
 core.t_fact_deposit_return_per_hour.return_hour
,t_fact_deposit_return_per_hour.deposit_item_cnt
,t_fact_deposit_return_per_hour.rvm_sid
,t_fact_deposit_return_per_hour.cal_dt
,t_fact_deposit_return_per_hour.deposit_item_sub_cat_id
FROM 
CORE.T_FACT_DEPOSIT_RETURN_PER_HOUR_2
GROUP BY
 return_hour
,deposit_item_cnt
,rvm_sid
,cal_dt
,deposit_item_sub_cat_id
;