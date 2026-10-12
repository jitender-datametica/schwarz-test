CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_gc_lc_1 AS SELECT *
FROM ldl_dig_fe_mstr_lidldigital.t_dim_gc_lc_1
UNION ALL
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1,
 '' AS dm__operand2;