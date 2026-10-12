CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_material_position_type_2 (material_pos_type_cd,
material_pos_type_descr) AS SELECT material_pos_type_cd,
 material_pos_type_descr
FROM ldl_dig_lec_share.v_dim_material_position_type_2
UNION ALL
SELECT '-1',
 '';