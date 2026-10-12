CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_region
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.land_id AS land_id,
  v01.region_id AS region_id,
  v01.mandant_id AS mandant_id,
  v01.sap_region_id AS sap_region_id,
  v01.region_name AS region_name
FROM kfl_production_dbp_view.v_region AS v01
INNER JOIN (
  SELECT
    mandant_id,
    CASE WHEN mandant_id = 1 THEN 'DE' ELSE mandant_kbez END AS land_id
  FROM kfl_production_dbp_view.v_mandant
) AS v02
  ON v01.mandant_id = v02.mandant_id AND v01.land_id = v02.land_id;
