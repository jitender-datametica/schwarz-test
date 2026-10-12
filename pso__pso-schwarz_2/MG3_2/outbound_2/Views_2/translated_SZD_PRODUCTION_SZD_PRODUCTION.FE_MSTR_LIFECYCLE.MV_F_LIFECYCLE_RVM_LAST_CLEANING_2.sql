CREATE OR REPLACE VIEW szd_production_fe_mstr_lifecycle.mv_f_lifecycle_rvm_last_cleaning_2 (rvm_sid,
last_begin_of_cleaning_dt) AS SELECT rvm_sid,
 MAX(begin_of_cleaning_dt) AS last_begin_of_cleaning_dt
FROM szd_production_core.t_fact_rvm_cleaning_2
GROUP BY rvm_sid;