CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_tour_operator_1 (tour_operator_cd, tour_operator_name,
tour_operator_type_cd, tour_operator_contract_type_cd) AS SELECT tour_operator_cd,
 tour_operator_name,
  CASE
  WHEN tour_operator_type_cd = ''
  THEN '-1'
  ELSE IFNULL(tour_operator_type_cd, '-1')
  END AS tour_operator_type_cd,
  CASE
  WHEN tour_operator_contract_type_cd = ''
  THEN '-1'
  ELSE IFNULL(tour_operator_contract_type_cd, '-1')
  END AS tour_operator_contract_type_cd
FROM ldl_dig_lec_share.v_dim_tour_operator_1
UNION ALL
SELECT '-1',
 '',
 '-1',
 '-1';