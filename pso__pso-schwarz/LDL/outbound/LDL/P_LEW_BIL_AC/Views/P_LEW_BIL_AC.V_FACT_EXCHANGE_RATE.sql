CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_fact_exchange_rate (from_curr_cd, to_curr_cd, exchange_rate_type_cd,
active_from_dt, active_to_dt, active_fg, bus_year, exchange_rate, dwh_load_id, dwh_created, dwh_updated) AS SELECT
 from_curr_cd,
 to_curr_cd,
 exchange_rate_type_cd,
 active_from_dt,
 active_to_dt,
 active_fg,
 bus_year,
 exchange_rate,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_bil.t_fact_exchange_rate AS EXCH;