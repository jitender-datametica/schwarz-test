CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_ims_psp_ele_anwenderstat_zu
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.mandant_id AS mandant_id,
  v01.psp_id AS psp_id,
  COALESCE(v02.anwenderstatus_id, 'E0001') AS anwenderstatus_id
FROM kfl_production_dbp_view.v_in_psp_element AS v01
LEFT JOIN kfl_production_dbp_view.v_ims_psp_ele_anwenderstat_zu AS v02
  ON v01.psp_id = v02.psp_id AND v01.mandant_id = v02.mandant_id
WHERE
  v01.statistisch_fg = 1;
