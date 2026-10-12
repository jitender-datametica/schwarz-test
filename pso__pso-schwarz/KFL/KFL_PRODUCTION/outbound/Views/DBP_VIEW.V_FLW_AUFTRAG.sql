CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_auftrag AS SELECT auftrag_id,
 mandant_id,
 auftragsart_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_auftrag;