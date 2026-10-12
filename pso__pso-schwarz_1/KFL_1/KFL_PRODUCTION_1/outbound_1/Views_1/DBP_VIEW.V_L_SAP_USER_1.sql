CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_sap_user_1 AS SELECT mandant_id,
 system_id,
 sap_user,
 gruppe_id
FROM kfl_production_dbp_data.l_sap_user_1;