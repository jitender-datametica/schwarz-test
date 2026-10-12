CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_in_art_spr_zu_hr
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  in_art_id AS in_art_id,
  CASE WHEN in_art_id = -1 THEN '' ELSE art_bez END AS art_bez
FROM kfl_production_dbp_view.v_in_art_spr_zu AS v01
WHERE
  spr_id = 65;
