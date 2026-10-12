CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_rpm_phase_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  rpm_phase_id AS rpm_phase_id,
  rpm_projekt_typ_id AS rpm_projekt_typ_id
FROM kfl_production_dbp_view.v_l_rpm_phase_2;
