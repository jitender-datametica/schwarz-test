CREATE OR REPLACE VIEW DBP_MSI_VIEW_QS.MV_L_DATENLIEFERUNG_SPR_ZU_2
(
datenlieferung_artbew
, datenlieferung_artbew_wg_sum
, datenlieferung_bonanzahl
, datenlieferung_misvier
, datenlieferung_qbm_status
, datenlieferung_bez
)
AS
SELECT
v01.datenlieferung_status_id AS datenlieferung_artbew
, v01.datenlieferung_status_id AS datenlieferung_artbew_wg_sum
, v01.datenlieferung_status_id AS datenlieferung_bonanzahl
, v01.datenlieferung_status_id AS datenlieferung_misvier
, v01.datenlieferung_status_id AS datenlieferung_qbm_status
, CAST(TRIM(v01.datenlieferung_status_id || ', ' || v01.datenlieferung_bez) AS VARCHAR(40)) AS datenlieferung_bez

FROM dbp_view.v_l_datenlieferung_status_2 v01;