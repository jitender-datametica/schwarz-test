CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_ersteller_rpw AS SELECT system_id,
 mandant_id,
 ersteller_id,
 sap_user,
 ecm_user,
 ocr_user,
 ldap_user,
 vorname,
 nachname,
 kjmo_geb,
 auto_fg
FROM kfl_production_dbp_data.l_ersteller_rpw;