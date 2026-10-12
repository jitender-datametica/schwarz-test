CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_prodh_lvl_5_spr_zu_2 AS SELECT mandant_id,
 spr_id,
 art_col_auspr AS prodh_lvl_5,
 art_col_bez AS prodh_lvl_5_bez
FROM kfl_production_dbp_view.v_flw_art_col_spr_zu_2 AS V01
WHERE flw_art_col_id = 5;