INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  prod_grp_key_type_cd,
  prod_grp_key_nr,
  prod_grp_type_cd,
  prod_grp_nr,
  prod_grp_name,
  prod_container_type_cd,
  prod_container_class_cd,
  prod_container_assort_area_cd,
  prod_container_size_cd,
  country_org_sid,
  source_system,
  extraction_dt,
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename,
  dwh_node_cd,
  dwh_load_id
)
SELECT
  'Container' AS prod_grp_key_type_cd, /* framework and technical columns */
  CONCAT(c1041_country, '|', c1041_cont_id_local) AS prod_grp_key_nr,
  'PC' AS prod_grp_type_cd,
  c1041_cont_id_local AS prod_grp_nr,
  c1041_desc_nat AS prod_grp_name,
  CASE WHEN c1041_desc_int = 'INT' THEN 'INT' ELSE 'LOC' END AS prod_container_type_cd,
  CASE
    WHEN bqutil.fn.cw_split_part_delimstr_idx(c1041_desc_int, ' ', 1) IN ('MC', 'FC', 'TC')
    THEN bqutil.fn.cw_split_part_delimstr_idx(c1041_desc_int, ' ', 1)
    ELSE NULL
  END AS prod_container_class_cd,
  CONCAT(c1041_country, '|', c1041_cont_id_local) AS prod_container_assort_area_cd,
  CASE
    WHEN bqutil.fn.cw_split_part_delimstr_idx(c1041_desc_int, ' ', -1) IN ('XS', 'S', 'M', 'L', 'XXS', 'XXL')
    THEN bqutil.fn.cw_split_part_delimstr_idx(c1041_desc_int, ' ', -1)
    ELSE NULL
  END AS prod_container_size_cd,
  party_sid AS country_org_sid,
  'WAWI' AS source_system,
  CURRENT_DATE AS extraction_dt,
  extraction_tmsp AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  't_${SRC_INPUT_TABLE}' AS filename,
  'WAWI_HQ' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
FROM ${ldl_wawi_common_snflk_cl_db_name}.${src_input_table} AS src
LEFT OUTER JOIN meta.t_party_key_1 AS p
  ON party_key_type_cd = 'COUNTRY_1'
  AND party_nat_key_nr = c1041_country
  AND dwh_valid_fg
WHERE
  c1041_status = '1'
QUALIFY
  row_number() OVER (
    PARTITION BY c1041_country, c1041_cont_id_local
    ORDER BY IF(c1041_moddate IS NULL, 0, 1), c1041_moddate DESC
  ) = 1;