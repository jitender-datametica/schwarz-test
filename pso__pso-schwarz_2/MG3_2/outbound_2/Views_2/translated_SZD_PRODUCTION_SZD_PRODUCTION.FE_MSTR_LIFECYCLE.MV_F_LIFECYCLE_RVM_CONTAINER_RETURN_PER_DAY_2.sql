CREATE OR REPLACE VIEW szd_production_fe_mstr_lifecycle.mv_f_lifecycle_rvm_container_return_per_day_2 (return_cnt, cal_dt
, rvm_sid, deposit_item_sub_cat_id) AS SELECT SUM(deposit_item_cnt) AS return_cnt,
 cal_dt,
 rvm_sid,
 deposit_item_sub_cat_id
FROM szd_production_core.t_fact_deposit_return_per_hour_2
GROUP BY deposit_item_sub_cat_id,
 cal_dt,
 rvm_sid;