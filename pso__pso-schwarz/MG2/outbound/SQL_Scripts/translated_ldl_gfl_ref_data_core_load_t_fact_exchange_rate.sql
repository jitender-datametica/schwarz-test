TRUNCATE TABLE ldl_data_production_core_dim.t_fact_exchange_rate;


INSERT INTO ldl_data_production_core_dim.t_fact_exchange_rate (src_curr_cd, tgt_curr_cd, exchange_rate_type_cd,
 active_from_dt, active_to_dt, active_fg, bus_year, exchange_rate, dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id,
 dwh_node_cd)
(SELECT src_curr_cd,
  tgt_curr_cd,
  exchange_rate_type_cd,
  CAST(dwh_valid_from_tmsp AS DATE) AS dwh_valid_from_tmsp,
  CAST(dwh_valid_to_tmsp AS DATE) AS dwh_valid_to_tmsp,
  dwh_valid_fg,
   CASE
   WHEN EXTRACT(DAY FROM dwh_valid_from_tmsp) = 1 AND EXTRACT(MONTH FROM dwh_valid_from_tmsp) = 3 AND EXTRACT(DAY FROM
       dwh_valid_to_tmsp) IN (28, 29) AND EXTRACT(MONTH FROM dwh_valid_to_tmsp) = 2
   THEN CAST(EXTRACT(YEAR FROM dwh_valid_from_tmsp) AS INTEGER)
   ELSE 0
   END AS bus_year,
  exchange_rate,
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP(),
  CAST('${LOAD_ID}' AS BIGNUMERIC) AS load_id,
  'P_LEW_CORE'
 FROM ldl_data_production_core_rel.t_exchange_rate);
