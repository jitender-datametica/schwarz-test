CREATE OR REPLACE VIEW szd_fe_mstr_lifecycle.mv_f_lifecycle_rvm_container_rejectlist_1 AS SELECT COUNT(ean_1) AS ean_cnt,
 reject_dt,
 rvm_sid,
 deposit_item_cat_cd,
 ean_1,
 reject_reason_group_id
FROM szd_core.t_fact_deposit_rejectlist_1
GROUP BY reject_dt,
 rvm_sid,
 deposit_item_cat_cd,
 reject_reason_group_id,
 ean_1;