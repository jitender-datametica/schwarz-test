CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_lead.v_ref_client_bchmk_rpt_scty_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT F.client_id AS client_bchmk_rpt_scty_id,
 M.client_id
FROM ldl_p_lew_mart_lead.v_ref_client_2 AS F
 INNER JOIN ldl_p_lew_mart_lead.v_ref_client_2 AS M ON TRUE;

