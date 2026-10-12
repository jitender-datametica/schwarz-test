CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_art_herst_zu_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT DISTINCT
  v1.mandant_id AS mandant_id,
  v1.art_id AS art_id,
  CASE WHEN v1.herst_id = v2.gp_id THEN CAST(-2 AS BIGNUMERIC) ELSE v1.herst_id END AS herst_id,
  v1.gp_art_id AS gp_art_id,
  v2.gp_id AS gp_id,
  v2.gp_id AS akt_gp_id,
  v1.mhd_zeitraum_dz AS mhd_zeitraum_dz
FROM kfl_production_dbp_view.v_art_gp_zu_per_2 AS v1
LEFT JOIN kfl_production_dbp_view.v_art_gp_nm_zu_per_2 AS v2
  ON v1.art_id = v2.art_id AND v1.mandant_id = v2.mandant_id
WHERE
  v1.dat_bis = CAST('9999-12-31' AS DATE);
