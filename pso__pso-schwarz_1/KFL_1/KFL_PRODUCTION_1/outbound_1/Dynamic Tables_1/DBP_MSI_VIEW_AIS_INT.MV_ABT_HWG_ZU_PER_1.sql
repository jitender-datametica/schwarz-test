CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_abt_hwg_zu_per_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.abt_id AS abt_id,
  v02.hwg_id AS hwg_id,
  v01.mandant_id AS mandant_id,
  v02.dat_von AS dat_von,
  v02.dat_bis AS dat_bis,
  v01.arthiertyp_id AS arthiertyp_id
FROM kfl_production_dbp_view.v_abt_1 AS v01
INNER JOIN kfl_production_dbp_view.v_hwg_per_1 AS v02
  ON v01.mandant_id = v02.mandant_id AND v01.abt_id = v02.abt_id
WHERE
  v02.arthiertyp_id = 2 AND v02.dat_bis = CAST('9999-12-31' AS DATE);
