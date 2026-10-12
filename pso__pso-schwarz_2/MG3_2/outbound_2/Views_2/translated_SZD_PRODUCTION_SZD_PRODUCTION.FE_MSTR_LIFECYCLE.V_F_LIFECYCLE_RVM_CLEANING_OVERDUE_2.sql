CREATE OR REPLACE VIEW szd_production_fe_mstr_lifecycle.v_f_lifecycle_rvm_cleaning_overdue_2 (rvm_sid,
last_green_cleaning_dt, diff_days) AS SELECT rvm_sid,
 MAX(end_of_cleaning_dt) AS last_green_cleaning_dt,
 DATE_DIFF(DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY), MAX(end_of_cleaning_dt), DAY) AS diff_days
FROM szd_production_core.t_fact_rvm_cleaning_2
WHERE cleaning_dur_sec_cnt BETWEEN 130 AND 540
 AND cleaning_status_cd = 'com'
GROUP BY rvm_sid
HAVING DATE_DIFF(DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY), last_green_cleaning_dt, DAY) > 2
ORDER BY last_green_cleaning_dt DESC NULLS FIRST;