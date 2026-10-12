CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_berichts_pos_it_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  berichts_position_it_id
FROM kfl_production_dbp_view.v_l_berichts_pos_it_2;
