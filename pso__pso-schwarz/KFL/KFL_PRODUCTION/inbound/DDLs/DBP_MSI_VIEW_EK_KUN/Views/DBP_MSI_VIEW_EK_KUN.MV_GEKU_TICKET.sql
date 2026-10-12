create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_EK_KUN.MV_GEKU_TICKET(
	GEKU_TICKET_ID,
	GEKU_ARTIKEL_UID,
	BESCHWERDE_ANTWORT_ID,
	ABSCHLUSSGRUND_ID,
	WMD_AGENTUR,
	WMD_AUSTRAEGER_GEBIET_UID,
	GEKU_EINGANGSKANAL_ID,
	GEKU_EMOTION_ID,
	DAT_START,
	DAT_ENDE,
	WMD_KUNDE,
	WUP_ID,
	NB_ID,
	MANDANT_ID,
	KUNDE_PLZ,
	KUNDE_STRASSE,
	KUNDE_LAND_ID,
	DAT_ZUFRIEDENHEIT_ABFRAGE,
	KUNDE_ORT,
	KUNDE_VIERTEL,
	GEKU_ANTWORTKANAL_ID,
	GEKU_PRIORITAET_ID,
	AUTO_ZWISCHENBESCHEID_FG,
	MEHRFACHANLIEGEN_NR,
	GEKU_MZK_GRUND_UID,
	GEKU_TEAM_ID,
	GEKU_SCHR_BEREICH_PERSON_ID,
	GEKU_STICHWORT,
	GEKU_STICHWORT_UID,
	MANDANT_ID_MZK,
	GEKU_STATUS_ID,
	IDEE_FG,
	DAT_NON_PERS_ANON,
	DAT_PERS_ANON
) as
   SELECT
   -- STRY0048932 Umzug aus KMR nach EK_KUNDE / sschuecke 30.03.2026
    geku_ticket_id
   ,geku_artikel_uid
   ,beschwerde_antwort_id
   ,abschlussgrund_id
   ,wmd_agentur
   ,wmd_austraeger_gebiet_uid
   ,geku_eingangskanal_id
   ,geku_emotion_id
   ,dat_start
   ,dat_ende
   ,wmd_kunde
   ,COALESCE(wup_id, 0) AS wup_id
   ,CASE WHEN wup_id IS NULL THEN -1 ELSE nb_id END AS nb_id
   ,CASE WHEN wup_id IS NULL THEN mandant_id ELSE mandant_id_wup END AS mandant_id
   ,kunde_plz
   ,kunde_strasse
   ,kunde_land_id
   ,dat_zufriedenheit_abfrage
   ,kunde_ort
   ,kunde_viertel
   ,geku_antwortkanal_id
   ,geku_prioritaet_id
   ,auto_zwischenbescheid_fg
   ,mehrfachanliegen_nr
   ,geku_mzk_grund_uid
   ,geku_team_id
   ,geku_schr_bereich_person_id
   ,'' AS geku_stichwort --temporär
   ,geku_stichwort_uid
   ,mandant_id_mzk
   ,geku_status_id
   ,COALESCE(idee_fg, 0) AS idee_fg
   ,dat_non_pers_anon
   ,dat_pers_anon
   FROM DBP_DATA.GEKU_TICKET;
