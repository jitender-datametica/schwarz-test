CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_ims_systemstatus_spr_zu
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.systemstatus_id AS systemstatus_id,
  v01.mandant_id AS mandant_id,
  v01.systemstatus_bez_kurz AS systemstatus_bez_kurz,
  v01.systemstatus_bez AS systemstatus_bez
FROM kfl_production_dbp_view.v_ims_systemstatus_spr_zu AS v01
INNER JOIN kfl_production_dbp_view.v_mandant_spr_zu AS v02
  ON v01.mandant_id = v02.mandant_id AND v01.spr_id = v02.spr_id;
