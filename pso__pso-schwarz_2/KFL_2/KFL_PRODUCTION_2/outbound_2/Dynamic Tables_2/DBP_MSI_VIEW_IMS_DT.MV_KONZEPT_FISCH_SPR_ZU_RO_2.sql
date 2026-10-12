CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_konzept_fisch_spr_zu_ro_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  de1.rpm_feld_auspr_id AS bed_fisch_id,
  CASE
    WHEN de1.rpm_feld_auspr_id = 1
    THEN ''
    ELSE COALESCE(ls.rpm_feld_auspr_bez, de1.rpm_feld_auspr_bez)
  END AS bed_fisch_bez
FROM kfl_production_dbp_view.v_rpm_feld_auspr_spr_zu_2 AS de1
INNER JOIN kfl_production_dbp_view.v_l_rpm_feld_2 AS de2
  ON de1.rpm_feld_id = de2.rpm_feld_id
LEFT JOIN (
  SELECT
    ls1.rpm_feld_auspr_id,
    ls1.rpm_feld_auspr_bez
  FROM kfl_production_dbp_view.v_rpm_feld_auspr_spr_zu_2 AS ls1
  INNER JOIN kfl_production_dbp_view.v_l_rpm_feld_2 AS ls2
    ON ls1.rpm_feld_id = ls2.rpm_feld_id
  WHERE
    ls1.spr_id = 95 AND ls2.rpm_feld_bez = 'ZPPM_FISCH' AND ls1.rpm_tab_id = 1
) AS ls
  ON de1.rpm_feld_auspr_id = ls.rpm_feld_auspr_id
WHERE
  de1.spr_id = 22 AND de2.rpm_feld_bez = 'ZPPM_FISCH' AND de1.rpm_tab_id = 1;
