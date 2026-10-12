CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_accounted_module AS SELECT accounted_module_cd,
 module_name_en,
 module_name_de
FROM ldl_dig_lec_share.v_dim_accounted_module
UNION ALL
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1,
 '' AS dm__operand2;