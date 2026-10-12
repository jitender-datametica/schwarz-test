CREATE OR REPLACE VIEW kfl_production_dbp_view.v_sap_steuersatz_spr_zu AS SELECT mandant_id,
 steuer_typ_id,
 sap_steuer_id,
 spr_id,
 sap_steuer_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.sap_steuersatz_spr_zu;