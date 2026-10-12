CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ais_int.mv_jahr_gj (
  gj BIGNUMERIC(38, 0),
  akt_gj BIGNUMERIC(38, 0),
  akt_gj_komplett BIGNUMERIC(38, 0),
  akt_gj_help BIGNUMERIC(38, 0)
) AS
SELECT
  gj AS gj,
  akt_gj AS akt_gj,
  akt_gj_komplett AS akt_gj_komplett,
  CASE WHEN EXTRACT(MONTH FROM CURRENT_DATE) = 3 THEN akt_gj + 1 ELSE akt_gj END AS akt_gj_help
FROM kfl_production_dbp_view.v_jahr_gj AS v01
WHERE
  gj > 2001;
