CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_fact_exchange_rate (from_curr_cd, to_curr_cd, exchange_rate_type_cd,
active_from_dt, active_to_dt, active_fg, bus_year, exchange_rate, dwh_load_id, dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_mart_lead.v_fact_exchange_rate AS EXCH;