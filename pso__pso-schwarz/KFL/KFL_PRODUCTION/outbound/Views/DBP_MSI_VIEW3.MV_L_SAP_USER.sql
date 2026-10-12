CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_sap_user (mandant_id, sap_user, gruppe_id) AS SELECT mandant_id
 ,
 sap_user,
 gruppe_id
FROM kfl_production_dbp_view.v_l_sap_user;