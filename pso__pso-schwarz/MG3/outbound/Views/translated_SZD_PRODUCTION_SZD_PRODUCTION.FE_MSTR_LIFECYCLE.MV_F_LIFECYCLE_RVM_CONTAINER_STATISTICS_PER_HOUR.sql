CREATE OR REPLACE VIEW szd_production_fe_mstr_lifecycle.mv_f_lifecycle_rvm_container_statistics_per_hour (return_hour,
deposit_item_cnt, rvm_sid, cal_dt, deposit_item_sub_cat_id) AS SELECT return_hour,
 deposit_item_cnt,
 rvm_sid,
 cal_dt,
 deposit_item_sub_cat_id
FROM szd_production_core.t_fact_deposit_return_per_hour
GROUP BY return_hour,
 deposit_item_cnt,
 rvm_sid,
 cal_dt,
 deposit_item_sub_cat_id;