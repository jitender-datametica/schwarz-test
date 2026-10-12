CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_l_gebiet_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.mandant_id AS mandant_id,
  v01.gebiet_id AS gebiet_id,
  v02.gebiet_bez AS gebiet_bez
FROM kfl_production_dbp_view.v_immo_l_gebiet_1 AS v01
INNER JOIN kfl_production_dbp_view.v_immo_gebiet_spr_zu_1 AS v02
  ON v01.mandant_id = v02.mandant_id
  AND v01.gebiet_id = v02.gebiet_id
  AND v02.spr_id = 22;
