create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_WUPCAL(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	DAT,
	OFFEN,
	WERBEWOCHE,
	DATENLIEFERUNG_ARTBEW_WG_SUM,
	BONANZAHL,
	DATENLIEFERUNG_BONANZAHL,
	BONANZAHL_MISVIER,
	DATENLIEFERUNG_MISVIER,
	DATENLIEFERUNG_ARTBEW,
	DATENLIEFERUNG_QBM_STATUS,
	BONANZAHL_IMBISS,
	PRUEF_STATUS_ID_UMSATZ,
	PRUEF_STATUS_ID_KUNDE,
	PRUEF_GRUND_ID_UMSATZ,
	PRUEF_GRUND_ID_KUNDE,
	DAT_EXTRAKT_UMSATZ,
	OFFEN_VON,
	OFFEN_BIS,
	BONANZAHL_SUG,
	UMSATZ_BRUTTO_ODS_VERKAUF,
	UMSATZ_BRUTTO_ODS_KASSENABSCHLUSS,
	BONANZAHL_KUNDENKARTE,
	OFFEN_THEKE_VON,
	OFFEN_THEKE_BIS,
	BONANZAHL_SUG_KASSENABSCHLUSS,
	SSM_UMSATZ_FAKTOR
) as

SELECT v01.mandant_id,


v05.aktuell_wup_id,
v01.nb_id,
dat,
offen,
werbewoche,
datenlieferung_artbew_wg_sum,
bonanzahl,
datenlieferung_bonanzahl,
bonanzahl_misvier,
datenlieferung_misvier,
datenlieferung_artbew,
datenlieferung_qbm_status,
bonanzahl_imbiss,
pruef_status_id_umsatz,
pruef_status_id_kunde,
pruef_grund_id_umsatz,
pruef_grund_id_kunde,
dat_extrakt_umsatz,
offen_von,
offen_bis,
bonanzahl_sug,
umsatz_brutto_ods_verkauf,
umsatz_brutto_ods_kassenabschluss,
bonanzahl_kundenkarte,
OFFEN_THEKE_VON,
OFFEN_THEKE_BIS,
BONANZAHL_SUG_KASSENABSCHLUSS,
SSM_UMSATZ_FAKTOR 
FROM dbp_view.v_wupcal v01
LEFT JOIN dbp_view.v_wup v05
   ON v05.mandant_id = v01.mandant_id 
   
   AND v05.wup_id = v01.wup_id
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0));