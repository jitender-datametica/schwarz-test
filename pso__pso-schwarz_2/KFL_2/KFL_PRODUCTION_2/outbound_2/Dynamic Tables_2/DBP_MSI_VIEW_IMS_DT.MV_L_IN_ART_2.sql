CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_in_art_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  in_art_id AS in_art_id,
  mandant_id AS mandant_id,
  in_art_nr AS in_art_nr,
  in_wg_id AS in_wg_id
FROM kfl_production_dbp_view.v_in_art_2 AS v01;
