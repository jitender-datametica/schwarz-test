CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_l_gf_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  gf_id AS gf_id,
  mandant_id AS mandant_id,
  ek_fg AS ek_fg,
  gf_name AS gf_name
FROM kfl_production_dbp_view.v_gf_1;
