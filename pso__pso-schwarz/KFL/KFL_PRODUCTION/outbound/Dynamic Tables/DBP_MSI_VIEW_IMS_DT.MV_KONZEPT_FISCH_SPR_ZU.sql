CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_konzept_fisch_spr_zu
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  t01.rpm_feld_auspr_id AS bed_fisch_id,
  CASE WHEN t01.rpm_feld_auspr_id = 1 THEN '' ELSE t01.rpm_feld_auspr_bez END AS bed_fisch_bez
FROM kfl_production_dbp_view.v_rpm_feld_auspr_spr_zu AS t01
INNER JOIN kfl_production_dbp_view.v_l_rpm_feld AS t02
  ON t01.rpm_feld_id = t02.rpm_feld_id
WHERE
  t02.rpm_feld_bez = 'ZPPM_FISCH' AND t01.rpm_tab_id = 1 AND t01.spr_id = 22;
