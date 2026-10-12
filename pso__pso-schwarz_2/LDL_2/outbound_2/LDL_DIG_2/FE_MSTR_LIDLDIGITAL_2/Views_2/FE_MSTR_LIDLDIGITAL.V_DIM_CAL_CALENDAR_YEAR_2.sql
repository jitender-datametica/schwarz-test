CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_cal_calendar_year_2 AS SELECT cy,
 cy_begin_month,
 cy_end_month,
 cy_begin_dt,
 cy_end_dt,
 cy_week_cnt,
 cy_day_cnt,
 cy_prev_1y,
 cy_prev_2y,
 cy_prev_3y,
 cy_prev_4y,
 cy_prev_5y,
 cy_offset
FROM ldl_dig_lec_share.v_dim_cal_calendar_year_2
WHERE cy <> -1
UNION ALL
SELECT ROUND(CAST('-1' AS BIGNUMERIC), 0) AS dm__operand0,
 ROUND(CAST('-1' AS BIGNUMERIC), 0) AS dm__operand1,
 ROUND(CAST('-1' AS BIGNUMERIC), 0) AS dm__operand2,
 DATE('1900-01-01') AS dm__operand3,
 DATE('1900-01-01') AS dm__operand4,
 ROUND(CAST('0' AS BIGNUMERIC), 0) AS dm__operand5,
 ROUND(CAST('0' AS BIGNUMERIC), 0) AS dm__operand6,
 ROUND(CAST('-1' AS BIGNUMERIC), 0) AS dm__operand7,
 ROUND(CAST('-1' AS BIGNUMERIC), 0) AS dm__operand8,
 ROUND(CAST('-1' AS BIGNUMERIC), 0) AS dm__operand9,
 ROUND(CAST('-1' AS BIGNUMERIC), 0) AS dm__operand10,
 ROUND(CAST('-1' AS BIGNUMERIC), 0) AS dm__operand11,
 ROUND(CAST('999' AS BIGNUMERIC), 0) AS dm__operand12;