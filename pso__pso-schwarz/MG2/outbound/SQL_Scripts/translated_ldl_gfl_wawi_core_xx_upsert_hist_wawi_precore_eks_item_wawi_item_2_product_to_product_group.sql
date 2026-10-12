
--Extraction/Filter Logic:



-- FRAMEWORK AND TECHNICAL COLUMNS


-- FRAMEWORK AND TECHNICAL COLUMNS


/*EA*/


/*SK*/


/*BA*/


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, source_system, extraction_dt, prod_nr, dwh_mapping_tmsp, prod_key_type_cd, prod_grp_type_cd,
 prod_grp_key_type_cd, prod_grp_nr)
(SELECT 'WAWI_HQ' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${SRC_INPUT_TABLE}' AS filename,
  'WAWI' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CAST(prod_num AS STRING) AS prod_nr,
  CAST(extraction_tmsp AS TIMESTAMP) AS dwh_mapping_tmsp,
  'EKS' AS prod_key_type_cd,
  'IFG' AS prod_grp_type_cd,
  'IFG' AS prod_grp_key_type_cd,
  CONCAT(uwgnr, '|', fgnr) AS prod_grp_nr
 FROM (WITH eks_item AS (SELECT itemno,
       itemgrshortdesc AS uwgnr,
       itemgroupid AS fgnr,
        CASE
        WHEN bitflag = 0
        THEN 1
        WHEN bitflag = 4
        THEN 2
        WHEN bitflag = 2
        THEN 3
        ELSE NULL
        END AS level,
       extraction_tmsp
      FROM ldl_data_production_etl.t_wawi_precore_t026_wawi_item) (SELECT prod_num,
       extraction_tmsp,
        CASE
        WHEN uwgnr || '|' || CAST(fgnr AS STRING) IS NOT NULL
        THEN uwgnr
        ELSE uwgnr0
        END AS uwgnr,
        CASE
        WHEN uwgnr || '|' || CAST(fgnr AS STRING) IS NOT NULL
        THEN fgnr
        ELSE fgnr0
        END AS fgnr
      FROM (SELECT *
        FROM (SELECT itemno_ba AS prod_num,
            itemno_sk AS itemno
           FROM ldl_data_production_etl.t_wawi_precore_eks_hierarchy
           UNION DISTINCT
           SELECT itemno_ba AS prod_num,
            itemno_ea AS itemno
           FROM ldl_data_production_etl.t_wawi_precore_eks_hierarchy) AS eks
         INNER JOIN eks_item AS eksp ON eks.prod_num = eksp.itemno
         INNER JOIN eks_item AS eksi ON eks.itemno = eksi.itemno
        QUALIFY (ROW_NUMBER() OVER (PARTITION BY eks.prod_num ORDER BY CASE
               WHEN eksp.uwgnr || '|' || CAST(eksp.fgnr AS STRING) IS NOT NULL
               THEN 1
               ELSE 2
               END IS NULL, CASE
               WHEN eksp.uwgnr || '|' || CAST(eksp.fgnr AS STRING) IS NOT NULL
               THEN 1
               ELSE 2
               END, CASE
               WHEN eksi.uwgnr || '|' || CAST(eksi.fgnr AS STRING) IS NOT NULL
               THEN 1
               ELSE 2
               END IS NULL, CASE
               WHEN eksi.uwgnr || '|' || CAST(eksi.fgnr AS STRING) IS NOT NULL
               THEN 1
               ELSE 2
               END, eksi.level IS NULL DESC, eksi.level DESC)) = 1) AS t4
      WHERE CASE
        WHEN t4.uwgnr || '|' || CAST(t4.fgnr AS STRING) IS NOT NULL
        THEN t4.uwgnr
        ELSE t4.uwgnr0
        END IS NOT NULL
       AND CASE
        WHEN t4.uwgnr || '|' || CAST(t4.fgnr AS STRING) IS NOT NULL
        THEN t4.fgnr
        ELSE t4.fgnr0
        END IS NOT NULL)));