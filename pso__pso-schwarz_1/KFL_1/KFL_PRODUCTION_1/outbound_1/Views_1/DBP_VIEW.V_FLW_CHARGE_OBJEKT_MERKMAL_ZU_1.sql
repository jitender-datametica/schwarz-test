CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_charge_objekt_merkmal_zu_1 AS SELECT mandant_id,
 objekt_nummer_id,
 int_merkmal_id,
 dat_wert,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_charge_objekt_merkmal_zu_1;