CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_cost_element_group_lvl_3_2 AS SELECT ce_group_lvl3_nr,
 ce_group_lvl3_name_en,
 ce_group_lvl3_name_de,
  CASE
  WHEN ce_group_lvl2_nr = ''
  THEN '-1'
  ELSE IFNULL(ce_group_lvl2_nr, '-1')
  END AS ce_group_lvl2_nr,
 ce_group_lvl2_name_en,
 ce_group_lvl2_name_de,
  CASE
  WHEN ce_group_lvl1_nr = ''
  THEN '-1'
  ELSE IFNULL(ce_group_lvl1_nr, '-1')
  END AS ce_group_lvl1_nr,
 ce_group_lvl1_name_en,
 ce_group_lvl1_name_de
FROM ldl_dig_lec_share.v_dim_cost_element_group_lvl_3_2
UNION ALL
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1,
 '' AS dm__operand2,
 '-1' AS dm__operand3,
 '' AS dm__operand4,
 '' AS dm__operand5,
 '-1' AS dm__operand6,
 '' AS dm__operand7,
 '' AS dm__operand8;