CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_in_art (mandant_id, in_art_id, in_art_nr, in_wg_id,
basismenge_einh_id) AS SELECT mandant_id,
 in_art_id,
 in_art_nr,
 in_wg_id,
 basismenge_einh_id
FROM kfl_production_dbp_view.v_in_art;