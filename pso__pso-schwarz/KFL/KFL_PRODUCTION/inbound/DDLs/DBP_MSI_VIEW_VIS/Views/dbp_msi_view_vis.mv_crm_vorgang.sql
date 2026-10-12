CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_CRM_VORGANG
(
	CRM_VORGANG_ID,
	TICKETNUMMER,
	VORGANGNUMMER,
	TICKET_TEXT,
	DAT_START,
	DAT,
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
	EBENE_3_ID
) AS 

	-- 2021-11-18 snik1809 - created dat for Snowflake
	-- 2022-08-09 ssch0611 : removed crm_fremdkoerper_id INC5129840
	-- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]

SELECT
 v01.crm_vorgang_id
 , v01.ticketnummer
 , v01.vorgangnummer
 , v01.ticket_text
 , v01.dat_start
 , v01.dat_start :: DATE 															AS dat
 , v01.dat_ende
 , v01.dat_aenderung
 , wup.aktuell_wup_id 																AS wup_id
 , v01.nb_id
 , v01.mandant_id
 , v01.crm_prozess_id
 , v01.crm_emotion_id
 , v01.crm_eigenmarke_id
 , v01.crm_eingangskanal_id
 , v01.etiketten_text
 , v01.crm_prioritaet_id
 , v01.crm_schaedlingsart_id
 , v01.crm_status_id
 , v01.foto_fg
 , v01.fremdkoerper_fg
 , v01.standardloesung_fg
 , v02.ebene_3_id
FROM dbp_view.v_crm_vorgang v01

INNER JOIN dbp_view.v_crm_l_themenbaum_lv2 v02
ON v01.crm_themenbaum_lv2_id = v02.crm_themenbaum_lv2_id

INNER JOIN dbp_view.v_wup wup
ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id
;