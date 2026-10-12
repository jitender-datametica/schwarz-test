CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_baustein_art_wup_zu_per_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.baustein_id AS baustein_id,
  v01.mandant_id AS mandant_id,
  v01.art_id AS art_id,
  v02.wup_id AS wup_id,
  v02.nb_id AS nb_id,
  v01.dat_bis AS dat_bis_art,
  v01.dat_von AS dat_von_art,
  v02.dat_bis AS dat_bis_wup,
  v02.dat_von AS dat_von_wup
FROM kfl_production_dbp_msi_v_view.v_baustein_art_zu_per_msi_1 AS v01
INNER JOIN kfl_production_dbp_view.v_baustein_wup_zu_per_1 AS v02
  ON v01.baustein_id = v02.baustein_id AND v01.mandant_id = v02.mandant_id
WHERE
  v01.mandant_id = 1;
