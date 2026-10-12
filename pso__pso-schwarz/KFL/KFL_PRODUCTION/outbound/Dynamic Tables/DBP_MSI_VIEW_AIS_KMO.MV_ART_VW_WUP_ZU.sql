CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.mv_art_vw_wup_zu
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  wup_id AS wup_id,
  vw_id AS vw_id,
  art_id AS art_id,
  nb_id AS nb_id,
  rabatt_zul_fg AS rabatt_zul_fg
FROM kfl_production_dbp_view.v_art_vw_wup_zu
WHERE
  mandant_id <> 1 AND wup_id = -1 AND vw_id = 10;
