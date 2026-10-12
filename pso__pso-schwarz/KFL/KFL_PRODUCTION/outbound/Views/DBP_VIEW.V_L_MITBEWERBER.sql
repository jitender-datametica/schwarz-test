CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_mitbewerber AS SELECT mandant_id,
 mitbewerber_id,
 sap_mitbewerber_id
FROM kfl_production_dbp_data.l_mitbewerber;