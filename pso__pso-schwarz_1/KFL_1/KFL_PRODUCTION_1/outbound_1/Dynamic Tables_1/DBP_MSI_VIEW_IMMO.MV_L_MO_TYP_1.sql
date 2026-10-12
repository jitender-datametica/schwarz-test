CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_l_mo_typ_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT DISTINCT
  mo_typ_id AS mo_typ_id,
  mo_typ_bez AS mo_typ_bez
FROM kfl_production_dbp_view.v_immo_l_mo_typ_1 AS v0;
