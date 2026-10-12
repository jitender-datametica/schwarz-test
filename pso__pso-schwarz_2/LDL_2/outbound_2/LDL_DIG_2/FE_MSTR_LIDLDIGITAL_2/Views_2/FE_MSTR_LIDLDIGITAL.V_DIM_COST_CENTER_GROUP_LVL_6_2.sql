CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_cost_center_group_lvl_6_2 AS SELECT cc_group_lvl6_nr,
  CASE
  WHEN ctrl_area_cd = ''
  THEN '-1'
  ELSE IFNULL(ctrl_area_cd, '-1')
  END AS ctrl_area_cd,
 cc_group_lvl6_name_en,
 cc_group_lvl6_name_de,
  CASE
  WHEN cc_group_lvl5_nr = ''
  THEN '-1'
  ELSE IFNULL(cc_group_lvl5_nr, '-1')
  END AS cc_group_lvl5_nr,
 cc_group_lvl5_name_en,
 cc_group_lvl5_name_de,
  CASE
  WHEN cc_group_lvl4_nr = ''
  THEN '-1'
  ELSE IFNULL(cc_group_lvl4_nr, '-1')
  END AS cc_group_lvl4_nr,
 cc_group_lvl4_name_en,
 cc_group_lvl4_name_de,
  CASE
  WHEN cc_group_lvl3_nr = ''
  THEN '-1'
  ELSE IFNULL(cc_group_lvl3_nr, '-1')
  END AS cc_group_lvl3_nr,
 cc_group_lvl3_name_en,
 cc_group_lvl3_name_de,
  CASE
  WHEN cc_group_lvl2_nr = ''
  THEN '-1'
  ELSE IFNULL(cc_group_lvl2_nr, '-1')
  END AS cc_group_lvl2_nr,
 cc_group_lvl2_name_en,
 cc_group_lvl2_name_de,
  CASE
  WHEN cc_group_lvl1_nr = ''
  THEN '-1'
  ELSE IFNULL(cc_group_lvl1_nr, '-1')
  END AS cc_group_lvl1_nr,
 cc_group_lvl1_name_en,
 cc_group_lvl1_name_de
FROM ldl_dig_lec_share.v_dim_cost_center_group_lvl_6_2
UNION ALL
SELECT '-1' AS dm__operand0,
 '-1' AS dm__operand1,
 '' AS dm__operand2,
 '' AS dm__operand3,
 '-1' AS dm__operand4,
 '' AS dm__operand5,
 '' AS dm__operand6,
 '-1' AS dm__operand7,
 '' AS dm__operand8,
 '' AS dm__operand9,
 '-1' AS dm__operand10,
 '' AS dm__operand11,
 '' AS dm__operand12,
 '-1' AS dm__operand13,
 '' AS dm__operand14,
 '' AS dm__operand15,
 '-1' AS dm__operand16,
 '' AS dm__operand17,
 '' AS dm__operand18;