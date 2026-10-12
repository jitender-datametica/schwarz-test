CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_bestellart_spr_zu AS SELECT bestellart_id,
 mandant_id,
 bestell_typ_id,
 spr_id,
 system_id,
 bestellart_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_bestellart_spr_zu;