CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_CRM_L_KUNDE_MONAT_1(
	CRM_KUNDE_ID,
	CRM_KONTO_TYP_ID,
	DAT_REGISTRIERUNG,
	DAT_ABMELDUNG_ORIGINAL,
	LETZTER_TAG_MONAT_ABMELDUNG,
	DAT_ABMELDUNG_NEU,
	REGISTRIERUNGSFILIALE_MANDANT_ID,
	KJMO
) AS
SELECT
 v01.crm_kunde_id
,v02.crm_konto_typ_id
,TO_DATE(v01.zeit_registrierung) AS dat_registrierung
,TO_DATE(v01.zeit_abmeldung) AS dat_abmeldung_original
--Ermittlung letzter Tag_1 des Monats aus Abmeldedatum
, DATEADD('DAY',-1, DATE_TRUNC('MONTH', DATEADD('DAY',31,DATE_TRUNC('MONTH',TO_DATE(v01.zeit_abmeldung)) ) ) ) AS letzter_tag_monat_abmeldung
--Ermittlung, ob Abmeldedatum <= dem letzten Tag_1 des Abmeldedatums entspricht. Wenn ja, dann wird als Abmeldedatum der Vormonat ermittelt und Kunde zählt nur bis zum Vormonat
,CASE WHEN TO_DATE(v01.zeit_abmeldung) <= letzter_tag_monat_abmeldung THEN DATEADD('DAY', -1, DATE_TRUNC('MONTH',TO_DATE(v01.zeit_abmeldung)) ) ELSE TO_DATE(v01.zeit_abmeldung) END AS dat_abmeldung_neu
,v01.registrierungsfiliale_mandant_id
,v03.kjmo
FROM DBP_VIEW.V_CRM_L_KUNDE_1 v01
-- wegen Ermittlung Kontotyp (digital oder Physisch)
JOIN DBP_VIEW.V_CRM_L_KONTO_1 v02
ON v01.crm_kunde_id = v02.crm_kunde_id
JOIN DBP_VIEW.V_TAG_1 v03
WHERE v03.dat BETWEEN TO_DATE(v01.zeit_registrierung) AND dat_abmeldung_neu
--Begrenzung der Datenmenge 
AND akt_mo <= 0
GROUP BY 
 v01.crm_kunde_id
,v02.crm_konto_typ_id
,TO_DATE(v01.zeit_registrierung)
,TO_DATE(v01.zeit_abmeldung)
,v01.registrierungsfiliale_mandant_id
,v03.kjmo;