CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_fiscal_period AS SELECT fiscal_period_nr,
 fiscal_period_name
FROM ldl_dig_lec_share.v_dim_fiscal_period
UNION ALL
SELECT ROUND(CAST('-1' AS BIGNUMERIC), 0) AS dm__operand0,
 '' AS dm__operand1;