
TRUNCATE TABLE ${dm_inferred_target_db}.${tgt_target_table};


-- FRAMEWORK AND TECHNICAL COLUMNS


/*EA no parent*/


/*BA*/


/*BA*/


/*EA*/


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (tf_error_fg, dwh_load_id, deleted_fg, record_id,
 filename, source_system, extraction_dt, dwh_mapping_tmsp, itemno_ba, itemno_sk, itemno_ea)
(SELECT 0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${SRC_INPUT_TABLE}' AS filename,
  'WAWI' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
   CASE
   WHEN t4.itemno_2 IS NULL AND t4.itemno_3 IS NULL
   THEN t4.itemno_1
   WHEN t4.itemno_3 IS NULL
   THEN t4.itemno_2
   ELSE t4.itemno_3
   END AS itemno_ba,
   CASE
   WHEN t4.itemno_3 IS NULL
   THEN t4.itemno_1
   ELSE t4.itemno_2
   END AS itemno_sk,
  t4.itemno_1 AS itemno_ea
 FROM (SELECT DISTINCT i1.itemno AS itemno_1,
    d1.level_detail AS level_1,
    i2.itemno AS itemno_2,
    d1.level_head AS level_2,
    i3.itemno AS itemno_3,
    d2.level_head AS level_3,
     CASE
     WHEN dx.itemno_detail IS NULL
     THEN i1.itemno
     WHEN d1.level_head = 3
     THEN i2.itemno
     WHEN d2.level_head = 3
     THEN i3.itemno
     ELSE NULL
     END AS prod_num
   FROM ldl_data_production_etl.t_wawi_precore_t026_wawi_item AS i1
    LEFT JOIN ldl_data_production_etl.t_wawi_precore_t024_wawi_item_dep AS d1 ON i1.itemno = d1.itemno_detail
    LEFT JOIN ldl_data_production_etl.t_wawi_precore_t026_wawi_item AS i2 ON d1.itemno_head = i2.itemno
    LEFT JOIN ldl_data_production_etl.t_wawi_precore_t024_wawi_item_dep AS d2 ON i2.itemno = d2.itemno_detail
    LEFT JOIN ldl_data_production_etl.t_wawi_precore_t026_wawi_item AS i3 ON d2.itemno_head = i3.itemno
    LEFT JOIN (SELECT DISTINCT itemno_detail
     FROM ldl_data_production_etl.t_wawi_precore_t024_wawi_item_dep) AS dx ON i1.itemno = dx.itemno_detail
   WHERE i1.bitflag IN (0)
    AND (CAST(i1.itemgrshortdesc AS INTEGER) BETWEEN 20 AND 99 OR CAST(i2.itemgrshortdesc AS INTEGER) BETWEEN 20 AND 99
      OR CAST(i3.itemgrshortdesc AS INTEGER) BETWEEN 20 AND 99)
    AND CASE
     WHEN dx.itemno_detail IS NULL
     THEN i1.itemno
     WHEN d1.level_head = 3
     THEN i2.itemno
     WHEN d2.level_head = 3
     THEN i3.itemno
     ELSE NULL
     END IS NOT NULL) AS t4);