CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_ref_client_language_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
SELECT client_id,
 language_id
FROM ldl_p_lew_core_ac.v_wawi_ref_client_language_2
UNION DISTINCT
SELECT client_id,
 7 AS language_id
FROM ldl_p_lew_core_ac.v_wawi_ref_client_language_2;