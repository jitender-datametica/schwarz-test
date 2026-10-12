CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_cal_week_2 (cy_week, prev_week, prev_cy_week, preprev_cy_week,
cy_week_name, cy_week_short_name, cy_week_sequence) AS SELECT cy_week,
 cy_week_prev_1w AS prev_week,
 cy_week_prev_1y AS prev_cy_week,
 cy_week_prev_2y AS preprev_cy_week,
   TRIM(CAST(TRUNC(CAST(cy_week / 100 AS BIGNUMERIC)) AS STRING)) || ' KW ' || SUBSTR(('0' || CAST(MOD(CAST(cy_week AS BIGNUMERIC)
       , 100) AS STRING)), - 2) AS cy_week_name,
  'KW ' || SUBSTR(('0' || CAST(MOD(CAST(cy_week AS BIGNUMERIC), 100) AS STRING)), - 2) AS cy_week_short_name,
 cy_week_seq AS cy_week_sequence
FROM ldl_p_lew_core_ac.v_cal_week_2 AS CW;