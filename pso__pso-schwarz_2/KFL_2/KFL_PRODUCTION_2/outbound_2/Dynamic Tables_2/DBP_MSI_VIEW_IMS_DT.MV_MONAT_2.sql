CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_monat_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  kjmo AS kjmo,
  kjmo_vj AS kjmo_vj,
  gjmo AS gjmo,
  gjmo_vj AS gjmo_vj,
  kjqu AS kjqu,
  gjqu AS gjqu,
  kj AS kj,
  gj AS gj,
  akt_mo AS akt_mo,
  akt_mo_komplett AS akt_mo_komplett,
  akt_gjqu AS akt_gjqu,
  akt_gjqu_komplett AS akt_gjqu_komplett,
  akt_kjqu AS akt_kjqu,
  akt_kjqu_komplett AS akt_kjqu_komplett,
  akt_gj AS akt_gj,
  akt_gj_komplett AS akt_gj_komplett,
  akt_kj AS akt_kj,
  akt_kj_komplett AS akt_kj_komplett,
  mo_gj AS mo_gj,
  mo_kj AS mo_kj,
  min_dat AS min_dat,
  max_dat AS max_dat,
  ROUND(
    CAST(FORMAT_DATE('%Y%m', DATE_ADD(PARSE_DATE('%Y%m', CAST(kjmo AS STRING)), INTERVAL '-1' MONTH)) AS BIGNUMERIC),
    0
  ) AS kjmo_vm
FROM kfl_production_dbp_view.v_monat_2;
