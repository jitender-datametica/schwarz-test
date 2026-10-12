CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_rpm_phase_spr_zu_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  rpm_phase_id AS rpm_phase_id,
  rpm_projekt_typ_id AS rpm_projekt_typ_id,
  CASE WHEN rpm_phase_id = '1' THEN '' ELSE rpm_phase_bez END AS rpm_phase_bez
FROM kfl_production_dbp_view.v_rpm_phase_spr_zu_2
WHERE
  spr_id = 22;
