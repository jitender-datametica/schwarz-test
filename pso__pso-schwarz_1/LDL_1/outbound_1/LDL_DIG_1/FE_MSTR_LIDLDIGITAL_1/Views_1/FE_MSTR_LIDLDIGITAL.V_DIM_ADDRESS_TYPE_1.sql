CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_address_type_1 (addr_type_cd, addr_type_descr) AS SELECT
 addr_type_cd,
 addr_type_descr
FROM ldl_dig_lec_share.v_dim_address_type_1
UNION ALL
SELECT '-1',
 '';