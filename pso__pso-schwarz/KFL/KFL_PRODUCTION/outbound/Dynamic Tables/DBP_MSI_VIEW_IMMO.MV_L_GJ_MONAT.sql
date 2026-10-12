CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_l_gj_monat
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  gjmo AS gjmo,
  gjmo_vj AS gjmo_vj,
  gjqu AS gjqu,
  gj AS gj,
  akt_mo AS akt_mo,
  akt_mo_komplett AS akt_mo_komplett,
  akt_gjqu AS akt_gjqu,
  akt_gjqu_komplett AS akt_gjqu_komplett,
  akt_gj AS akt_gj,
  akt_gj_komplett AS akt_gj_komplett,
  mo_gj AS mo_gj,
  min_dat AS min_dat,
  max_dat AS max_dat
FROM kfl_production_dbp_view.v_monat;
