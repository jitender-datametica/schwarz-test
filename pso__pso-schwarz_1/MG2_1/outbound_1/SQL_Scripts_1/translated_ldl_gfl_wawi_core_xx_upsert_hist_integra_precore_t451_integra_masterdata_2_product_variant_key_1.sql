
-- FRAMEWORK AND TECHNICAL COLUMNS


/* !!!Without Negative-Key-Capture!!!
                                              Key must already exist after the T_PRODUCT_VARIANT_1 (FV_SLS_UNK) job. */


/* !!!Without Negative-Key-Capture!!!
                                              Key must already exist after the T_PRODUCT_VARIANT_1 (FV_SLS_UNK) job. */


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, prod_variant_key_type_cd, source_system, extraction_dt, dwh_mapping_tmsp, prod_variant_sid,
 prod_variant_nat_key_nr)
(SELECT dwh_node_cd,
  tf_error_fg,
  dwh_load_id,
   deleted_fg <> 0 AS deleted_fg,
  CAST(record_id AS STRING) AS record_id,
  filename,
  prod_variant_key_type_cd,
  source_system,
  CAST(extraction_dt AS DATE) AS extraction_dt,
  dwh_mapping_tmsp,
  prod_variant_sid,
  prod_variant_nat_key_nr
 FROM (SELECT DISTINCT vkey.prod_variant_sid,
     'SLS_UNK' AS prod_variant_key_type_cd,
       src.ctrcode || '|' || CAST(src.itemnr AS STRING) AS prod_variant_nat_key_nr,
     'FV' AS source_system,
     CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
     src.extraction_tmsp AS extraction_dt,
     0 AS tf_error_fg,
     0 AS deleted_fg,
     0 AS record_id,
     '${t_SRC_INPUT_TABLE}' AS filename,
     'WAWI_WH' AS dwh_node_cd,
     '${LOAD_ID}' AS dwh_load_id
    FROM (SELECT CAST(itemnr.itemnr AS STRING) AS prod_nr,
       iit.ctrcode,
       iit.itemnr,
       iit.extraction_tmsp
      FROM (SELECT itemnr
         FROM (SELECT ROUND(CAST(c451_itemnr AS BIGNUMERIC), 0) AS itemnr,
            c451_subitemnr
           FROM ldl_data_production_etl.t_integra_precore_t451_integra_masterdata_1
           GROUP BY itemnr,
            c451_subitemnr) AS t0
         GROUP BY itemnr
         HAVING COUNT(*) > 1
         UNION ALL
         SELECT itemno
         FROM ldl_data_production_etl.t_wawi_precore_t026_wawi_item_1
         WHERE CAST(itemgrshortdesc AS INTEGER) BETWEEN 10 AND 13
          AND itemno NOT IN (SELECT DISTINCT ROUND(CAST(c451_itemnr AS BIGNUMERIC), 0) AS itemnr
            FROM ldl_data_production_etl.t_integra_precore_t451_integra_masterdata_1)) AS itemnr
       INNER JOIN (SELECT ctrcode,
         CAST(SUBSTR(c215_itemnr, 1, LENGTH(c215_itemnr) - 4) AS BIGNUMERIC) AS itemnr,
         CAST(c215_int_itemnr AS BIGNUMERIC) AS c215_int_itemnr,
         MIN(extraction_tmsp) AS extraction_tmsp,
         MAX(c215_active) AS active_fg
        FROM ldl_data_production_etl.t_wawi_precore_t215_int_itemnr_1
        GROUP BY ctrcode,
         itemnr,
         c215_int_itemnr
        QUALIFY (ROW_NUMBER() OVER (PARTITION BY ctrcode, CAST(itemnr AS STRING) ORDER BY CASE
               WHEN active_fg = 1
               THEN 1
               ELSE 2
               END IS NULL, CASE
               WHEN active_fg = 1
               THEN 1
               ELSE 2
               END, c215_int_itemnr IS NULL, c215_int_itemnr)) = 1) AS iit ON itemnr.itemnr = iit.c215_int_itemnr) AS
     src
     INNER JOIN ldl_data_production_meta.t_product_variant_key_1 AS vkey ON src.prod_nr = vkey.prod_variant_nat_key_nr AND
       vkey.dwh_valid_fg AND vkey.prod_variant_key_type_cd = 'FV_SLS_UNK'
    UNION ALL
    SELECT DISTINCT vkey.prod_variant_sid,
     'SLS_UNK' AS prod_variant_key_type_cd,
       src.ctrcode || '|' || CAST(src.itemnr AS STRING) AS prod_variant_nat_key_nr,
     'FV' AS source_system,
     src.extraction_tmsp AS extraction_dt,
     CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
     0 AS tf_error_fg,
     0 AS deleted_fg,
     0 AS record_id,
     '${t_SRC_INPUT_TABLE}' AS filename,
     'WAWI_WH' AS dwh_node_cd,
     '${LOAD_ID}' AS dwh_load_id
    FROM (SELECT CAST(itemnr0.itemnr AS STRING) || '|' || CAST(itemnr0.subitemnr AS STRING) AS prod_variant_nat_key_nr,
       iit.ctrcode,
       iit.itemnr,
       iit.extraction_tmsp
      FROM (SELECT itemnr,
         MIN(c451_subitemnr) AS subitemnr
        FROM (SELECT ROUND(CAST(c451_itemnr AS BIGNUMERIC), 0) AS itemnr,
           c451_subitemnr
          FROM ldl_data_production_etl.t_integra_precore_t451_integra_masterdata_1
          GROUP BY itemnr,
           c451_subitemnr) AS t16
        GROUP BY itemnr
        HAVING COUNT(*) = 1) AS itemnr0
       INNER JOIN (SELECT ctrcode,
         CAST(SUBSTR(c215_itemnr, 1, LENGTH(c215_itemnr) - 4) AS BIGNUMERIC) AS itemnr,
         CAST(c215_int_itemnr AS BIGNUMERIC) AS c215_int_itemnr,
         MIN(extraction_tmsp) AS extraction_tmsp,
         MAX(c215_active) AS active_fg
        FROM ldl_data_production_etl.t_wawi_precore_t215_int_itemnr_1
        GROUP BY ctrcode,
         itemnr,
         c215_int_itemnr
        QUALIFY (ROW_NUMBER() OVER (PARTITION BY ctrcode, CAST(itemnr AS STRING) ORDER BY CASE
               WHEN active_fg = 1
               THEN 1
               ELSE 2
               END IS NULL, CASE
               WHEN active_fg = 1
               THEN 1
               ELSE 2
               END, c215_int_itemnr IS NULL, c215_int_itemnr)) = 1) AS iit ON itemnr0.itemnr = iit.c215_int_itemnr) AS
     src
     INNER JOIN ldl_data_production_meta.t_product_variant_key_1 AS vkey ON src.prod_variant_nat_key_nr = vkey.prod_variant_nat_key_nr
         AND vkey.dwh_valid_fg AND vkey.prod_variant_key_type_cd = 'FV_SLS') AS t26);