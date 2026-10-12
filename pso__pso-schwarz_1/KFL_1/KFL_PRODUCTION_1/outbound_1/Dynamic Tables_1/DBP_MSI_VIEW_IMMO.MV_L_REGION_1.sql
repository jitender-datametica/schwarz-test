CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_l_region_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v1.mandant_id AS mandant_id,
  v1.region_id AS region_id,
  v2.spr_id AS spr_id,
  v2.region_bez AS region_bez
FROM kfl_production_dbp_view.v_immo_l_region_1 AS v1
INNER JOIN kfl_production_dbp_view.v_immo_region_spr_zu_1 AS v2
  ON v1.mandant_id = v2.mandant_id AND v1.region_id = v2.region_id
WHERE
  v2.spr_id = 22;
