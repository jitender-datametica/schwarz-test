CREATE OR REPLACE VIEW kfl_production_dbp_view.v_vis_rw AS SELECT mandant_id,
 wup_id,
 art_id,
 rw,
 rw_counter,
 reload_rw,
 reload_rw_counter,
 pruef_datum
FROM kfl_production_dbp_data.vis_rw;