CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_wwc.mv_artbew_wg_sum_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.wup_id AS werks,
  v01.mandant_id,
  v01.bewart_id,
  v01.nb_id,
  v01.dat,
  v01.wg_id AS matkl,
  v01.menge,
  v01.umsatz_netto AS vk_netto,
  v02.default_wrg AS wrg_id
FROM kfl_production_dbp_view.v_artbew_wg_sum_2 AS v01
INNER JOIN kfl_production_dbp_view.v_mandant_2 AS v02
  ON v01.mandant_id = v02.mandant_id;