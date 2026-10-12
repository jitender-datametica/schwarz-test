CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_ARTKZ_POSTEN_SAP_SPR_ZU
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU / ssch1303 02.02.2022
(
 mandant_id
,posten_kz_sap
,posten_bez_sap
,posten_bez_sap_de
,posten_bez_sap_cz
,posten_bez_sap_sk
,posten_bez_sap_hr
,posten_bez_sap_pl
,posten_bez_sap_ro
,posten_bez_sap_bg
)

AS
SELECT
 v1.mandant_id
,v1.posten_kz_sap
,COALESCE(MAX(CASE WHEN v1.spr_id = 22  THEN v1.posten_bez_sap END), 'nicht gepflegt')  AS posten_bez_sap
,COALESCE(MAX(CASE WHEN v1.spr_id = 22  THEN v1.posten_bez_sap END), 'nicht gepflegt')  AS posten_bez_sap_de
,COALESCE(MAX(CASE WHEN v1.spr_id = 124 THEN v1.posten_bez_sap END),posten_bez_sap_de)  AS posten_bez_sap_cz
,COALESCE(MAX(CASE WHEN v1.spr_id = 108 THEN v1.posten_bez_sap END),posten_bez_sap_de)  AS posten_bez_sap_sk
,COALESCE(MAX(CASE WHEN v1.spr_id = 65  THEN v1.posten_bez_sap END),posten_bez_sap_de)  AS posten_bez_sap_hr
,COALESCE(MAX(CASE WHEN v1.spr_id = 90  THEN v1.posten_bez_sap END),posten_bez_sap_de)  AS posten_bez_sap_pl
,COALESCE(MAX(CASE WHEN v1.spr_id = 95  THEN v1.posten_bez_sap END),posten_bez_sap_de)  AS posten_bez_sap_ro
,COALESCE(MAX(CASE WHEN v1.spr_id = 18  THEN v1.posten_bez_sap END),posten_bez_sap_de)  AS posten_bez_sap_bg
FROM dbp_view.v_posten_kz_sap_spr_zu v1
WHERE v1.mandant_id <> 1
GROUP BY
 v1.mandant_id
,v1.posten_kz_sap

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