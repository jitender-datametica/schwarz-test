create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_L_ERSTELLER_RPW(
	MANDANT_ID,
	ERSTELLER_ID,
	SAP_USER,
	ECM_USER,
	OCR_USER,
	LDAP_USER,
	VORNAME,
	NACHNAME,
	KJMO_GEB,
	AUTO_FG,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
    SELECT
       mandant_id,
    ersteller_id,
    sap_user,
    ecm_user,
    ocr_user,
    ldap_user,
    vorname,
    nachname,
    kjmo_geb,
    auto_fg,
    7  AS system_id
    FROM dbp_view.v_l_ersteller_rpw
    WHERE mandant_id = 1

    UNION

    SELECT
      1 AS mandant_id,
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
    FROM dbp_view.v_l_ersteller_rpw
    GROUP BY 1,2,7,8,11
 ;
