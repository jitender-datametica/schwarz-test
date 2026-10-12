CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_art_herst_zu_1
OPTIONS (
  enable_refresh=TRUE,
  refresh_interval_minutes=90,
  max_staleness=INTERVAL '1:30:0' HOUR TO SECOND,
  allow_non_incremental_definition=TRUE
) AS
SELECT DISTINCT
  v1.mandant_id,
  v1.art_id,
  v1.herst_id,
  CASE WHEN v1.herst_id = v2.gp_id THEN -2  ELSE v1.herst_id END as herst_id0,
  v1.gp_art_id,
  v2.gp_id,
  v2.gp_id AS akt_gp_id,
  v1.mhd_zeitraum_dz
FROM kfl_production_dbp_view.v_art_gp_zu_per_1 AS v1
LEFT JOIN kfl_production_dbp_view.v_art_gp_nm_zu_per_1 AS v2
  ON v1.art_id = v2.art_id
WHERE
  v1.mandant_id = 1 AND v1.dat_bis = CAST('9999-12-31' AS DATE);