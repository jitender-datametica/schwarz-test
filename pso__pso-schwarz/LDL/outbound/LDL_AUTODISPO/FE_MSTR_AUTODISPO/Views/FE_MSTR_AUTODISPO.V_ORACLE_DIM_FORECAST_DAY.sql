CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_dim_forecast_day (country, forecast_day, mod_date,
source_extraction_tmsp, snflk_insert_tmsp, snflk_update_tmsp) AS SELECT country,
 forecast_days AS forecast_day,
 mod_date,
 source_extraction_tmsp,
 snflk_insert_tmsp,
 snflk_update_tmsp
FROM ldl_autodispo_core.t_oracle_v_forecast_days;