CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_cal_business_year_2 AS SELECT bus_year,
 bus_year_begin_month,
 bus_year_end_month,
 bus_year_begin_dt,
 bus_year_end_dt,
 bus_year_week_cnt,
 bus_year_day_cnt,
 bus_year_prev_1y,
 bus_year_prev_2y,
 bus_year_prev_3y,
 bus_year_prev_4y,
 bus_year_prev_5y,
 bus_year_offset
FROM ldl_dig_lec_share.v_dim_cal_business_year_2
WHERE bus_year <> -1
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