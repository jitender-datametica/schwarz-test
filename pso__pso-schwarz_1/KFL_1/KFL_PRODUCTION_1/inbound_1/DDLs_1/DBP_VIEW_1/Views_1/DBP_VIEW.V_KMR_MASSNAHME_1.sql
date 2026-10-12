create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_KMR_MASSNAHME_1(
	AMX_SYSTEM_ID,
	MASSNAHME_ID,
	FESTSTELLUNG_ID,
	MASSNAHME_TXT,
	ZUSTAENDIGE_STELLE_ID,
	MASSNAHME_STATUS_ID,
	ANTWORT_AUDITOR_ABWARTEND_FG,
	DAT_UMSETZUNG_ANGELEGT,
	DAT_UMSETZUNG_GEPLANT,
	DAT_UMSETZUNG_ERLEDIGT,
	VERSCHIEBUNGEN_ANZ
) as 
    SELECT 
        amx_system_id,
        massnahme_id,
        feststellung_id,
        massnahme_txt,
        zustaendige_stelle_id,
        massnahme_status_id,
        antwort_auditor_abwartend_fg,
        dat_umsetzung_angelegt,
        dat_umsetzung_geplant,
        dat_umsetzung_erledigt,
        verschiebungen_anz

FROM DBP_DATA.KMR_MASSNAHME_1 ;
