CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_ma_funktion AS SELECT mandant_id,
 ma_funktion_id
FROM kfl_production_dbp_view.v_l_ma_funktion AS V01;