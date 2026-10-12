CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_l_mo_status
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v0.mandant_id AS mandant_id,
  v0.mo_status_id AS mo_status_id,
  v1.mo_status_bez AS mo_status_bez,
  v1.spr_id AS spr_id
FROM kfl_production_dbp_view.v_immo_l_mo_status AS v0
INNER JOIN kfl_production_dbp_view.v_immo_mo_status_spr_zu AS v1
  ON v0.mandant_id = v1.mandant_id AND v0.mo_status_id = v1.mo_status_id
WHERE
  v1.spr_id = 22
UNION ALL
SELECT
  mandant_id,
  -1 AS mo_status_id,
  '' AS mo_status_bez,
  22 AS spr_id
FROM kfl_production_dbp_view.v_mandant;
