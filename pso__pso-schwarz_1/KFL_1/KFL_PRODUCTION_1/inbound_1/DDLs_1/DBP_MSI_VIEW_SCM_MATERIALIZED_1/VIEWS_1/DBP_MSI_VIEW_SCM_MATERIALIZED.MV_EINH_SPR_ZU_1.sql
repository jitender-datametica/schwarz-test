create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_EINH_SPR_ZU_1(
	EINH_ID,
	EINH_BEZ_KAUFM,
	EINH_BEZ_KAUFM_DE,
	EINH_BEZ_KAUFM_CZ,
	EINH_BEZ_KAUFM_SK,
	EINH_BEZ_KAUFM_HR,
	EINH_BEZ_KAUFM_PL,
	EINH_BEZ_KAUFM_RO,
	EINH_BEZ_KAUFM_BG
) as


SELECT
 
 v01.einh_id
,COALESCE(MAX(CASE WHEN v01.spr_id =  22 THEN v01.einh_bez_kaufm END), 'N/A') AS einh_bez_kaufm
,COALESCE(MAX(CASE WHEN v01.spr_id =  22 THEN v01.einh_bez_kaufm END), 'N/A') AS einh_bez_kaufm_de
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.einh_bez_kaufm END), einh_bez_kaufm_de) AS einh_bez_kaufm_cz
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.einh_bez_kaufm END), einh_bez_kaufm_de) AS einh_bez_kaufm_sk
,COALESCE(MAX(CASE WHEN v01.spr_id =  65 THEN v01.einh_bez_kaufm END), einh_bez_kaufm_de) AS einh_bez_kaufm_hr
,COALESCE(MAX(CASE WHEN v01.spr_id =  90 THEN v01.einh_bez_kaufm END), einh_bez_kaufm_de) AS einh_bez_kaufm_pl
,COALESCE(MAX(CASE WHEN v01.spr_id =  95 THEN v01.einh_bez_kaufm END), einh_bez_kaufm_de) AS einh_bez_kaufm_ro
,COALESCE(MAX(CASE WHEN v01.spr_id =  18 THEN v01.einh_bez_kaufm END), einh_bez_kaufm_de) AS einh_bez_kaufm_bg

FROM dbp_view.v_einh_spr_zu_1 v01

GROUP BY

v01.einh_id;