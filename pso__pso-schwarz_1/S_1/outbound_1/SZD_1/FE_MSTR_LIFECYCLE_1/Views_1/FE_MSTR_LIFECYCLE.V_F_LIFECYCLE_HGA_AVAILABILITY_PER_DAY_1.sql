CREATE OR REPLACE VIEW szd_fe_mstr_lifecycle.v_f_lifecycle_hga_availability_per_day_1 AS SELECT hga_sid,
 avail_dt,
 daily_avail_pct,
 no_sale_daily_val,
 last_online_tmsp
FROM szd_core.t_fact_hga_availability_per_day_1;