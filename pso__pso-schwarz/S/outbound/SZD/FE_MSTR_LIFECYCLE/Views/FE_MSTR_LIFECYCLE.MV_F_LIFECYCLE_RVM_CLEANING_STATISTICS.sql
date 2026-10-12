CREATE OR REPLACE VIEW szd_fe_mstr_lifecycle.mv_f_lifecycle_rvm_cleaning_statistics (begin_of_cleaning_dt, rvm_sid,
cleaning_type_cd, cleaning_status_cd, deposit_receipt_printed_fg, cleaning_dur_sec_cnt) AS SELECT cal_dt AS
 begin_of_cleaning_dt,
 rvm_sid,
 cleaning_type_cd,
 cleaning_status_cd,
 deposit_receipt_printed_fg,
 cleaning_dur_sec_cnt
FROM szd_core.t_fact_rvm_cleaning_deposit_receipt_per_day;