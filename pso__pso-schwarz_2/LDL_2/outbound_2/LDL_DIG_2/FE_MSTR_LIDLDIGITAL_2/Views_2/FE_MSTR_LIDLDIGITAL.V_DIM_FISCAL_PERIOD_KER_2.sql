CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_fiscal_period_ker_2 (bus_year, month_of_year, month_of_bus_year,
month_of_year_short_name, cal_year, cy_month_offset, cy_month, bus_year_offset, bus_year_prev_1y) AS SELECT CM.bus_year
 ,
 CM.month_of_year,
 CM.month_of_bus_year,
 CM.month_of_year_short_name,
 CM.cy AS cal_year,
 CM.cy_month_offset,
 CM.cy_month,
 CM.bus_year_offset,
 CBY.bus_year_prev_1y
FROM ldl_dig_lec_share.v_dim_cal_month_2 AS CM
 INNER JOIN ldl_dig_lec_share.v_dim_cal_business_year_2 AS CBY ON CM.bus_year = CBY.bus_year
WHERE CM.cy_month <> -1
UNION ALL
SELECT DISTINCT CM.bus_year,
 13 AS month_of_year,
 13 AS month_of_bus_year,
 'P13' AS month_of_year_short_name,
 CM.bus_year AS cal_year,
 CM.bus_year AS cy_month_offset,
 13 AS cy_month,
 CM.bus_year_offset,
 CBY.bus_year_prev_1y
FROM ldl_dig_lec_share.v_dim_cal_month_2 AS CM
 INNER JOIN ldl_dig_lec_share.v_dim_cal_business_year_2 AS CBY ON CM.bus_year = CBY.bus_year
WHERE CM.cy_month <> -1
UNION ALL
SELECT ROUND(CAST('-1' AS BIGNUMERIC), 0),
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 '',
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 ROUND(CAST('0' AS BIGNUMERIC), 0),
 ROUND(CAST('0' AS BIGNUMERIC), 0),
 ROUND(CAST('-1' AS BIGNUMERIC), 0);