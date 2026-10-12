CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_cm.v_lil_compare_delv_deadline_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
SELECT REGION.region_id AS client_id,
 PERMSTR.period_id AS per_id,
 REG.interface_name,
 PER.end_dt AS per_end_date,
 REG.status_2,
 con.src_assort_parent_cat_cd AS delivery_content,
 COALESCE(CASE
   WHEN con.src_assort_parent_cat_cd = '00'
   THEN NADE.trans_text
   ELSE NULL
   END, TRIM(ACATM.assort_parnt_cat_name_de), con.src_assort_parent_cat_cd) AS delivery_content_smart_desc,
 COALESCE(CASE
   WHEN con.src_assort_parent_cat_cd = '00'
   THEN NAEN.trans_text
   ELSE NULL
   END, TRIM(ACATM.assort_parnt_cat_name_en), con.src_assort_parent_cat_cd) AS delivery_content_smart_desc_en,
 DATE(MIN(REG.processing_ts)) AS min_delivery_date,
 DATE(MAX(REG.processing_ts)) AS max_delivery_date,
 COUNT(DISTINCT con.file_id) AS delivery_count
FROM (SELECT C.file_id,
   C.region_sid,
   C.client_id,
   P.period_lvl,
   C.src_assort_parent_cat_cd,
   MAX(P.period_id) AS period_id
  FROM ldl_p_lew_process_mstr_ac.v_lil_file_content_2 AS C
   INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_period_2 AS P ON C.period_sid = P.period_sid
  GROUP BY C.file_id,
   C.region_sid,
   P.period_lvl,
   C.client_id,
   C.src_assort_parent_cat_cd) AS con
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_registry_files_2 AS REG ON con.file_id = REG.file_id
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_region_2 AS REGION_2 ON con.region_sid = REGION.region_sid
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_period_2 AS PERMSTR ON con.period_id = PERMSTR.period_id AND con.client_id =
   PERMSTR.client_id
 INNER JOIN ldl_p_lew_core_ac.v_lil_period_per_region_2 AS PER ON PERMSTR.period_sid = PER.period_sid
 LEFT JOIN (SELECT client_id,
   src_assort_parent_cat_cd,
   MIN(assort_cat_sid) AS assort_cat_sid
  FROM ldl_p_lew_core_ac.v_lil_assort_category_2
  WHERE assort_cat_level = 1
  GROUP BY client_id,
   src_assort_parent_cat_cd) AS acatc ON REGION.client_id = acatc.client_id AND con.src_assort_parent_cat_cd = acatc.src_assort_parent_cat_cd
   
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_assort_region_cat_2 AS ACATM ON acatc.client_id = ACATM.client_id AND REGION.region_sid
     = ACATM.region_sid AND acatc.assort_cat_sid = ACATM.assort_cat_sid
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation_2 AS NAEN ON NAEN.context = 'DELCONT' AND NAEN.trans_id = 1 AND
   NAEN.lang_cd = 'EN'
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation_2 AS NADE ON NADE.context = 'DELCONT' AND NADE.trans_id = 1 AND
   NADE.lang_cd = 'DE'
GROUP BY client_id,
 per_id,
 REG.interface_name,
 per_end_date,
 REG.status_2,
 delivery_content,
 delivery_content_smart_desc,
 delivery_content_smart_desc_en;