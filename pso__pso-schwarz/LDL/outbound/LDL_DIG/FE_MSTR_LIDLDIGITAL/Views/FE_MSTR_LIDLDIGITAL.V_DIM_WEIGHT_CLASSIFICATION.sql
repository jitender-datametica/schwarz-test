CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_weight_classification AS SELECT CASE
  WHEN weight_class_cd = ''
  THEN '-1'
  ELSE IFNULL(weight_class_cd, '-1')
  END AS weight_class_cd,
 weight_class_descr
FROM ldl_dig_lec_share.v_dim_weight_classification
UNION ALL
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1;