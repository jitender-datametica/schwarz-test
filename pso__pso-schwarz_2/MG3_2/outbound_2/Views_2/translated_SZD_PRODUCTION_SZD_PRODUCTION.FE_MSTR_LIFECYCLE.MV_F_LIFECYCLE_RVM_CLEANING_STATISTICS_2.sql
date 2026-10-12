CREATE OR REPLACE VIEW szd_production_fe_mstr_lifecycle.mv_f_lifecycle_rvm_cleaning_statistics_2 (rvm_sid,
cleaning_type_cd, cleaning_status_cd, begin_of_cleaning_dt, cleaning_dur_sec_cnt) AS SELECT rvm_sid,
 cleaning_type_cd,
 cleaning_status_cd,
 begin_of_cleaning_dt,
 cleaning_dur_sec_cnt
FROM szd_production_core.t_fact_rvm_cleaning_2;