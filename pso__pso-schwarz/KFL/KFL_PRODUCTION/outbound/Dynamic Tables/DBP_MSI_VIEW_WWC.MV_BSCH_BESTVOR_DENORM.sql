CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_wwc.mv_bsch_bestvor_denorm
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v02.best_vor_nr,
  v02.mandant_id,
  v02.wup_id,
  v02.nb_id,
  v02.best_vor_pos,
  v02.dat_plan,
  v02.art_id,
  v02.gp_id,
  v02.menge_best_vor,
  v02.menge_best,
  v02.status,
  v02.best_vor_einh,
  v02.best_einh,
  v03.dispomerkmal
FROM kfl_production_dbp_view.v_bsch_bestvor_det AS v02
INNER JOIN kfl_production_dbp_view.v_art_wup_status_per AS v03
  ON v02.art_id = v03.art_id
  AND v02.wup_id = v03.wup_id
  AND v02.mandant_id = v03.mandant_id
  AND v02.nb_id = v03.nb_id
  AND v02.dat_plan BETWEEN v03.dat_von AND v03.dat_bis
WHERE
  (
    v02.menge_best <> 0 OR v02.status <> '0B'
  )
  AND (
    v02.mandant_id = 1
    AND v03.dispomerkmal = '11'
    OR v02.mandant_id <> 1
    AND v03.dispomerkmal = 'S2'
  )
  AND NOT v02.nb_id IN (-111);