CREATE OR REPLACE VIEW szd_fe_mstr_lifecycle.v_l_lifecycle_exchange_rate_2 AS SELECT dwh_valid_from_dt,
 dwh_valid_to_dt,
 active_from_dt,
 active_to_dt,
 curr_cd_from,
 curr_cd_to,
 exchange_rate
FROM szd_core.t_dim_exchange_rate_2;