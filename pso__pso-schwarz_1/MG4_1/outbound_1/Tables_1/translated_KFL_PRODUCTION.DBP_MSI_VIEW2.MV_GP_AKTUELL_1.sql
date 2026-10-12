/* , wup_id */
CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_gp_aktuell_1
OPTIONS (
  enable_refresh=TRUE,
  refresh_interval_minutes=90,
  max_staleness=INTERVAL '1:30:0' HOUR TO SECOND,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v01.gp_id,
  v02.gp_name
FROM kfl_production_dbp_view.v_art_gp_nm_zu_per_1 AS v01
LEFT JOIN kfl_production_dbp_view.v_gp_1 AS v02
  ON v01.gp_id = v02.gp_id AND v01.mandant_id = v02.mandant_id
WHERE
  v01.dat_bis = CAST('9999-12-31' AS DATE) AND v01.mandant_id = 1
GROUP BY
  v01.gp_id,
  v02.gp_name;