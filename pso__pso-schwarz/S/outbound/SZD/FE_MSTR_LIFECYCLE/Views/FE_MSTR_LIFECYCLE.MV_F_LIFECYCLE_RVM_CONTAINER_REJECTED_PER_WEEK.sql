CREATE OR REPLACE VIEW szd_fe_mstr_lifecycle.mv_f_lifecycle_rvm_container_rejected_per_week AS SELECT reject_dt,
 rvm_sid,
 deposit_item_cat_cd,
 reject_cnt
FROM szd_core.t_fact_deposit_reject_per_day
GROUP BY deposit_item_cat_cd,
 reject_dt,
 rvm_sid,
 reject_cnt;