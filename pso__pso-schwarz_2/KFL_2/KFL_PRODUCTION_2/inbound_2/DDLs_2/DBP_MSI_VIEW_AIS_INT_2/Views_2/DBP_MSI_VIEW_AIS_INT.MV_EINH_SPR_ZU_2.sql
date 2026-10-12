CREATE OR REPLACE VIEW dbp_msi_view_ais_int.mv_einh_spr_zu_2
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU_2 / ssch1303 24.01.2022
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
FROM dbp_view.v_einh_spr_zu_2 v01
--JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
--ON v01.spr_id = v02.spr_id
GROUP BY 
 v01.mandant_id
,v01.einh_id;