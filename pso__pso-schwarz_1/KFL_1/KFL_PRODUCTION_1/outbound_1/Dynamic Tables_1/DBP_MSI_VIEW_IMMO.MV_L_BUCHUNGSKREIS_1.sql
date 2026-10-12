CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_l_buchungskreis_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v1.mandant_id AS mandant_id,
  CASE
    WHEN v1.buchungskreis_id < 10
    THEN '000' || TRIM(SUBSTR(CAST(v1.buchungskreis_id AS STRING), 1, 39))
    WHEN v1.buchungskreis_id < 100
    THEN '00' || TRIM(SUBSTR(CAST(v1.buchungskreis_id AS STRING), 1, 39))
    WHEN v1.buchungskreis_id < 1000
    THEN '0' || TRIM(SUBSTR(CAST(v1.buchungskreis_id AS STRING), 1, 39))
    ELSE '' || TRIM(SUBSTR(CAST(v1.buchungskreis_id AS STRING), 1, 39))
  END AS buchungskreis_id,
  v2.buchungskreis_bez AS buchungskreis_bez
FROM kfl_production_dbp_view.v_in_l_buchungskreis_1 AS v1
LEFT JOIN kfl_production_dbp_view.v_in_buchungskreis_spr_zu_1 AS v2
  ON v1.mandant_id = v2.mandant_id AND v1.buchungskreis_id = v2.buchungskreis_id;
