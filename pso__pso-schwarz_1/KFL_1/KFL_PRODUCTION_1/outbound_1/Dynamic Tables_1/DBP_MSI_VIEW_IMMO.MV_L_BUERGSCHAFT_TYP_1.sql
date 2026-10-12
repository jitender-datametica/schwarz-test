CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_l_buergschaft_typ_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
     buergschaft_typ_id, buergschaft_typ_bez
FROM kfl_production_dbp_view.v_l_buergschaft_typ_1;