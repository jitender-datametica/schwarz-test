CREATE OR REPLACE VIEW szd_production_fe_mstr_lifecycle.v_f_lifecycle_rvm_maintenance_overdue_1 (rvm_sid, cal_dt,
prev_action_dt, due_dt_from, due_dt_to, overdue_day_cnt, overdue_cnt) AS SELECT rvm_sid,
 cal_dt,
 prev_action_dt,
 due_dt_from,
 due_dt_to,
 overdue_day_cnt,
 overdue_cnt
FROM szd_production_core.t_fact_rvm_maintenance_overdue_1;