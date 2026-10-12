CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_sap_steuersatz_1 AS SELECT mandant_id,
 steuer_typ_id,
 sap_steuer_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_sap_steuersatz_1;