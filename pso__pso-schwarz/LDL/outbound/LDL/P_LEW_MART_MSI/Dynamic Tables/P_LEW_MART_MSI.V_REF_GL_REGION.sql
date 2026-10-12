CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_ref_gl_region
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT client_id,
 gl_region_id,
 gl_region_desc,
 gl_last_name,
 gl_first_name
FROM ldl_p_lew_core_ac.v_wawi_ref_gl_region
UNION ALL
SELECT CLNT.client_id,
  - 1 * CLNT.client_id AS gl_region_id,
  '#' || TRIM(CNTR.country_iso_cd) AS gl_region_desc,
 CAST(CNTR.country_iso_cd AS STRING) AS gl_last_name,
 '#' AS gl_first_name
FROM ldl_p_lew_core_ac.v_wawi_ref_client_country AS CLNT
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country AS CNTR ON CLNT.country_id = CNTR.country_id
WHERE CNTR.dashboard_relevant_fg = 1;