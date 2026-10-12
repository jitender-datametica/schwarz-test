
TRUNCATE TABLE ${dm_inferred_target_db}.${tgt_target_table};


-- for CROSS JOIN & int_org lkp & inv_key lkp & country_org lkp
-- for CROSS JOIN & inv_key lkp
-- for CROSS JOIN & inv_key lkp
-- inv mapping
-- int_org lkp
--inv mapping
--inv mapping
--stat mapping
--stat mapping
--stat mapping


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_{src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, source_system, extraction_dt, dwh_mapping_tmsp, country_org_key_type_cd, int_org_key_type_cd,
 int_org_natural_key, country_org_natural_key, ctrcode, c182_turnoverval_net, c182_diffval_net, c182_inventoryval_net,
 inv_key_type_cd, inv_natural_key, wh_nr, extraction_tmsp, c180_id, c180_inventorydate, c180_storenr, c182_datefrom,
 c182_dateuntil)
(SELECT 'WAWI_WH' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${t_SRC_INPUT_TABLE}' AS filename,
  'WAWI_WH' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CAST(NULL AS TIMESTAMP) AS dwh_mapping_tmsp,
  'COUNTRY' AS country_org_key_type_cd,
  'STORE' AS int_org_key_type_cd,
    t180.ctrcode || '|' || CAST(t180.c180_storenr AS STRING) AS int_org_natural_key,
  t180.ctrcode AS country_org_natural_key,
  t180.ctrcode,
  t182.c182_turnoverval_net,
  t182.c182_diffval_net,
  t182.c182_inventoryval_net,
  'FULL' AS inv_key_type_cd,
      t180.ctrcode || '|' || CAST(t180.wh_nr AS STRING) || '|' || CAST(t180.c180_id AS STRING) AS inv_natural_key,
  t180.wh_nr,
  t180.extraction_tmsp,
  t180.c180_id,
  t180.c180_inventorydate,
  t180.c180_storenr,
  t182.c182_datefrom,
  t182.c182_dateuntil
 FROM ldl_data_production_etl_process.t_wawi_precore_t180_stinventory_snap AS t180
  INNER JOIN ldl_data_production_etl_process.t_wawi_precore_t182_sic_inventory_snap AS t182 ON t180.ctrcode = t182.ctrcode
      AND t180.wh_nr = t182.wh_nr AND t180.c180_id = t182.c182_id
 WHERE t180.c180_inv_flag = 71
  AND t182.c182_status = 64);