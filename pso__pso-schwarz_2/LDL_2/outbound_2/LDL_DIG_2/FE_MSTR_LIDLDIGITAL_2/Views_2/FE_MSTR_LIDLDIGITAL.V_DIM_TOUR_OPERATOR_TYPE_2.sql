CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_tour_operator_type_2 (tour_operator_type_cd,
tour_operator_type_descr) AS SELECT tour_operator_type_cd,
 tour_operator_type_descr
FROM ldl_dig_lec_share.v_dim_tour_operator_type_2
UNION ALL
SELECT '-1',
 '';