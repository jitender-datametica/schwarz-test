CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat0_ref_gl_region_merge_1 AS SELECT client_id,
 gl_region_id,
 gl_region_desc,
 gl_last_name,
 gl_first_name,
 1 AS aspect_id
FROM ldl_p_lew_core_ac.v_wawi_ref_gl_region_1
UNION ALL
SELECT client_id,
 gl_region_id,
 gl_region_desc,
 gl_last_name,
 gl_first_name,
 2 AS aspect_id
FROM ldl_p_lew_core_ac.v_wawi_ref_gl_region_1
UNION ALL
SELECT CLNT.client_id,
  - 1 * CLNT.client_id AS gl_region_id,
  '#' || TRIM(CNTR.country_iso_cd) AS gl_region_desc,
 CAST(CNTR.country_iso_cd AS STRING) AS gl_last_name,
 '#' AS gl_first_name,
 multiply.row_no AS aspect_id
FROM ldl_p_lew_core_ac.v_wawi_ref_client_country_1 AS CLNT
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country_1 AS CNTR ON CLNT.country_id = CNTR.country_id
 INNER JOIN (SELECT 1 AS row_no
   UNION ALL
   SELECT 2 AS row_no) AS multiply ON TRUE
WHERE CNTR.dashboard_relevant_fg = 1;