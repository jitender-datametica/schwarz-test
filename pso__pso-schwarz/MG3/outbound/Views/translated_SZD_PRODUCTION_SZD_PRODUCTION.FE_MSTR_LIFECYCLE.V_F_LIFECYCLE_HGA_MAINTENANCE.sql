CREATE OR REPLACE VIEW szd_production_fe_mstr_lifecycle.v_f_lifecycle_hga_maintenance (hga_sid, report_dt,
cleaning_liquid_ltr_qty, service_cnt, filter_cnt, cleaning_cnt, door_open_cnt) AS SELECT hga_sid,
 report_dt,
 cleaning_liquid_ltr_qty,
 service_cnt,
 filter_cnt,
 cleaning_cnt,
 door_open_cnt
FROM szd_production_core.t_fact_hga_maintenance;