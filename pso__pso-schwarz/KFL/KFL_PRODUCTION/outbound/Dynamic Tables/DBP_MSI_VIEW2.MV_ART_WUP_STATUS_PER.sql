CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_art_wup_status_per
OPTIONS (
  enable_refresh=TRUE,
  refresh_interval_minutes=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  p.art_id AS art_id,
  p.dat_bis AS dat_bis,
  p.dat_von AS dat_von,
  CASE WHEN p.loesch_id = '' THEN a.loesch_id ELSE p.loesch_id END AS loesch_id,
  p.mandant_id AS mandant_id,
  p.nb_id AS nb_id,
  p.wup_id AS wup_id,
  p.wg_verkett_id AS wg_verkett_id,
  p.fremd_lagerort_id AS fremd_lagerort_id,
  p.disponent_id AS disponent_id,
  p.system_id AS system_id,
  p.pps_plan_kalender_id AS pps_plan_kalender_id,
  p.disposition_rhythmus_id AS disposition_rhythmus_id,
  p.planlieferzeit AS planlieferzeit,
  p.dispomerkmal AS dispomerkmal,
  p.we_bearbeitungszeit AS we_bearbeitungszeit,
  p.min_sicherh_bestand AS min_sicherh_bestand,
  p.anliefer_kalender AS anliefer_kalender,
  p.min_restlaufzeit AS min_restlaufzeit
FROM kfl_production_dbp_view.v_art_wup_status_per AS p
INNER JOIN kfl_production_dbp_view.v_art AS a
  ON p.art_id = a.art_id AND p.mandant_id = a.mandant_id
WHERE
  p.dat_bis = CAST('9999-12-31' AS DATE) AND p.mandant_id = 1 AND p.nb_id = 0;
