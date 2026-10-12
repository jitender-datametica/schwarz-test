CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_l_art_col_1 AS SELECT mandant_id,
 flw_art_col_id,
 art_col_auspr,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_l_art_col_1;