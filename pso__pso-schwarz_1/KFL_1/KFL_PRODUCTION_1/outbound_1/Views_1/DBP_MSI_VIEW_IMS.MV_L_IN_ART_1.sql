CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_l_in_art_1 AS SELECT in_art_id,
 mandant_id,
 in_art_nr,
 in_wg_id
FROM kfl_production_dbp_view.v_in_art_1 AS V01;