CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_bsch_bestvor_det_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.best_vor_nr AS best_vor_nr,
  v01.best_vor_pos AS best_vor_pos,
  v01.mandant_id AS mandant_id,
  v01.dat_plan AS dat_plan,
  v01.art_id AS art_id,
  v01.gp_id AS gp_id,
  v01.menge_best_vor AS menge_best_vor,
  v01.menge_best AS menge_best,
  v01.status_2 AS status_2,
  v01.best_vor_einh AS best_vor_einh,
  v01.best_einh AS best_einh,
  v01.bestellart_id AS bestellart_id,
  v02.dispomerkmal AS dispomerkmal,
  COALESCE(v01.dat_lief_soll, CAST('1900-01-01' AS DATE)) AS dat_lief_soll
FROM kfl_production_dbp_view.v_bsch_bestvor_det_2 AS v01
INNER JOIN kfl_production_dbp_view.v_art_wup_status_per_2 AS v02
  ON v01.art_id = v02.art_id
  AND v01.wup_id = v02.wup_id
  AND v01.mandant_id = v02.mandant_id
  AND v01.nb_id = v02.nb_id
WHERE
  v02.dat_bis = CAST('9999-12-31' AS DATE);
