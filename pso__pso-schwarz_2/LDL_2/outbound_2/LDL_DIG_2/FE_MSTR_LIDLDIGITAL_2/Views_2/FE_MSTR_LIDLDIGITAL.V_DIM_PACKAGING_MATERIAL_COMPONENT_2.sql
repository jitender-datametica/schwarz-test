CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_packaging_material_component_2 (pack_material_nr,
pack_compos_group_name, pack_compos_type_name, ldpcr_compos_kg, ldpe_compos_kg, pp_compos_kg, pe_compos_kg,
thermo_eco_compos_kg, paper_compos_kg, corrugated_cardboard_kg) AS SELECT pack_material_nr,
 pack_compos_group_name,
 pack_compos_type_name,
 ldpcr_compos_kg,
 ldpe_compos_kg,
 pp_compos_kg,
 pe_compos_kg,
 thermo_eco_compos_kg,
 paper_compos_kg,
 corrugated_cardboard_kg
FROM ldl_dig_lec_share.v_dim_packaging_material_component_2
WHERE dwh_valid_fg
UNION ALL
SELECT '-1',
 '',
 '',
 ROUND(CAST('0' AS BIGNUMERIC), 5),
 ROUND(CAST('0' AS BIGNUMERIC), 5),
 ROUND(CAST('0' AS BIGNUMERIC), 5),
 ROUND(CAST('0' AS BIGNUMERIC), 5),
 ROUND(CAST('0' AS BIGNUMERIC), 5),
 ROUND(CAST('0' AS BIGNUMERIC), 5),
 ROUND(CAST('0' AS BIGNUMERIC), 5);