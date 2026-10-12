CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_l_auftragsart AS SELECT auftragsart_id,
 mandant_id,
 system_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.in_l_auftragsart;