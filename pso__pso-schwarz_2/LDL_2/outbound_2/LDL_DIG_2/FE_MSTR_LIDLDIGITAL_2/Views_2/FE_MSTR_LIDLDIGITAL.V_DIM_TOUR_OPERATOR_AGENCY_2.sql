CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_tour_operator_agency_2 (tour_operator_agency_cd, tour_operator_cd
) AS SELECT tour_operator_agency_cd,
  CASE
  WHEN tour_operator_cd = ''
  THEN '-1'
  ELSE IFNULL(tour_operator_cd, '-1')
  END AS tour_operator_cd
FROM ldl_dig_lec_share.v_dim_tour_operator_agency_2
UNION ALL
SELECT '-1',
 '-1';