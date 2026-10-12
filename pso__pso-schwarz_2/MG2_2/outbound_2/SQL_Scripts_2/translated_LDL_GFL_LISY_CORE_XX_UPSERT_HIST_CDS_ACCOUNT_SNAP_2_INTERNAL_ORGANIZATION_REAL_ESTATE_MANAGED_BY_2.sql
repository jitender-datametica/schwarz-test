
INSERT INTO ldl_data_production_etl.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id
 , source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename, real_estate_nk,
 real_estate_key_type_cd, int_org_real_estate_usg_type_cd, int_org_key_type_cd, int_org_nk)
(SELECT 'LISY' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  'LISY' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CAST(IFNULL((SELECT MIN(t)
     FROM UNNEST(ARRAY[bld_src.igl_contractdate, bld_src.igl_precontractdate]) AS t), bld_src.sinkmodifiedon) AS TIMESTAMP)
  AS dwh_mapping_tmsp,
  't_tcache_lisy_cds_account_snap_2' AS filename,
    LOWER(SUBSTR(bld_src.igl_number, 1, 2)) || '|' || CAST(ROUND(CAST(SUBSTR(bld_src.igl_number, 3, 5) AS BIGNUMERIC), 0
     ) AS STRING) AS real_estate_nk,
  'RE_2' AS real_estate_key_type_cd,
  'MANAGED_BY' AS int_org_real_estate_usg_type_cd,
  'COMPANY' AS int_org_key_type_cd,
    SUBSTR(comp_src.igl_associationnumber, 1, 2) || '|' || CAST(ROUND(CAST(REGEXP_REPLACE(comp_src.igl_associationnumber, '[^0-9]', '') AS BIGNUMERIC)
     , 0) AS STRING) AS int_org_nk
 FROM ldl_data_production_etl_process.${t_src_input_table} AS bld_src
  INNER JOIN ldl_data_production_meta.t_resource_item_key_2 AS bld_key ON bld_key.resource_item_nat_key_nr = UPPER(SUBSTR(bld_src
        .igl_number, 1, 2)) || '|' || CAST(ROUND(CAST(SUBSTR(bld_src.igl_number, 3, 5) AS BIGNUMERIC), 0) AS STRING) AND
    bld_key.resource_item_key_type_cd = 'RE_2'
  INNER JOIN ldl_data_production_etl_process.t_tcache_lisy_cds_company_snap_2 AS comp_src ON bld_src.igl_expassocid =
   comp_src.id);