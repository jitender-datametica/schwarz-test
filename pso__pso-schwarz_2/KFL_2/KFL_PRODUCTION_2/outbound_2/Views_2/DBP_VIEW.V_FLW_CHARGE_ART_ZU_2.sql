CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_charge_art_zu_2 AS SELECT flw_art_id,
 charge_id,
 mandant_id,
 system_id,
 objekt_schluessel_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_charge_art_zu_2;