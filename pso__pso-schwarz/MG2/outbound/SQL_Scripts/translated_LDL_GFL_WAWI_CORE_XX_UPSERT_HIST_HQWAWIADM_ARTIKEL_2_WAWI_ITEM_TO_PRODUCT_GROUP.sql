
/*
CREATE OR REPLACE TEMPORARY TABLE ${TEMP_DB}.T_WAWI_PRECORE_ITEM_TEMP AS 
(
SELECT CASE WHEN a.wawi_instanz_kzl='CS' THEN 'ES' ELSE LEFT(a.wawi_instanz_kzl,2) END AS COUNTRY, CAST(artnrvier AS Number) AS itemnr,
 
a.* , min_gueltig_ab
    FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.artikel AS a
INNER JOIN ETL.WAWI_ITEMS_WITH_DELETION_RANGE b on a.delete_fg IS NULL AND LEFT(a.wawi_instanz_kzl,2)=b.wawi_instanz_kzl and itemnr=b.orig_item_nr and b.wawi_item_deleted_dt='9999-12-31' --filter to pick only the correct ES/CS items
        QUALIFY Row_Number() OVER (PARTITION BY COUNTRY, itemnr ORDER BY  artikelnr ASC, extraction_tmsp DESC ) = 1 --pick the latest data. The sorting by artikelnr is for the code to always pick the same item variant
)
;
*/




-- FRAMEWORK AND TECHNICAL COLUMNS


/* Collect data on item variant level and deduplicate for item in the last step */


/* prefer ES before CS */


/* Could be simplified later */


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, source_system, extraction_dt, dwh_mapping_tmsp, wawi_item_sid, prod_grp_sid, prod_grp_type_cd)
(SELECT 'WAWI_HQ' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${t_SRC_INPUT_TABLE}' AS filename,
  'WAWI' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CAST(src.extraction_tmsp AS TIMESTAMP) AS dwh_mapping_tmsp,
  ik.wawi_item_sid,
  pgk.prod_grp_sid,
  'IFG' AS prod_grp_type_cd
 FROM (SELECT CASE
     WHEN art.wawi_instanz_kzl = 'CS'
     THEN 'ES'
     ELSE LEFT(art.wawi_instanz_kzl, 2)
     END AS country,
    ROUND(SAFE_CAST(art.artnrvier AS BIGNUMERIC), 0) AS itemnr,
    art.extraction_tmsp,
    itma.c214_family_id AS itemgrpnr,
    fg.wawi_instanz_kzl AS family_code
   FROM hqwawiadm.artikel AS art
    INNER JOIN whwawiadm.t214_itemaddinfo AS itma ON art.wawi_instanz_kzl = art.bez_lang AND art.artikelnr = art.deutschtext
      
    INNER JOIN hqwawiadm.t038_itemfamily AS fg ON art.bez_lang = itma.delete_fg AND itma.c214_itemnr = fg.c038_family_code
      
   WHERE art.delete_fg IS NULL
    AND itma.wawi_instanz_kzl IS NULL
    AND fg.c038_itemgrpnr IS NULL
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY country, CAST(itemnr AS STRING) ORDER BY art.wawi_instanz_kzl IS NULL DESC,
         art.wawi_instanz_kzl DESC, art.gueltig_ab IS NULL DESC, art.gueltig_ab DESC, art.inhalt_karton IS NULL, art.inhalt_karton
         , art.extraction_tmsp IS NULL DESC, art.extraction_tmsp DESC)) = 1) AS src
  INNER JOIN ldl_data_production_meta.t_wawi_item_key AS ik ON ik.wawi_item_nat_key_nr = src.country || '|' || CAST(src.itemnr AS STRING)
       AND ik.wawi_item_key_type_cd = 'WAWI' AND ik.dwh_valid_fg
  INNER JOIN ldl_data_production_meta.t_product_group_key AS pgk ON pgk.prod_grp_key_type_cd = 'IFG' AND CAST(ROUND(SAFE_CAST(CASE
           WHEN pgk.prod_grp_nat_key_nr IS NOT NULL
           THEN IFNULL(SPLIT(pgk.prod_grp_nat_key_nr, '|')[SAFE_OFFSET(0)], '')
           ELSE NULL
           END AS BIGNUMERIC), 0) AS STRING) || '|' || CAST(ROUND(SAFE_CAST(CASE
          WHEN pgk.prod_grp_nat_key_nr IS NOT NULL
          THEN IFNULL(SPLIT(pgk.prod_grp_nat_key_nr, '|')[SAFE_OFFSET(1)], '')
          ELSE NULL
          END AS BIGNUMERIC), 0) AS STRING) = CAST(CAST(src.itemgrpnr AS BIGNUMERIC) AS STRING) || '|' || CAST(CAST(src.family_code AS BIGNUMERIC)
       AS STRING) AND pgk.dwh_valid_fg);