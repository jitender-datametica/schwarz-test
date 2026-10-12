CREATE OR REPLACE VIEW szd_production_fe_mstr_lifecycle.mv_f_lifecycle_rvm_cabinet_usage_1 (rvm_sid, compactor_id,
cabinet_id, compacted_bottles_cnt, cal_dt) AS SELECT rvm_sid,
 compactor_id,
 cabinet_id,
 compacted_bottles_cnt,
 cal_dt
FROM szd_production_core.t_fact_cabinet_usage_1;