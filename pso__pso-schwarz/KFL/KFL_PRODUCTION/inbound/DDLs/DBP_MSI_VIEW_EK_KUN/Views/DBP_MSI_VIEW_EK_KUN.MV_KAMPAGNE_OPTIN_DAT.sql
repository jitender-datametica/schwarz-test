CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_KUN.MV_KAMPAGNE_OPTIN_DAT
(
	MANDANT_ID,
	DAT,
	KJMO,
	CRM_OPTIN_KANAL_ID,
	KUM_MONAT_TOTAL,
	KUM_MONAT_NOT_GRANTED,
	KUM_MONTAT_GRANTED
) 
AS

WITH optin_dat AS
(SELECT
a14.dat,
a14.kjmo,
a11.crm_optin_kanal_cd AS crm_optin_kanal_id,
a15.crm_optin_kanal_bez,
a13.crm_optin_statusgrund_cd AS optin_statusgrund_id,
a17.crm_optin_statusgrund_bez AS optin_statusgrund_bez,
a14.kunde_mandant_id AS mandant_id,
a14.crm_kunde_id,
CASE WHEN a17.crm_optin_statusgrund_cd IN ('inquired','notGranted','inactive') THEN a14.crm_kunde_id ELSE NULL END AS not_granted_user,
CASE WHEN a17.crm_optin_statusgrund_cd = 'granted' THEN a14.crm_kunde_id ELSE NULL END AS granted_user,
FROM dbp_data.crm_l_optin a11
JOIN dbp_data.crm_kunde_optin_zu a13
ON (a11.crm_optin_id = a13.crm_optin_id)
JOIN (
SELECT v01.crm_kunde_id,
v01.kunde_mandant_id,
v02.dat,
v02.kjmo,
TO_DATE(v01.zeit_registrierung) AS dat_registrierung,
TO_DATE(v01.zeit_abmeldung) AS abmeldung_orginal,
FROM dbp_data.crm_l_kunde v01
JOIN dbp_data.tag v02
WHERE v02.dat BETWEEN dat_registrierung AND abmeldung_orginal
AND abmeldung_orginal > CURRENT_DATE AND dat_registrierung <= CURRENT_DATE
--Begrenzung der Datenmenge 
AND v02.akt_mo <= 0
GROUP BY ALL
)a14
ON (a13.crm_kunde_id = a14.crm_kunde_id)
JOIN dbp_data.crm_optin_kanal_spr_zu a15
ON (a11.crm_optin_kanal_cd = a15.crm_optin_kanal_cd)
JOIN dbp_data.crm_optin_statusgrund_spr_zu a17
ON (a13.crm_optin_statusgrund_cd = a17.crm_optin_statusgrund_cd)

WHERE a11.crm_optin_kanal_cd IN ('emailLoyalty','smsLoyalty')
GROUP BY ALL)

SELECT
mandant_id,
dat,
kjmo,
crm_optin_kanal_id,
COUNT(DISTINCT crm_kunde_id),
COUNT(DISTINCT not_granted_user),
COUNT(DISTINCT granted_user)
FROM optin_dat
GROUP BY ALL;
