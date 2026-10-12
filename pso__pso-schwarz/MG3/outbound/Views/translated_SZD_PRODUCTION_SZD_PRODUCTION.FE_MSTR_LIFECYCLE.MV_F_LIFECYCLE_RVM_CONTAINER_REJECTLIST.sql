CREATE OR REPLACE VIEW szd_production_fe_mstr_lifecycle.mv_f_lifecycle_rvm_container_rejectlist (ean_cnt, reject_dt,
rvm_sid, deposit_item_cat_cd, ean, reject_reason_group_id) AS SELECT COUNT(ean) AS ean_cnt,
 reject_dt,
 rvm_sid,
 deposit_item_cat_cd,
 ean,
 reject_reason_group_id
FROM szd_production_core.t_fact_deposit_rejectlist
GROUP BY reject_dt,
 rvm_sid,
 deposit_item_cat_cd,
 reject_reason_group_id,
 ean;