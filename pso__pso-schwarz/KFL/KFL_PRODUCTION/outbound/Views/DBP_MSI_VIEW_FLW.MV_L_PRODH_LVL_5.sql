CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_prodh_lvl_5 (mandant_id, prodh_lvl_5) AS SELECT mandant_id,
 art_col_auspr AS prodh_lvl_5
FROM kfl_production_dbp_view.v_flw_l_art_col
WHERE flw_art_col_id = 5;