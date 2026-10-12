CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_controlling_area AS SELECT ctrl_area_cd,
 ctrl_area_descr
FROM ldl_dig_lec_share.v_dim_controlling_area
UNION ALL
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1;