CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_schnitt_output_det_1 AS SELECT schnitt_id,
 sek_schl_typ_id,
 sek_schl_id,
 schnitt_pos_id,
 mandant_id,
 system_id,
 flw_art_id,
 menge_schnitt,
 wrg_id,
 betrag_schnitt_output,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_schnitt_output_det_1;