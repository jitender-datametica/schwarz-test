
CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_lead.v_org_account_manager_merge
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT OAMM.aspect_id,
 OAMM.client_id,
 B.src_wh_id AS wh_id,
 B.loc_sid AS loc_sid_wh,
 OAMM.account_manager_id,
 OAMM.account_manager_name
FROM ldl_p_lew_core_ac.v_wawi_org_account_manager_mrg_act AS OAMM
 INNER JOIN ldl_p_lew_core_ac.v_location AS B ON OAMM.client_id = B.client_id AND OAMM.wh_loc_sid = B.loc_sid AND B.wh_store_mark
    = 'B' -- Filialen
 -- Filialen

UNION ALL
SELECT ASPT.aspect_id,
 CLNT.client_id,
  - 1 * CLNT.client_id AS wh_id,
  - 1 * CLNT.client_id AS loc_sid_wh,
  - 1 * CLNT.client_id AS account_manager_id,
  '#' || TRIM(CNTR.country_iso_cd) AS account_manager_name
FROM ldl_p_lew_core_ac.v_wawi_ref_client_country AS CLNT
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country AS CNTR ON CLNT.country_id = CNTR.country_id
 INNER JOIN ldl_p_lew_mart_lead.v_ref_aspect AS ASPT ON TRUE
WHERE CNTR.dashboard_relevant_fg = 1;


