CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_qs.mv_l_datenlieferung_spr_zu_1 (datenlieferung_artbew,
datenlieferung_artbew_wg_sum, datenlieferung_bonanzahl, datenlieferung_misvier, datenlieferung_qbm_status,
datenlieferung_bez) AS SELECT datenlieferung_status_id AS datenlieferung_artbew,
 datenlieferung_status_id AS datenlieferung_artbew_wg_sum,
 datenlieferung_status_id AS datenlieferung_bonanzahl,
 datenlieferung_status_id AS datenlieferung_misvier,
 datenlieferung_status_id AS datenlieferung_qbm_status,
 TRIM(CAST(datenlieferung_status_id AS STRING) || ', ' || datenlieferung_bez) AS datenlieferung_bez
FROM kfl_production_dbp_view.v_l_datenlieferung_status_1 AS V01;