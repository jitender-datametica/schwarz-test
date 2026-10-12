CREATE OR REPLACE VIEW szd_production_fe_mstr_lifecycle.mv_f_lifecycle_rvm_customer_statistics_per_day_2 (rvm_sid,
receipt_gross_local_val, local_curr_cd, receipt_gross_global_val, global_curr_cd, deposit_outpayment_type_cd, cal_dt,
receipt_cnt) AS SELECT rvm_sid,
 receipt_gross_local_val,
 local_curr_cd,
 receipt_gross_global_val,
 global_curr_cd,
 deposit_outpayment_type_cd,
 receipt_dt AS cal_dt,
 COUNT(receipt_nr) AS receipt_cnt
FROM szd_production_core.t_fact_deposit_receipt_2
GROUP BY rvm_sid,
 receipt_gross_local_val,
 local_curr_cd,
 receipt_gross_global_val,
 global_curr_cd,
 deposit_outpayment_type_cd,
 cal_dt;