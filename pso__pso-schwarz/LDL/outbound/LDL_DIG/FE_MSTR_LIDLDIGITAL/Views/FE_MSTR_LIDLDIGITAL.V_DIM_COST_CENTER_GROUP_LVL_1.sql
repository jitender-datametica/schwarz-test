CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_cost_center_group_lvl_1 AS SELECT cc_group_lvl1_nr,
  CASE
  WHEN ctrl_area_cd = ''
  THEN '-1'
  ELSE IFNULL(ctrl_area_cd, '-1')
  END AS ctrl_area_cd,
 cc_group_lvl1_name_en,
 cc_group_lvl1_name_de
FROM ldl_dig_lec_share.v_dim_cost_center_group_lvl_1
UNION ALL
SELECT '-1' AS dm__operand0,
 '-1' AS dm__operand1,
 '' AS dm__operand2,
 '' AS dm__operand3;