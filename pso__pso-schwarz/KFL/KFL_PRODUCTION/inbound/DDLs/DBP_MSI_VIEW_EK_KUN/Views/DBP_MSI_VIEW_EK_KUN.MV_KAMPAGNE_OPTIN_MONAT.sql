CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_KUN.MV_KAMPAGNE_OPTIN_MONAT
(
	CRM_OPTIN_KANAL_ID,
	MANDANT_ID,
	KJMO,
	KUM_MONAT_TOTAL,
	KUM_MONAT_NOT_GRANTED,
	KUM_MONTAT_GRANTED
) 
AS

--Auf Monatsebene für den Overview: 

WITH optin_kjmo AS
(SELECT    
    a14.kjmo,
    a11.crm_optin_kanal_cd     AS optin_kanal_id,
    a15.crm_optin_kanal_bez    AS optin_kanal_bez,
    a13.crm_optin_statusgrund_cd   AS optin_statusgrund_id,
    a17.crm_optin_statusgrund_bez AS  optin_statusgrund_bez,
    a14.kunde_mandant_id  mandant_id,
    a14.crm_kunde_id crm_kunde_id,
    CASE WHEN a17.crm_optin_statusgrund_cd IN ('inquired','notGranted','inactive')  THEN a14.crm_kunde_id ELSE NULL END AS not_granted_user,
    CASE WHEN a17.crm_optin_statusgrund_cd = 'granted' THEN a14.crm_kunde_id ELSE NULL END AS granted_user,
    FROM    dbp_data.crm_l_optin    a11
    JOIN    dbp_data.crm_kunde_optin_zu    a13
      ON     (a11.crm_optin_id = a13.crm_optin_id)
    JOIN    (
 SELECT 
 v01.crm_kunde_id
,TO_DATE(v01.zeit_registrierung) AS dat_registrierung
,TO_DATE(v01.zeit_abmeldung) AS dat_abmeldung_original
--Ermittlung letzter Tag des Monats aus Abmeldedatum
, DATEADD('DAY',-1, DATE_TRUNC('MONTH', DATEADD('DAY',31,DATE_TRUNC('MONTH',TO_DATE(v01.zeit_abmeldung)) ) ) ) AS letzter_tag_monat_abmeldung
--Ermittlung, ob Abmeldedatum <= dem letzten Tag des Abmeldedatums entspricht. Wenn ja, dann wird als Abmeldedatum der Vormonat ermittelt und Kunde zählt nur bis zum Vormonat
,CASE WHEN TO_DATE(v01.zeit_abmeldung) <= letzter_tag_monat_abmeldung THEN DATEADD('DAY', -1, DATE_TRUNC('MONTH',TO_DATE(v01.zeit_abmeldung)) ) ELSE TO_DATE(v01.zeit_abmeldung) END AS dat_abmeldung_neu
,v01.kunde_mandant_id
,v02.kjmo
FROM dbp_data.CRM_L_KUNDE v01
JOIN dbp_data.TAG v02
WHERE v02.kjmo BETWEEN SUBSTR(REPLACE(DATEADD('YEAR',0, DATE_TRUNC('MONTH',TO_DATE(v01.zeit_registrierung))), '-'),1,6) AND  SUBSTR(REPLACE(DATEADD('YEAR',0, DATE_TRUNC('MONTH',TO_DATE(dat_abmeldung_neu))), '-'),1,6)
--Begrenzung der Datenmenge 
AND akt_mo <= 0
GROUP BY ALL
ORDER BY kjmo)a14
ON (a13.crm_kunde_id = a14.crm_kunde_id)
    JOIN    dbp_data.crm_optin_kanal_spr_zu    a15
      ON     (a11.crm_optin_kanal_cd = a15.crm_optin_kanal_cd)
    JOIN    dbp_data.crm_optin_statusgrund_spr_zu    a17
      ON     (a13.crm_optin_statusgrund_cd = a17.crm_optin_statusgrund_cd)
 WHERE a11.crm_optin_kanal_cd IN ('emailLoyalty','smsLoyalty') 
 )

 SELECT 
 optin_kjmo.optin_kanal_id,
 optin_kjmo.mandant_id,
 optin_kjmo.kjmo,
 COUNT(DISTINCT optin_kjmo.crm_kunde_id),
 COUNT(DISTINCT optin_kjmo.not_granted_user),
 COUNT(DISTINCT optin_kjmo.granted_user)
 FROM optin_kjmo
 GROUP BY ALL
 ;