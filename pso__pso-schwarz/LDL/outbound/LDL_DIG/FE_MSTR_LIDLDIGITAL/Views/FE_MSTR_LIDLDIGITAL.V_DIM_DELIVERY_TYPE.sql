CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_delivery_type (delivery_type_cd, delivery_type_descr) AS SELECT
 delivery_type_cd,
 delivery_type_descr
FROM ldl_dig_lec_share.v_dim_delivery_type
UNION ALL
SELECT '-1',
 '';