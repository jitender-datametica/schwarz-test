CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_schnitt_kosten_1 AS SELECT schnitt_id,
 sek_schl_typ_id,
 sek_schl_id,
 input_typ_id,
 kosten_block_id,
 mandant_id,
 fertig_einzel_kosten_kg,
 wrg_id,
 system_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_schnitt_kosten_1;