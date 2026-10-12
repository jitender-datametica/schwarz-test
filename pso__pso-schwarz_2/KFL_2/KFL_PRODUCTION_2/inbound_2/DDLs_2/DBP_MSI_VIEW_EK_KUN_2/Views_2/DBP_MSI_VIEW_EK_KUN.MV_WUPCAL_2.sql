CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_KUN.MV_WUPCAL_2
--SPEC0055903, mcie1607, 10/12/2019, new view
AS
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
FROM dbp_view.v_wupcal_2 v01
;