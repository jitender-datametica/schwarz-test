CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_hive_dim_forecast_day_1 (country_1, forecast_day) AS SELECT *
FROM ldl_autodispo_core.t_hive_dim_forecast_day_1;