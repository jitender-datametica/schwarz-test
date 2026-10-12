CREATE OR REPLACE VIEW kfl_production_dbp_view.v_artkz_esb_2 (esb_id, mandant_id, spr_id, esb_bez, td_update, td_insert)
AS SELECT esb_id,
 mandant_id,
 spr_id,
 esb_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.artkz_esb_2;