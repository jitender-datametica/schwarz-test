CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_in_wg_spr_zu_en_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  in_wg_id AS in_wg_id,
  in_wg_bez AS in_wg_bez,
  in_wg_bez_lang AS in_wg_bez_lang
FROM kfl_production_dbp_view.v_in_wg_spr_zu_1 AS v01
WHERE
  spr_id = 24;
