
TRUNCATE TABLE ${dm_inferred_target_db}.${tgt_target_table};


-- FRAMEWORK AND TECHNICAL COLUMNS


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (tf_error_fg, dwh_load_id, deleted_fg, record_id,
 filename, source_system, extraction_dt, dwh_mapping_tmsp, ctrcode, itemno, itemno_wawi, prod_num)
(SELECT 0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${SRC_INPUT_TABLE}' AS filename,
  'WAWI' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  ii.ctrcode,
  eh.itemno,
  CAST(ii.itemnr AS INTEGER) AS itemnr,
  eh.prod_num
 FROM ((SELECT itemno_ba AS prod_num,
      itemno_ea AS itemno
     FROM ldl_data_production_etl.t_wawi_precore_eks_hierarchy_1
     UNION DISTINCT
     SELECT itemno_ba AS prod_num,
      itemno_sk AS itemno
     FROM ldl_data_production_etl.t_wawi_precore_eks_hierarchy_1)
    UNION DISTINCT
    SELECT itemno_ba AS prod_num,
     itemno_ba AS itemno
    FROM ldl_data_production_etl.t_wawi_precore_eks_hierarchy_1) AS eh
  INNER JOIN (SELECT DISTINCT LEFT(src.ctrcode, 2) AS ctrcode,
    ROUND(CAST(SUBSTR(src.c215_itemnr, 1, LENGTH(src.c215_itemnr) - 4) AS BIGNUMERIC), 0) AS itemnr,
    ROUND(CAST(src.c215_int_itemnr AS BIGNUMERIC), 0) AS itemno_int
   FROM ldl_data_production_etl.t_wawi_precore_t215_int_itemnr_1 AS src
    INNER JOIN ldl_data_production_etl.wawi_control_table_1 AS ctrl ON ctrl.source_table_name = UPPER('${TEMP_DB}.${SRC_INPUT_TABLE}'
        ) AND ctrl.source_status = 'A' AND src.extraction_tmsp BETWEEN ctrl.begin_tmsp AND ctrl.end_tmsp) AS ii ON eh.itemno
    = ii.itemno_int
  INNER JOIN ldl_data_production_etl.t_wawi_precore_t026_wawi_item_1 AS wi ON eh.prod_num = wi.itemno
 QUALIFY (DENSE_RANK() OVER (PARTITION BY eh.itemno ORDER BY wi.seqid IS NULL DESC, wi.seqid DESC)) = 1);