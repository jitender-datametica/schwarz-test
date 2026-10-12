CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_l_bestellart_2 AS SELECT bestellart_id,
 mandant_id,
 bestell_typ_id,
 system_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_l_bestellart_2;