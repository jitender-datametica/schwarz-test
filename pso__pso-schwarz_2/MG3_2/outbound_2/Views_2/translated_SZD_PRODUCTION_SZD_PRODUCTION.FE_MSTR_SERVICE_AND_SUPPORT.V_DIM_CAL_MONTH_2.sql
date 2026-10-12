CREATE OR REPLACE VIEW szd_production_fe_mstr_service_and_support.v_dim_cal_month_2 (cy_month, month_of_bus_year,
month_of_year_short_name, month_of_year_name, cy_month_offset) AS SELECT cy_month,
 month_of_bus_year,
 month_of_year_short_name,
 month_of_year_name,
 cy_month_offset
FROM szd_production_core.t_dim_cal_month_2;