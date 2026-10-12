CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_business_event_type_1 AS SELECT CASE
  WHEN business_event_type_cd = ''
  THEN '-1'
  ELSE IFNULL(business_event_type_cd, '-1')
  END AS business_event_type_cd,
 business_event_type_descr
FROM ldl_dig_lec_share.v_dim_business_event_type_1
UNION ALL
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1;