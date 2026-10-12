CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_lbs_zek_sec_lief_sec_zu_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  zek_id AS zek_id,
  mandant_id AS mandant_id,
  gp_id AS gp_id
FROM kfl_production_dbp_view.v_gp_2
WHERE
  dat_bis = CAST('9999-12-31' AS DATE) AND mandant_id = 1;
