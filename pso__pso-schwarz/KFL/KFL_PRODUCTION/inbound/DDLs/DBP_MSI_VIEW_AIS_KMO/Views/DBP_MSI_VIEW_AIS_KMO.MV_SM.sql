CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_SM
-- SPEC0066356 Erweiterung um Alias ksm_id / sschuecke 04.12.2019
-- 08.07.2020 lsvi0303: AP0043104, SPEC0069749 Attribut Sortimentskategorie/K-Sortimentskategorie anpassen, ksm_id removed, ksst values in sm_id column
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU / ssch1303 02.02.2022
(
 mandant_id
,sm_id
,sm_kbez
,sm_bez
,sm_bez_de
,sm_bez_cz
,sm_bez_sk
,sm_bez_hr
,sm_bez_pl
,sm_bez_ro
,sm_bez_bg
,sap_sm_id
)

AS
SELECT
 mandant_id
,CAST(TRIM(CASE WHEN sm_id IN (11,12,13,14,15,16,17,18,19) THEN sap_sm_id ELSE CAST(sm_id AS VARCHAR(2)) END) AS VARCHAR(2)) AS sm_id
,CASE WHEN sm_id = '-1' THEN 'keine' ELSE CAST(sm_id AS VARCHAR(2)) END AS sm_kbez
,COALESCE(MAX(CASE WHEN spr_id = 22  THEN sm_bez END), 'N/A')  AS sm_bez
,COALESCE(MAX(CASE WHEN spr_id = 22  THEN sm_bez END), 'N/A')  AS sm_bez_de
,COALESCE(MAX(CASE WHEN spr_id = 124 THEN sm_bez END), sm_bez_de)  AS sm_bez_cz
,COALESCE(MAX(CASE WHEN spr_id = 108 THEN sm_bez END), sm_bez_de)  AS sm_bez_sk
,COALESCE(MAX(CASE WHEN spr_id = 65  THEN sm_bez END), sm_bez_de)  AS sm_bez_hr
,COALESCE(MAX(CASE WHEN spr_id = 90  THEN sm_bez END), sm_bez_de)  AS sm_bez_pl
,COALESCE(MAX(CASE WHEN spr_id = 95  THEN sm_bez END), sm_bez_de)  AS sm_bez_ro
,COALESCE(MAX(CASE WHEN spr_id = 18  THEN sm_bez END), sm_bez_de)  AS sm_bez_bg
,sap_sm_id

FROM dbp_view.v_sm

WHERE mandant_id <> 1
GROUP BY
 mandant_id
,sm_id
,sap_sm_id;