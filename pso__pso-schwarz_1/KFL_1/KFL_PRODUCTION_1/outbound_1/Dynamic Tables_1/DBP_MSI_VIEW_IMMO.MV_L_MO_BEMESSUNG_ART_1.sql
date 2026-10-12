CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_l_mo_bemessung_art_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  bemessung_art_id AS bemessung_art_id
FROM kfl_production_dbp_view.v_immo_l_mo_bemessung_art_1;
