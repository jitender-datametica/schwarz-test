CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_art_gp_aktuell_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  art_id AS art_id,
  gp_id AS akt_gp_id,
  mandant_id AS mandant_id,
  wup_id AS wup_id
FROM kfl_production_dbp_view.v_art_gp_nm_zu_per_1
WHERE
  mandant_id = 1 AND dat_bis = CAST('9999-12-31' AS DATE);
