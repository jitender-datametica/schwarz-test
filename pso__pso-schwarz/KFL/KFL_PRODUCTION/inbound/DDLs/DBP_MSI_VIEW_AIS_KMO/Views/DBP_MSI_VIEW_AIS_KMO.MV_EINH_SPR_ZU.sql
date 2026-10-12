CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_EINH_SPR_ZU
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU / ssch1303 02.02.2022
(
 mandant_id
,einh_id
,einh_bez_kaufm
,einh_bez_kaufm_de
,einh_bez_kaufm_cz
,einh_bez_kaufm_sk
,einh_bez_kaufm_hr
,einh_bez_kaufm_pl
,einh_bez_kaufm_ro
,einh_bez_kaufm_bg
 )
AS
SELECT
 v01.mandant_id
,v01.einh_id
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.einh_bez_kaufm END), 'N/A') AS einh_bez_kaufm
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.einh_bez_kaufm END), 'N/A') AS einh_bez_kaufm_de
,COALESCE(Max(CASE WHEN v01.spr_id = 124 THEN v01.einh_bez_kaufm END), einh_bez_kaufm_de) AS einh_bez_kaufm_cz
,COALESCE(Max(CASE WHEN v01.spr_id = 108 THEN v01.einh_bez_kaufm END), einh_bez_kaufm_de) AS einh_bez_kaufm_sk
,COALESCE(Max(CASE WHEN v01.spr_id =  65 THEN v01.einh_bez_kaufm END), einh_bez_kaufm_de) AS einh_bez_kaufm_hr
,COALESCE(Max(CASE WHEN v01.spr_id =  90 THEN v01.einh_bez_kaufm END), einh_bez_kaufm_de) AS einh_bez_kaufm_pl
,COALESCE(Max(CASE WHEN v01.spr_id =  95 THEN v01.einh_bez_kaufm END), einh_bez_kaufm_de) AS einh_bez_kaufm_ro
,COALESCE(Max(CASE WHEN v01.spr_id =  18 THEN v01.einh_bez_kaufm END), einh_bez_kaufm_de) AS einh_bez_kaufm_bg

FROM dbp_view.v_einh_spr_zu v01
WHERE v01.mandant_id <> 1
GROUP BY 
 v01.mandant_id
,v01.einh_id;