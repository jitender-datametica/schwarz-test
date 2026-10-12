CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_accounting_cost_type_1 AS SELECT TRIM(acct_cost_type_cd) AS
 acct_cost_type_cd,
 acct_cost_type_name_en,
 acct_cost_type_name_de
FROM ldl_dig_lec_share.v_dim_accounting_cost_type_1
UNION ALL
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1,
 '' AS dm__operand2;