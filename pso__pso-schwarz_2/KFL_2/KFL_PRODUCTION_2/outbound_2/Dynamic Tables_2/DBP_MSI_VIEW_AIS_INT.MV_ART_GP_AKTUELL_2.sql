CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_art_gp_aktuell_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  art_id,
  gp_id as akt_gp_id,
  mandant_id,
  wup_id
FROM kfl_production_dbp_view.v_art_gp_nm_zu_per_2
WHERE
  dat_bis = CAST('9999-12-31' AS DATE)
GROUP BY
  art_id,
  gp_id,
  mandant_id,
  wup_id;