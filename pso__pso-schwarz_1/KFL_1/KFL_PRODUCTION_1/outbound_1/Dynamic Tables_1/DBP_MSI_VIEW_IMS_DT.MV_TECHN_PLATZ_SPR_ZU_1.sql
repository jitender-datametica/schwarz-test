CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_techn_platz_spr_zu_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.techn_platz_id AS techn_platz_id,
  COALESCE(v02.tech_platz_bez, '') AS techn_platz_bez
FROM kfl_production_dbp_view.v_techn_platz_per_1 AS v01
LEFT JOIN kfl_production_dbp_view.v_techn_platz_spr_zu_per_1 AS v02
  ON v01.techn_platz_id = v02.techn_platz_id
  AND v02.dat_bis = CAST('9999-12-31' AS DATE)
  AND v02.spr_id = 22
WHERE
  v01.dat_bis = CAST('9999-12-31' AS DATE);
