CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_l_vkl
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  vkl_id AS vkl_id,
  mandant_id AS mandant_id,
  gf_id AS gf_id,
  vkl_name AS vkl_name
FROM kfl_production_dbp_view.v_vkl;
