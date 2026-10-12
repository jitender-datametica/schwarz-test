create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_KMR_MASSNAHME(
	AMX_SYSTEM_ID,
	MASSNAHME_ID,
	MASSNAHME_TXT,
	DAT_UMSETZUNG_ANGELEGT,
	DAT_UMSETZUNG_GEPLANT,
	ANTWORT_AUDITOR_ABWARTEND_FG,
	FESTSTELLUNG_ID,
	ZUSTAENDIGE_STELLE_ID,
	DAT_UMSETZUNG_ERLEDIGT,
	VERSCHIEBUNGEN_ANZ,
	MASSNAHME_STATUS_ID
) as
-- 20220112 twie: SPEC0173748 neue audimex View für Massnahme
-- 20230817 twie: SPEC0195708 neues Feld massnahme_status_id

SELECT 

 amx_system_id
,massnahme_id
,massnahme_txt
,dat_umsetzung_angelegt
,dat_umsetzung_geplant
,antwort_auditor_abwartend_fg
,feststellung_id
,zustaendige_stelle_id
,dat_umsetzung_erledigt
,verschiebungen_anz
,massnahme_status_id

FROM dbp_view.V_KMR_MASSNAHME;