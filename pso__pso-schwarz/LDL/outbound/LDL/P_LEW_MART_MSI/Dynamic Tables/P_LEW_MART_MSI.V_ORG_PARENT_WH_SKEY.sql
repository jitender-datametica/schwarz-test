CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_org_parent_wh_skey
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT DISTINCT WH_SKEY.client_id,
 WH2.src_wh_id AS parent_wh_id,
 WH.src_wh_id AS wh_id,
 WH_SKEY.aspect_id
FROM ldl_p_lew_core_ac.v_wawi_org_parent_wh_skey AS WH_SKEY
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON WH_SKEY.wh_loc_sid = WH.loc_sid_wh AND WH_SKEY.client_id = WH.client_id
     AND WH.dwh_actual_fg = 1
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH2 ON WH_SKEY.parent_wh_loc_sid = WH2.loc_sid_wh AND WH_SKEY.client_id =
    WH2.client_id AND WH2.dwh_actual_fg = 1
UNION ALL
SELECT CLNT.client_id,
  - 1 * CLNT.client_id AS parent_wh_id,
  - 1 * CLNT.client_id AS wh_id,
 multiply.row_no AS aspect_id
FROM ldl_p_lew_core_ac.v_wawi_ref_client_country AS CLNT
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country AS CNTR ON CLNT.country_id = CNTR.country_id
 INNER JOIN (SELECT 1 AS row_no
   UNION ALL
   SELECT 2 AS row_no) AS multiply ON TRUE
WHERE CNTR.dashboard_relevant_fg = 1;