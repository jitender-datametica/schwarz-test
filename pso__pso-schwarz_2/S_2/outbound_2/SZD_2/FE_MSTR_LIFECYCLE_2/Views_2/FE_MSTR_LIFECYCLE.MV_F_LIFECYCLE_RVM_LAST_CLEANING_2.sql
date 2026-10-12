CREATE OR REPLACE VIEW szd_fe_mstr_lifecycle.mv_f_lifecycle_rvm_last_cleaning_2 AS SELECT rvm_sid,
 MAX(begin_of_cleaning_dt) AS last_begin_of_cleaning_dt
FROM szd_core.t_fact_rvm_cleaning_2
GROUP BY rvm_sid;