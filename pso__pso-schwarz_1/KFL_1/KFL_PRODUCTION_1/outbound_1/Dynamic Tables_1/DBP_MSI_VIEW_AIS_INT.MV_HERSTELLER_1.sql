CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_hersteller_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  gp_id AS herst_id,
  gp_name AS herst_name,
  mandant_id AS mandant_id,
  gp_strasse AS strasse,
  gp_plz AS plz,
  gp_ort AS ort,
  land_id AS land_id,
  herst_fg AS herst_fg,
  1 AS ampel_flg
FROM kfl_production_dbp_view.v_gp_1 AS g
WHERE
  herst_fg = 1;
