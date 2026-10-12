CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_art_wup_status_per_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.art_id,
  v01.dat_bis,
  v01.dat_von,
  CASE WHEN v01.loesch_id = '' THEN v02.loesch_id ELSE v01.loesch_id END AS loesch_id,
  v01.mandant_id,
  v01.nb_id,
  v01.wup_id,
  v01.wg_verkett_id,
  v01.fremd_lagerort_id,
  v01.disponent_id,
  v01.system_id,
  v01.pps_plan_kalender_id,
  v01.disposition_rhythmus_id,
  v01.planlieferzeit,
  v01.dispomerkmal,
  v01.we_bearbeitungszeit,
  v01.min_sicherh_bestand,
  v01.anliefer_kalender,
  v01.sollbestand,
  v01.min_restlaufzeit
FROM kfl_production_dbp_view.v_art_wup_status_per_1 AS v01
INNER JOIN kfl_production_dbp_view.v_art_1 AS v02
  ON v01.art_id = v02.art_id AND v01.mandant_id = v02.mandant_id
WHERE
  v01.dat_bis = CAST('9999-12-31' AS DATE) AND v01.nb_id = 0;