CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_art_col_zu_2 AS SELECT mandant_id,
 flw_art_id,
 flw_art_col_id,
 art_col_auspr,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_art_col_zu_2;