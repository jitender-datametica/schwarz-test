CREATE OR REPLACE VIEW szd_production_fe_mstr_lifecycle.mv_f_lifecycle_rvm_receipt_per_hour_1 (bons_pro_stunde, receipt_hr
, rvm_sid, receipt_dt) AS SELECT COUNT(receipt_nr) AS bons_pro_stunde,
 receipt_hr,
 rvm_sid,
 receipt_dt
FROM szd_production_core.t_fact_deposit_receipt_1
GROUP BY receipt_hr,
 receipt_dt,
 rvm_sid;