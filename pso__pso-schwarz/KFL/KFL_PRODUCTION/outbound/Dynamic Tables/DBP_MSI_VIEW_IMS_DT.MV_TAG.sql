CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ims_dt.mv_tag AS
SELECT
  dat AS dat,
  gjmo AS gjmo,
  gj AS gj,
  akt_gj AS akt_gj,
  mo_gj AS mo_gj,
  dat AS dat_bez
FROM kfl_production_dbp_view.v_tag
UNION DISTINCT
SELECT
  CAST('2010' AS DATE) AS dat,
  190001,
  1900,
  -9999,
  1,
  CAST(NULL AS DATE) AS dat_bez
FROM kfl_production_dbp_view.v_tag
WHERE
  dat = CURRENT_DATE;
