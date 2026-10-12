CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_ARTKZ_POSTEN_SAP_SPR_ZU(
	MANDANT_ID,
	POSTEN_KZ_SAP,
	POSTEN_BEZ_SAP,
	POSTEN_BEZ_SAP_DE,
	POSTEN_BEZ_SAP_CZ,
	POSTEN_BEZ_SAP_SK,
	POSTEN_BEZ_SAP_HR,
	POSTEN_BEZ_SAP_PL,
	POSTEN_BEZ_SAP_RO,
	POSTEN_BEZ_SAP_BG
) AS
SELECT
mandant_id
,v01.posten_kz_sap
,COALESCE(MAX(CASE WHEN v01.spr_id = 22 THEN v01.posten_bez_sap END), 'nicht gepflegt')  AS posten_bez_sap
,COALESCE(MAX(CASE WHEN v01.spr_id = 22 THEN v01.posten_bez_sap END), 'nicht gepflegt')  AS posten_bez_sap_de
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.posten_bez_sap END),posten_bez_sap_de)   AS posten_bez_sap_cz
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.posten_bez_sap END),posten_bez_sap_de)   AS posten_bez_sap_sk
,COALESCE(MAX(CASE WHEN v01.spr_id = 65 THEN v01.posten_bez_sap END),posten_bez_sap_de)   AS posten_bez_sap_hr
,COALESCE(MAX(CASE WHEN v01.spr_id = 90 THEN v01.posten_bez_sap END),posten_bez_sap_de)   AS posten_bez_sap_pl
,COALESCE(MAX(CASE WHEN v01.spr_id = 95 THEN v01.posten_bez_sap END),posten_bez_sap_de)  AS posten_bez_sap_ro
,COALESCE(MAX(CASE WHEN v01.spr_id = 18 THEN v01.posten_bez_sap END),posten_bez_sap_de)  AS posten_bez_sap_bg
FROM DBP_VIEW.v_posten_kz_sap_spr_zu v01
GROUP BY 
 v01.mandant_id
,v01.posten_kz_sap

UNION

SELECT
v01.mandant_id
,v01.posten_id AS posten_kz_sap
,MAX(CASE WHEN v01.posten_id <> '' THEN v01.posten_bez ELSE 'nicht gepflegt' END) AS posten_bez_sap
,MAX(CASE WHEN v01.posten_id <> '' THEN v01.posten_bez ELSE 'nicht gepflegt' END) AS posten_bez_sap_de
,MAX(CASE WHEN v01.posten_id <> ''  THEN v01.posten_bez ELSE 'Posten není nastaven' END) AS posten_bez_sap_cz
,MAX(CASE WHEN v01.posten_id <> ''  THEN v01.posten_bez ELSE 'Posten nie je nastavený' END) AS posten_bez_sap_sk
,MAX(CASE WHEN v01.posten_id <> '' THEN v01.posten_bez ELSE 'Posten nije postavljeno' END) AS posten_bez_sap_hr
,MAX(CASE WHEN v01.posten_id <> '' THEN v01.posten_bez ELSE 'Posten nie jest ustawione' END) AS posten_bez_sap_pl
,MAX(CASE WHEN v01.posten_id <> '' THEN v01.posten_bez ELSE 'Posten nu este setat' END) AS posten_bez_sap_ro
,MAX(CASE WHEN v01.posten_id <> '' THEN v01.posten_bez ELSE CONCAT('->->-> ->->->->',' Posten') END) AS posten_bez_sap_bg
FROM DBP_VIEW.v_artkz_posten v01
WHERE v01.mandant_id = 1
GROUP BY v01.mandant_id
,v01.posten_id

UNION

SELECT
v01.mandant_id
,'' AS posten_kz_sap
,'nicht gepflegt' AS posten_bez_sap
,'nicht gepflegt' AS posten_bez_sap_de
,'Posten není nastaven' AS posten_bez_sap_cz
,'Posten nie je nastavený' AS posten_bez_sap_sk
,'Posten nije postavljeno' AS posten_bez_sap_hr
,'Posten nie jest ustawione' AS posten_bez_sap_pl
,'Posten nu este setat' AS posten_bez_sap_ro
,CONCAT('->->-> ->->->->',' Posten') AS posten_bez_sap_bg
FROM DBP_VIEW.v_mandant v01
WHERE v01.mandant_id <> 1;