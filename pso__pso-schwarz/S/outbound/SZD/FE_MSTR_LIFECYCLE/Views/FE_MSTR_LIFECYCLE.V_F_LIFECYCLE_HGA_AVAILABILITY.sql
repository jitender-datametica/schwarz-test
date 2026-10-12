CREATE OR REPLACE VIEW szd_fe_mstr_lifecycle.v_f_lifecycle_hga_availability AS SELECT hga_sid,
 total_avail_pct,
 last_online_tmsp
FROM szd_core.t_fact_hga_total_availability;