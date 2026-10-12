CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ims_dt.mv_tag_1 AS
SELECT
  dat AS dat,
  gjmo AS gjmo,
  gj AS gj,
  akt_gj AS akt_gj,
  mo_gj AS mo_gj,
  dat AS dat_bez
FROM kfl_production_dbp_view.v_tag_1
UNION DISTINCT
SELECT
  CAST('2010' AS DATE) AS dat,
  190001,
  1900,
  -9999,
  1,
  CAST(NULL AS DATE) AS dat_bez
FROM kfl_production_dbp_view.v_tag_1
WHERE
  dat = CURRENT_DATE;
