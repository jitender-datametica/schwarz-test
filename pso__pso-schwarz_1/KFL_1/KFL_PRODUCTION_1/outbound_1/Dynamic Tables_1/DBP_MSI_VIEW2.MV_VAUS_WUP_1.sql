CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_vaus_wup_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.mandant_id AS mandant_id,
  v01.nb_id AS nb_id,
  v01.land_id AS land_id,
  v01.wup_id AS wup_id,
  v01.buchungskreis_id AS buchungskreis_id,
  v02.gln_id AS gln_id
FROM kfl_production_dbp_view.v_wup_1 AS v01
LEFT JOIN kfl_production_dbp_view.v_vaus_wup_1 AS v02
  ON v01.mandant_id = v02.mandant_id AND v01.wup_id = v02.wup_id
WHERE
  v01.mandant_id = 1 AND v01.nb_id <> 99 AND NOT v01.wup_id BETWEEN 1 AND 999;
