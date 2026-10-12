CREATE OR REPLACE VIEW DBP_MSI_VIEW_QS.MV_CHECK_KUNDEN_UMSATZ_1
(
dat
, mandant_id
, wup_id
, nb_id
, anz_bon_sap
, umsatz_brutto_gesamt
, umsatz_netto_gesamt
, umsatz_brutto_kasse
)
AS
SELECT
v01.dat
, v01.mandant_id
, v01.wup_id
, v02.nb_id
, SUM(v01.anz_bon_sap) AS anz_bon_sap
, SUM(v01.umsatz_brutto_gesamt) AS umsatz_brutto_gesamt
, SUM(v01.umsatz_netto_gesamt) AS umsatz_netto_gesamt
, SUM(v01.umsatz_brutto_kasse) AS umsatz_brutto_kasse

FROM dbp_msi_v_view.v_check_kunden_umsatz_1 v01

JOIN dbp_view.v_wup_1 v02
ON v01.wup_id = v02.wup_id
AND v01.mandant_id = v02.mandant_id

GROUP BY 1,2,3,4;