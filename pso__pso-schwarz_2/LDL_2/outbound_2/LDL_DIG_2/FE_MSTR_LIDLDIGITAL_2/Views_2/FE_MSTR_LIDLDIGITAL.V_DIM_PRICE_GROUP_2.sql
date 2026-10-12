CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_price_group_2 (price_group_cd, price_group_descr) AS SELECT
 price_group_cd,
 price_group_descr
FROM ldl_dig_lec_share.v_dim_price_group_2
UNION ALL
SELECT '-1',
 '';