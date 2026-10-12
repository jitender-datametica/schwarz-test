CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_l_ersteller_rpw_1 (mandant_id, ersteller_id, sap_user, ecm_user
, ocr_user, ldap_user, vorname, nachname, kjmo_geb, auto_fg, system_id) AS SELECT mandant_id,
 ersteller_id,
 sap_user,
 ecm_user,
 ocr_user,
 ldap_user,
 vorname,
 nachname,
 kjmo_geb,
 auto_fg,
 7 AS system_id
FROM kfl_production_dbp_view.v_l_ersteller_rpw_1
WHERE mandant_id = 1
UNION DISTINCT
SELECT 1 AS mandant_id,
 0 AS ersteller_id,
 '' AS sap_user,
 '' AS ecm_user,
 '' AS ocr_user,
 '' AS ldap_user,
 'System generiert' AS vorname,
 'System generiert' AS nachname,
 0 AS kjmo_geb,
 0 AS auto_fg,
 7 AS system_id
FROM kfl_production_dbp_view.v_l_ersteller_rpw_1
GROUP BY mandant_id,
 ersteller_id,
 vorname,
 nachname,
 system_id;