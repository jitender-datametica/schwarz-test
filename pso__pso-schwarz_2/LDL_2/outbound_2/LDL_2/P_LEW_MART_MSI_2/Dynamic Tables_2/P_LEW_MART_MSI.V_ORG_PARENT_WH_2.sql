CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_org_parent_wh_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT PWH.client_id,
 WH.src_wh_id AS parent_wh_id,
 PWH.parent_wh_desc,
 PWH.parent_wh_fg
FROM ldl_p_lew_core_ac.v_wawi_org_parent_wh_2 AS PWH
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON PWH.parent_wh_loc_sid = WH.loc_sid_wh AND PWH.client_id = WH.client_id
     AND WH.dwh_actual_fg = 1
UNION ALL
SELECT CLNT.client_id,
  - 1 * CLNT.client_id AS parent_wh_id,
  '#' || TRIM(CNTR.country_iso_cd) AS parent_wh_desc,
 0 AS parent_wh_fg
FROM ldl_p_lew_core_ac.v_wawi_ref_client_country_2 AS CLNT
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country_2 AS CNTR ON CLNT.country_id = CNTR.country_id
WHERE CNTR.dashboard_relevant_fg = 1;