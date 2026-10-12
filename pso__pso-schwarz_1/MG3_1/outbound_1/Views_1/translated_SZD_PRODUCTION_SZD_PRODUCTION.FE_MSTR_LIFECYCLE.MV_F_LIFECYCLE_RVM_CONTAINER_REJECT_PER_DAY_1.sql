CREATE OR REPLACE VIEW szd_production_fe_mstr_lifecycle.mv_f_lifecycle_rvm_container_reject_per_day_1 (reject_dt, rvm_sid
, deposit_item_cat_cd, reject_cnt) AS SELECT reject_dt,
 rvm_sid,
 deposit_item_cat_cd,
 reject_cnt
FROM szd_production_core.t_fact_deposit_reject_per_day_1;