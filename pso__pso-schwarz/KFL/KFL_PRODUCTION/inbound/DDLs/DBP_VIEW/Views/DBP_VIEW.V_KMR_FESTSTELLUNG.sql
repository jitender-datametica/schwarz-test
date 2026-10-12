create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_KMR_FESTSTELLUNG(
	AMX_SYSTEM_ID,
	FESTSTELLUNG_ID,
	FRAGE_ID,
	FESTSTELLUNG_BEZ,
	FESTSTELLUNG_TEXT,
	FESTSTELLUNG_GEWICHTUNG_ID,
	COMPLIANCE_FG,
	BERICHTSRELEVANT_FG,
	EFFIZIENZ_FG,
	WIEDERKEHREND_FG
) as 
    SELECT 
        amx_system_id
        ,feststellung_id
        ,frage_id
        ,feststellung_bez
        ,feststellung_text
        ,feststellung_gewichtung_id
        ,compliance_fg
        ,berichtsrelevant_fg
        ,effizienz_fg
        ,wiederkehrend_fg


FROM DBP_DATA.KMR_FESTSTELLUNG ;
