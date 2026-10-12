CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_wup
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  wup_id AS wup_id,
  mandant_id AS mandant_id,
  nb_id AS nb_id,
  CASE WHEN wup_id IN (0, -1) THEN '' ELSE wup_standort END AS wup_standort,
  COALESCE(vkl_id, -1) AS vkl_id,
  COALESCE(vs_id, 0) AS vs_id,
  laengengrad AS laengengrad,
  breitengrad AS breitengrad
FROM kfl_production_dbp_view.v_wup;
