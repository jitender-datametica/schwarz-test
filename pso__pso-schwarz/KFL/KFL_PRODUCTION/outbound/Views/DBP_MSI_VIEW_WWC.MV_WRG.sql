CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_wrg (waers, wrg_bez) AS SELECT wrg_id AS waers,
 wrg_bez
FROM kfl_production_dbp_view.v_wrg;