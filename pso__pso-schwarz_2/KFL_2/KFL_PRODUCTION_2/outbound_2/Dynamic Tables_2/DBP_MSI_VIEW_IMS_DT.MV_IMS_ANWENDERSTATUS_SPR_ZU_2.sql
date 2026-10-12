CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_ims_anwenderstatus_spr_zu_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  anwenderstatus_id AS anwenderstatus_id,
  mandant_id AS mandant_id,
  anwenderstatus_bez_kurz AS anwenderstatus_bez_kurz,
  anwenderstatus_bez AS anwenderstatus_bez
FROM kfl_production_dbp_view.v_ims_anwenderstatus_spr_zu_2
WHERE
  spr_id = 22;
