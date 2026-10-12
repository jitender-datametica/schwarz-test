CREATE OR REPLACE VIEW kfl_production_dbp_view.v_bewart_det_spr_zu AS SELECT bewart_det_id,
 mandant_id,
 spr_id,
 bewart_det_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.bewart_det_spr_zu;