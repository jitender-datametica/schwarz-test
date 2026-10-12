CREATE OR REPLACE VIEW szd_fe_mstr_lifecycle.v_f_lifecycle_rvm_deposit_cash_data_deposit_receipt_rel_1 AS SELECT
 cash_receipt_nr,
 outpayment_store_nr,
 cash_receipt_dt,
 cash_receipt_tm,
 rvm_sid,
 deposit_receipt_dt,
 deposit_receipt_tm,
 deposit_receipt_nr,
 deposit_local_val,
 local_curr_cd,
 deposit_global_val,
 global_curr_cd,
 deposit_outpayment_type_cd
FROM szd_core.t_fact_deposit_cash_data_deposit_receipt_rel_1;