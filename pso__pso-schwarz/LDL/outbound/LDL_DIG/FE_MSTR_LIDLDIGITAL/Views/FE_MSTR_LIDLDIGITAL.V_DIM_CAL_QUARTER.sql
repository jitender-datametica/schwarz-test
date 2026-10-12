CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_cal_quarter AS SELECT cy_quarter,
 cy,
 bus_year,
 quarter_of_cal_year,
 quarter_of_bus_year,
 cal_quarter_begin_dt,
 cal_quarter_end_dt,
 cal_quarter_prev_1m
FROM ldl_dig_lec_share.v_dim_cal_quarter
WHERE cy_quarter <> -1
UNION ALL
SELECT ROUND(CAST('-1' AS BIGNUMERIC), 0) AS dm__operand0,
 ROUND(CAST('-1' AS BIGNUMERIC), 0) AS dm__operand1,
 ROUND(CAST('-1' AS BIGNUMERIC), 0) AS dm__operand2,
 '-1' AS dm__operand3,
 '-1' AS dm__operand4,
 DATE('1900-01-01') AS dm__operand5,
 DATE('1900-01-01') AS dm__operand6,
 ROUND(CAST('-1' AS BIGNUMERIC), 0) AS dm__operand7;