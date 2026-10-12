CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_gf
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  gf_id AS gf_id,
  mandant_id AS mandant_id,
  CASE WHEN gf_id IN (0, -1) THEN '' ELSE gf_name END AS gf_name
FROM kfl_production_dbp_view.v_gf
WHERE
  ek_fg = 0;
