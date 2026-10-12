create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_CRM_VORGANG(
	CRM_VORGANG_ID,
	TICKETNUMMER,
	VORGANGNUMMER,
	TICKET_TEXT,
	DAT_START,
	DAT_ENDE,
	DAT_AENDERUNG,
	WUP_ID,
	NB_ID,
	MANDANT_ID,
	CRM_PROZESS_ID,
	CRM_EMOTION_ID,
	CRM_EIGENMARKE_ID,
	CRM_EINGANGSKANAL_ID,
	ETIKETTEN_TEXT,
	CRM_PRIORITAET_ID,
	CRM_SCHAEDLINGSART_ID,
	CRM_STATUS_ID,
	FOTO_FG,
	FREMDKOERPER_FG,
	STANDARDLOESUNG_FG,
	ART_ID,
	GTIN_ID,
	CHARGE,
	GP_ART_ID,
	CRM_MAGICWORD_ID,
	DAT_BEST_BEFORE,
	ZEK_ID,
	GP_ID,
	SUBASSORTMENT,
	APOLLO,
	CRM_BRAND_ID,
	EBENE_3_ID,
	SEC_KZ,
	DAT_START_PROCESSING,
	DAT_END_PROCESSING,
	BEARBEITUNGSZEIT_SEK,
	BEARBEITUNGSZEIT_TAGE,
	VERWEILDAUER_SEK,
	ERSTLOESUNG_KUNDE_FLAG,
	ERSTLOESUNG_KUNDE_STD,
	ERSTLOESUNG_KUNDE_MIN,
	ERSTLOESUNG_INTERN_STD,
	BEARBEITUNGSZEIT_ABTEILUNGSSICHT_SEK
) as





















SELECT
   v01.crm_vorgang_id,
   v01.ticketnummer,
   v01.vorgangnummer,
   v01.ticket_text,
   TO_DATE(v01.dat_start) dat_start,
   TO_DATE(v01.dat_ende) dat_ende,
   v01.dat_aenderung,
   v03.aktuell_wup_id AS wup_id,
   v01.nb_id,
   v01.mandant_id,
   v01.crm_prozess_id,
   v01.crm_emotion_id,
   v01.crm_eigenmarke_id,
   v01.crm_eingangskanal_id,
   v01.etiketten_text,
   v01.crm_prioritaet_id,
   v01.crm_schaedlingsart_id,
   v01.crm_status_id,
   v01.foto_fg,
   v01.fremdkoerper_fg,
   v01.standardloesung_fg,
   v01.art_id,
   v01.gtin_id,
   v01.charge,
   v01.gp_art_id,
   v01.crm_magicword_id,
   v01.dat_best_before,
   v01.zek_id,
   v01.gp_id,
   v01.subassortment,
   v01.apollo,
   v01.crm_brand_id,
   
   v02.ebene_3_id,
   3::BYTEINT AS sec_kz,
   TO_DATE(v01.dat_start_processing) AS dat_start_processing,
   TO_DATE(v01.dat_end_processing) AS dat_end_processing,
   CASE WHEN dat_ende != '9999-12-31' THEN DATEDIFF('second',dat_start, dat_ende)
    ELSE NULL END AS bearbeitungszeit_Sek,
   
   CASE WHEN dat_ende != '9999-12-31' THEN DATEDIFF('day',dat_start, dat_ende)
    ELSE DATEDIFF('day',dat_start, CURRENT_DATE) END AS bearbeitungszeit_tage,
   CASE WHEN dat_start_processing != '1900-01-01'
    THEN DATEDIFF('second',dat_start,dat_start_processing )
    ELSE NULL END AS Verweildauer_sek,   
   CASE WHEN dat_start =  TO_DATE(dat_end_processing) THEN 1 ELSE 0 END AS Erstloesung_kunde_flag,
   
   DATEDIFF('hour', dat_start, dat_ende) AS Erstloesung_kunde_std,
   DATEDIFF('minute', dat_start, dat_ende) AS Erstloesung_kunde_min,
   DATEDIFF('hour', dat_start_processing, dat_ende) AS Erstloesung_intern_std,
   CASE WHEN dat_ende != '9999-12-31' THEN DATEDIFF('second',dat_start_processing, dat_ende)
    ELSE NULL END AS bearbeitungszeit_Abteilungssicht_Sek,

FROM dbp_view.v_crm_vorgang v01
INNER JOIN dbp_view.v_crm_l_themenbaum_lv2 v02
ON v01.crm_themenbaum_lv2_id = v02.crm_themenbaum_lv2_id

INNER JOIN  dbp_view.v_wup v03
ON v01.wup_id = v03.wup_id
AND v01.mandant_id = v03.mandant_id;