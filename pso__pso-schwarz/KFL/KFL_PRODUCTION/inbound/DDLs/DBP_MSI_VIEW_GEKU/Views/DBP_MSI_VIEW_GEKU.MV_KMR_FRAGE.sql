CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_KMR_FRAGE
(
	AMX_SYSTEM_ID,
	FRAGE_ID,
	SORT_NR,
	FRAGE_TEXT,
	ANMERKUNG,
	KAPITEL_ID,
	FRAGE_STATUS_ID,
	FRAGE_TYP_ID,
	STICHPROBE_UMFANG,
	ERGEBNIS_NUM,
	ERGEBNIS_TEXT,
	ERGEBNIS_MAN,
	AUFGEDECKTE_FEHLER_ANZ,
	FESTSTELLUNGEN_ANZ,
	MASSNAHMEN_ANZ
) AS
-- 20221116 twie: SPEC0166860 neue audimex View für Frage

SELECT 

 amx_system_id
,frage_id
,sort_nr
,frage_text
,anmerkung
,kapitel_id
,frage_status_id
,frage_typ_id
,stichprobe_umfang
,ergebnis_num
,ergebnis_text
,ergebnis_man
,aufgedeckte_fehler_anz
,feststellungen_anz
,massnahmen_anz

FROM dbp_view.V_KMR_FRAGE;