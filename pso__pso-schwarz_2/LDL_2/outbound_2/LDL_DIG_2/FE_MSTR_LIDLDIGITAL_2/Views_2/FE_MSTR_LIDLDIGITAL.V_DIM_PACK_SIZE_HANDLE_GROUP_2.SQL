CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_pack_size_handle_group_2 (pack_size_handle_group_cd,
pack_size_handle_group_descr) AS SELECT pack_size_handle_group_cd,
 pack_size_handle_group_descr
FROM ldl_dig_lec_share.v_dim_pack_size_handle_group_2
UNION ALL
SELECT '-1',
 '';