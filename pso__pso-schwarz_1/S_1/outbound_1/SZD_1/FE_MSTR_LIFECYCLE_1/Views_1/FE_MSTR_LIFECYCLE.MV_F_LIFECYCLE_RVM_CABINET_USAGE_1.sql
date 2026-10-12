CREATE OR REPLACE VIEW szd_fe_mstr_lifecycle.mv_f_lifecycle_rvm_cabinet_usage_1 AS SELECT rvm_sid,
 compactor_id,
 cabinet_id,
 compacted_bottles_cnt,
 cal_dt
FROM szd_core.t_fact_cabinet_usage_1;