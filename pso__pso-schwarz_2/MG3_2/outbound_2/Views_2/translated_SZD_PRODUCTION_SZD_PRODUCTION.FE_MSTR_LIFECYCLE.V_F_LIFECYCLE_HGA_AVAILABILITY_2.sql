CREATE OR REPLACE VIEW szd_production_fe_mstr_lifecycle.v_f_lifecycle_hga_availability_2 (hga_sid, total_avail_pct,
last_online_tmsp) AS SELECT hga_sid,
 total_avail_pct,
 last_online_tmsp
FROM szd_production_core.t_fact_hga_total_availability_2;