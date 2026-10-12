CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.mv_art_vz_status_per_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  p.art_id,
  p.dat_bis,
  p.dat_von,
  CASE WHEN p.loesch_id = '' THEN a.loesch_id ELSE p.loesch_id END AS loesch_id,
  p.mandant_id,
  p.nb_id,
  p.wup_id,
  p.wg_verkett_id,
  p.fremd_lagerort_id,
  p.disponent_id,
  p.system_id,
  p.pps_plan_kalender_id,
  p.disposition_rhythmus_id,
  p.planlieferzeit,
  p.dispomerkmal,
  p.we_bearbeitungszeit,
  p.min_sicherh_bestand,
  p.anliefer_kalender,
  p.selbstabholung_fg
FROM kfl_production_dbp_view.v_art_wup_status_per_1 AS p
INNER JOIN kfl_production_dbp_view.v_art_1 AS a
  ON p.art_id = a.art_id AND p.mandant_id = a.mandant_id
WHERE
  p.dat_bis = CAST('9999-12-31' AS DATE) AND p.mandant_id <> 1 AND p.nb_id = -111;