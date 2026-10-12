CREATE OR REPLACE VIEW szd_production_fe_mstr_lifecycle.v_f_lifecycle_hga_availability_per_week (hga_sid, cy_week,
weekly_avail_pct, no_sale_weekly_val) AS SELECT hga_sid,
 cy_week,
 weekly_avail_pct,
 no_sale_weekly_val
FROM szd_production_core.t_fact_hga_availability_per_week;