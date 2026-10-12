-- duplication for INTEGER 7 AS CLIENT_ID

CREATE OR REPLACE VIEW ldl_p_lew_mart_cm.v_lil_historical_periods_per_client_and_application_2 AS WITH BASE AS (SELECT T1_2
   .client_id,
   T1.per_id,
   T1.application_id,
   T1.active_fg,
   COALESCE(T3.active_fg, 0) AS active_fg_py,
   T1.transaction_tmsp
  FROM ldl_p_lew_mart_cm.t_lil_historical_periods_per_client_and_application_2 AS T1_2
   INNER JOIN ldl_p_lew_mart_cm.v_lil_period_2 AS T2 ON T1.per_id = T2.per_id
   INNER JOIN ldl_p_lew_mart_cm.t_lil_historical_periods_per_client_and_application_2 AS T3 ON T2.py_per_id = T3.per_id
     AND T1.client_id = T3.client_id AND T1.application_id = T3.application_id) (SELECT *
  FROM (SELECT client_id,
      per_id,
      application_id,
      active_fg,
      active_fg_py,
      transaction_tmsp
     FROM BASE
     UNION ALL
     SELECT client_id,
      per_id,
      application_id,
      active_fg,
      active_fg_py,
      transaction_tmsp
     FROM BASE));