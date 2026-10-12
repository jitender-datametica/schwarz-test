CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_rpm_phase_spr_zu_bg
OPTIONS (
  enable_refresh=TRUE,
  refresh_interval_minutes=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  de.rpm_phase_id AS rpm_phase_id,
  de.rpm_projekt_typ_id AS rpm_projekt_typ_id,
  CASE
    WHEN de.rpm_phase_id = '1'
    THEN ''
    ELSE COALESCE(ls.rpm_phase_bez, de.rpm_phase_bez)
  END AS rpm_phase_bez
FROM kfl_production_dbp_view.v_rpm_phase_spr_zu AS de
LEFT JOIN (
  SELECT
    rpm_phase_id,
    rpm_projekt_typ_id,
    rpm_phase_bez
  FROM kfl_production_dbp_view.v_rpm_phase_spr_zu
  WHERE
    spr_id = 18
) AS ls
  ON de.rpm_phase_id = ls.rpm_phase_id
  AND de.rpm_projekt_typ_id = ls.rpm_projekt_typ_id
WHERE
  de.spr_id = 22;
