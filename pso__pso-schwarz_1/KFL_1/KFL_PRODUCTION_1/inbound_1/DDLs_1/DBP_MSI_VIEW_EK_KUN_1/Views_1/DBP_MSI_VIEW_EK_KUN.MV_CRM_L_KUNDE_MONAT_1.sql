CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_KUN.MV_CRM_L_KUNDE_MONAT_1
--AP0150854/SPEC0175812 Neuanlage für Berechnung auf Monatsebene, nicht für Aktuell registrierte Kunden. 
--Kunden mit dat_abmeldung = '9999-12-31' werden im voraus berechnet, sofern Daten in dbp_data.tag_1 vorliegen
(
 crm_kunde_id
,dat_registrierung
,dat_abmeldung_original
,letzter_tag_monat_abmeldung
,dat_abmeldung_neu
,registrierungsfiliale_mandant_id
,kjmo
)
AS
SELECT
 v01.crm_kunde_id
,TO_DATE(v01.zeit_registrierung) AS dat_registrierung
,TO_DATE(v01.zeit_abmeldung) AS dat_abmeldung_original
--Ermittlung letzter Tag_1 des Monats aus Abmeldedatum
, DATEADD('DAY',-1, DATE_TRUNC('MONTH', DATEADD('DAY',31,DATE_TRUNC('MONTH',TO_DATE(v01.zeit_abmeldung)) ) ) ) AS letzter_tag_monat_abmeldung
--Ermittlung, ob Abmeldedatum <= dem letzten Tag_1 des Abmeldedatums entspricht. Wenn ja, dann wird als Abmeldedatum der Vormonat ermittelt und Kunde zählt nur bis zum Vormonat
,CASE WHEN TO_DATE(v01.zeit_abmeldung) <= letzter_tag_monat_abmeldung THEN DATEADD('DAY', -1, DATE_TRUNC('MONTH',TO_DATE(v01.zeit_abmeldung)) ) ELSE TO_DATE(v01.zeit_abmeldung) END AS dat_abmeldung_neu
,v01.registrierungsfiliale_mandant_id
,v02.kjmo
FROM DBP_VIEW.V_CRM_L_KUNDE_1 v01
JOIN DBP_VIEW.V_TAG_1 v02
WHERE v02.dat BETWEEN TO_DATE(v01.zeit_registrierung) AND dat_abmeldung_neu
--Begrenzung der Datenmenge 
AND akt_mo <= 0
GROUP BY 
 v01.crm_kunde_id
,TO_DATE(v01.zeit_registrierung)
,TO_DATE(v01.zeit_abmeldung)
,v01.registrierungsfiliale_mandant_id
,v02.kjmo;