CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_hive_dim_forecast_day_2 (country_2, forecast_day) AS SELECT *
FROM ldl_autodispo_core.t_hive_dim_forecast_day_2;