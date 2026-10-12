CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_process_mstr.v_agg_dsbrd_currency_tm_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT CR.client_id,
 CR.currency_iso_cd,
 CR.curr_tot_id,
 TM.tm_lvl_id,
 TM.cy_week,
 TM.cy_month,
 1 AS dummytime
FROM ldl_p_lew_mart_msi_ac.v_ref_currency_2 AS CR
 INNER JOIN ldl_p_lew_process_mstr.t_agg_nvgtn_tm_2 AS TM ON TRUE
WHERE TM.tm_lvl_id IN (2, 3);