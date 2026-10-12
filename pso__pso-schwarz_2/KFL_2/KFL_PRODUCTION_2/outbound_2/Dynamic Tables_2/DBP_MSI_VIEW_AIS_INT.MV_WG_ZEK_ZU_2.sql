CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_wg_zek_zu_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  arthiertyp_id AS arthiertyp_id,
  mandant_id AS mandant_id,
  wg_id AS wg_id,
  zek_id AS zek_id
FROM kfl_production_dbp_msi_v_view.v_wg_zek_zu_2;
