CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_l_mandant
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  CASE WHEN mandant_id = 7 THEN 'Rumänien' ELSE mandant_bez END AS mandant_bez,
  mandant_kbez AS mandant_kbez,
  mandant_sap_id AS mandant_sap_id,
  default_wrg AS default_wrg,
  mandant_sort_id AS mandant_sort_id,
  CASE
    WHEN mandant_id = 1
    THEN 1
    WHEN mandant_id = 2
    THEN 2
    WHEN mandant_id = 3
    THEN 4
    WHEN mandant_id = 4
    THEN 8
    WHEN mandant_id = 5
    THEN 3
    WHEN mandant_id = 6
    THEN 5
    WHEN mandant_id = 7
    THEN 6
    WHEN mandant_id = 8
    THEN 7
    ELSE 9
  END AS sort_id
FROM kfl_production_dbp_view.v_mandant AS v0;
