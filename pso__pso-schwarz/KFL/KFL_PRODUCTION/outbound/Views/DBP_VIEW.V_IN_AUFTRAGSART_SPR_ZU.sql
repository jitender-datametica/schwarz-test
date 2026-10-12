CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_auftragsart_spr_zu AS SELECT mandant_id,
 auftragsart_id,
 spr_id,
 auftragsart_bez,
 system_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.in_auftragsart_spr_zu;