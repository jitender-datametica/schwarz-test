CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_currency_2 AS SELECT t2.client_id0 AS client_id,
 t2.country_lidl_cd,
 t2.orig_curr_cd,
 t2.target_curr_cd,
 t2.exchange_rate
FROM (SELECT DISTINCT CURR.client_id AS client_id0,
   CLIENTS.src_country_lidl_cd AS country_lidl_cd,
   CURR.curr_cd_from AS orig_curr_cd,
   CURR.curr_cd_to AS target_curr_cd,
   CURR.exchange_rate,
   CURR.client_id,
   CURR.curr_cd_from,
   CURR.curr_cd_to
  FROM ldl_p_lew_core.t_exchange_rate_known_hist_2 AS CURR
   INNER JOIN ldl_p_lew_core.t_exchange_rate_type_2 AS RATE ON CURR.client_id = RATE.client_id AND CURR.x_rate_type_sid =
     RATE.x_rate_type_sid
   INNER JOIN ldl_p_lew_core_ac.v_client_2 AS CLIENTS ON CURR.client_id = CLIENTS.client_id
  WHERE CURRENT_DATE BETWEEN CURR.dwh_valid_from AND CURR.dwh_valid_to
   AND CURRENT_DATE BETWEEN CURR.active_from_dt AND CURR.active_to_dt
   AND CURR.deleted_fg = 0
  ORDER BY CURR.client_id NULLS LAST,
   CURR.curr_cd_from NULLS LAST,
   CURR.curr_cd_to NULLS LAST) AS t2;