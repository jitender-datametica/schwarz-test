create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_KUN.MV_WUPCAL_1(
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
	BONANZAHL_KUNDENKARTE
) as
SELECT 
v01.mandant_id
,v01.wup_id
,v01.nb_id
,v01.dat
,v01.offen
,v01.werbewoche
,v01.datenlieferung_artbew_wg_sum
,v01.bonanzahl
,v01.datenlieferung_bonanzahl
,v01.bonanzahl_misvier
,v01.datenlieferung_misvier
,v01.datenlieferung_artbew
,v01.datenlieferung_qbm_status
,v01.bonanzahl_imbiss
,v01.pruef_status_id_umsatz
,v01.pruef_status_id_kunde
,v01.pruef_grund_id_umsatz
,v01.pruef_grund_id_kunde
,v01.dat_extrakt_umsatz
,v01.offen_von
,v01.offen_bis
,v01.bonanzahl_sug
--fehlende Währungsumrechnung
--,v01.umsatz_brutto_ods_verkauf
--,v01.umsatz_brutto_ods_kassenabschluss
,v01.bonanzahl_kundenkarte
--Field bonanzahl_kundenkarte is not used as a fact in EK Kunde. This field also contains payback card in summation. 
--The field shouldn't be used as a fact in EK Kunde, since it contains Payback
FROM dbp_view.v_wupcal_1 v01
;