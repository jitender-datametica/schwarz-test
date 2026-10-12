CREATE OR REPLACE VIEW szd_fe_mstr_lifecycle.v_f_lifecycle_hga_availability_per_week AS SELECT hga_sid,
 cy_week,
 weekly_avail_pct,
 no_sale_weekly_val
FROM szd_core.t_fact_hga_availability_per_week;