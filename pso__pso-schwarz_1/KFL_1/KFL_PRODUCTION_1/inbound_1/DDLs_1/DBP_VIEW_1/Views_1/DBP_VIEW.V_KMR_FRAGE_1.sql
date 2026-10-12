create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_KMR_FRAGE_1(
	AMX_SYSTEM_ID,
	FRAGE_ID,
	KAPITEL_ID,
	SORT_NR,
	FRAGE_TEXT,
	ANMERKUNG,
	FRAGE_STATUS_ID,
	FRAGE_TYP_ID,
	STICHPROBE_UMFANG,
	ERGEBNIS_NUM,
	ERGEBNIS_TEXT,
	ERGEBNIS_MAN,
	AUFGEDECKTE_FEHLER_ANZ,
	FESTSTELLUNGEN_ANZ,
	MASSNAHMEN_ANZ
) as 
    SELECT 
        amx_system_id
        ,frage_id
        ,kapitel_id
        ,sort_nr
        ,frage_text
        ,anmerkung
        ,frage_status_id
        ,frage_typ_id
        ,stichprobe_umfang
        ,ergebnis_num
        ,ergebnis_text
        ,ergebnis_man
        ,aufgedeckte_fehler_anz
        ,feststellungen_anz
        ,massnahmen_anz


FROM DBP_DATA.KMR_FRAGE_1 ;
