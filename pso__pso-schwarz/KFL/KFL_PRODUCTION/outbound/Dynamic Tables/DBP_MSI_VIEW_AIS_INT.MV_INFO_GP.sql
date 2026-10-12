CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_info_gp
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id,
  gp_id,
  gp_name_lat AS gp_name,
  gp_name_lat AS gp_name_de,
  gp_name_lat AS gp_name_cz,
  gp_name_lat AS gp_name_pl,
  gp_name_lat AS gp_name_md,
  gp_name_lat AS gp_name_sk,
  gp_name_lat AS gp_name_hr,
  gp_name_lat AS gp_name_ro,
  gp_name AS gp_name_bg,
  zek_id
FROM kfl_production_dbp_view.v_gp AS v01;