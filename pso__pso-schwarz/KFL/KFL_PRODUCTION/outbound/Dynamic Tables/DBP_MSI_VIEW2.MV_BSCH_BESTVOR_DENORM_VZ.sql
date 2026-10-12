CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_bsch_bestvor_denorm_vz
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  pos.best_vor_nr AS best_vor_nr,
  pos.mandant_id AS mandant_id,
  pos.wup_id AS wup_id,
  pos.nb_id AS nb_id,
  pos.best_vor_pos AS best_vor_pos,
  pos.dat_plan AS dat_plan,
  pos.art_id AS art_id,
  pos.gp_id AS gp_id,
  pos.menge_best_vor AS menge_best_vor,
  pos.menge_best AS menge_best,
  pos.status AS status,
  pos.best_vor_einh AS best_vor_einh,
  pos.best_einh AS best_einh,
  marc.dispomerkmal AS dispomerkmal,
  pos.bestellart_id AS bestellart_id,
  COALESCE(pos.dat_lief_soll, CAST('1900-01-01' AS DATE)) AS dat_lief_soll
FROM kfl_production_dbp_view.v_bsch_bestvor_det AS pos
INNER JOIN kfl_production_dbp_view.v_art_wup_status_per AS marc
  ON pos.art_id = marc.art_id
  AND pos.wup_id = marc.wup_id
  AND pos.mandant_id = marc.mandant_id
  AND pos.nb_id = marc.nb_id
  AND pos.dat_plan BETWEEN marc.dat_von AND marc.dat_bis
WHERE
  (
    pos.menge_best <> 0 OR pos.status <> '0B'
  )
  AND marc.dispomerkmal IN ('10', '11', '12', '14')
  AND pos.mandant_id = 1
  AND marc.kdis = 0
  AND pos.nb_id = -111;
