CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_mandant_wrg_typ_zu_ivs_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  wrg_id AS wrg_id,
  wrg_typ_id AS wrg_typ_id,
  wrg_typ_bez AS wrg_typ_bez
FROM kfl_production_dbp_view.v_mandant_wrg_typ_zu_2;
