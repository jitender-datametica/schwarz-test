CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_auftragsart_spr_zu_2 AS SELECT auftragsart_id,
 mandant_id,
 spr_id,
 auftragsart_bez,
 system_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_auftragsart_spr_zu_2;