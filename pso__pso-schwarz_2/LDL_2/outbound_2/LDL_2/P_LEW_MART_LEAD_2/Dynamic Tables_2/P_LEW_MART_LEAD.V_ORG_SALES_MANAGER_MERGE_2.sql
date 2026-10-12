
CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_lead.v_org_sales_manager_merge_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT OSMM.aspect_id,
 OSMM.client_id,
 B.src_wh_id AS wh_id,
 BEXP.src_wh_id AS wh_id_exp,
 B.loc_sid AS loc_sid_wh,
 OSMM.sales_manager_id,
 OSMM.account_manager_id,
 OSMM.sales_manager_name
FROM ldl_p_lew_core_ac.v_wawi_org_sales_manager_merge_act_2 AS OSMM
 INNER JOIN ldl_p_lew_core_ac.v_location_2 AS B ON OSMM.client_id = B.client_id AND OSMM.wh_loc_sid = B.loc_sid AND B.wh_store_mark
    = 'B' -- Filialen

 INNER JOIN ldl_p_lew_core_ac.v_location_2 AS BEXP ON OSMM.client_id = BEXP.client_id AND OSMM.wh_loc_sid_exp = BEXP.loc_sid
     AND BEXP.wh_store_mark = 'B' -- Filialen
 -- Filialen

UNION ALL
SELECT ASPT.aspect_id,
 CLNT.client_id,
  - 1 * CLNT.client_id AS wh_id,
  - 1 * CLNT.client_id AS wh_id_exp,
  - 1 * CLNT.client_id AS loc_sid_wh,
  - 1 * CLNT.client_id AS sales_manager_id,
  - 1 * CLNT.client_id AS account_manager_id,
  '#' || TRIM(CNTR.country_iso_cd) AS sales_manager_name
FROM ldl_p_lew_core_ac.v_wawi_ref_client_country_2 AS CLNT
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country_2 AS CNTR ON CLNT.country_id = CNTR.country_id
 INNER JOIN ldl_p_lew_mart_lead.v_ref_aspect_2 AS ASPT ON TRUE
WHERE CNTR.dashboard_relevant_fg = 1;

