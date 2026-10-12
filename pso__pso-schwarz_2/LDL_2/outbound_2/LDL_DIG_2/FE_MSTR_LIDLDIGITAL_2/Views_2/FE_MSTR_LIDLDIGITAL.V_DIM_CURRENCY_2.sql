CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_currency_2 (curr_cd, curr_name) AS SELECT curr_cd,
 curr_name
FROM ldl_dig_lec_share.v_dim_currency_2
UNION ALL
SELECT '-1',
 '';