CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_ref_client_language_all_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT C.client_id,
 L.language_id
FROM ldl_p_lew_mart_msi.v_ref_client_1 AS C
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_language_1 AS L ON TRUE;