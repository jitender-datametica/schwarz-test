CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_hwg_wg_zu_per_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.hwg_id AS hwg_id,
  v02.owg_id AS owg_id,
  v03.wg_id AS wg_id,
  v01.mandant_id AS mandant_id,
  v01.dat_von AS dat_von,
  v01.dat_bis AS dat_bis,
  v01.arthiertyp_id AS arthiertyp_id
FROM kfl_production_dbp_view.v_hwg_per_2 AS v01
INNER JOIN kfl_production_dbp_view.v_owg_per_2 AS v02
  ON v01.mandant_id = v02.mandant_id AND v01.hwg_id = v02.hwg_id
INNER JOIN kfl_production_dbp_view.v_wg_per_2 AS v03
  ON v02.mandant_id = v03.mandant_id AND v02.owg_id = v03.owg_id
WHERE
  v01.arthiertyp_id = 2 AND v01.dat_bis = CAST('9999-12-31' AS DATE);
