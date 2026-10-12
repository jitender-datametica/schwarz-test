CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_l_besitzstatus_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v1.mandant_id AS mandant_id,
  v1.besitzstatus_id AS besitzstatus_id,
  v2.besitzstatus_bez AS besitzstatus_bez
FROM kfl_production_dbp_view.v_immo_l_besitzstatus_1 AS v1
INNER JOIN kfl_production_dbp_view.v_immo_besitzstatus_spr_zu_1 AS v2
  ON v1.mandant_id = v2.mandant_id AND v1.besitzstatus_id = v2.besitzstatus_id
WHERE
  v2.spr_id = 22;
