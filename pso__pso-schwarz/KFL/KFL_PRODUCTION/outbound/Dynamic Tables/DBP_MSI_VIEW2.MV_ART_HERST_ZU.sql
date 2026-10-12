CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_art_herst_zu
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT DISTINCT
  v1.mandant_id AS mandant_id,
  v1.art_id AS art_id,
  v1.herst_id AS herst,
  CASE WHEN v1.herst_id = v2.gp_id THEN CAST(-2 AS BIGNUMERIC) ELSE v1.herst_id END AS herst_id,
  v1.gp_art_id AS gp_art_id,
  v2.gp_id AS gp_id,
  v2.gp_id AS akt_gp_id,
  v1.mhd_zeitraum_dz AS mhd_zeitraum_dz
FROM kfl_production_dbp_view.v_art_gp_zu_per AS v1
LEFT JOIN kfl_production_dbp_view.v_art_gp_nm_zu_per AS v2
  ON v1.art_id = v2.art_id
WHERE
  v1.mandant_id = 1 AND v1.dat_bis = CAST('9999-12-31' AS DATE);
