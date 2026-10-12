CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_schnittliste_mat_kosten AS SELECT schnittliste_id,
 flw_art_id,
 input_material_typ_id,
 kosten_block_id,
 sek_schl_typ_id,
 sek_schl_id,
 mandant_id,
 intern_var_kosten,
 betrag_intern_var_kosten,
 wrg_id,
 system_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_schnittliste_mat_kosten;