CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_EINH_SPR_ZU(
	
	EINH_ID,
	EINH_BEZ_KAUFM,
	EINH_BEZ_KAUFM_DE,
	EINH_BEZ_KAUFM_CZ,
	EINH_BEZ_KAUFM_SK,
	EINH_BEZ_KAUFM_HR,
	EINH_BEZ_KAUFM_PL,
	EINH_BEZ_KAUFM_RO,
	EINH_BEZ_KAUFM_BG
) AS
--2024-04-22, AP0179753, dknop, initial
--2024-11-19, dknop, removing mandant_id
SELECT
 --v01.mandant_id
 v01.einh_id
,COALESCE(MAX(CASE WHEN v01.spr_id =  22 THEN v01.einh_bez_kaufm END), 'N/A') AS einh_bez_kaufm
,COALESCE(MAX(CASE WHEN v01.spr_id =  22 THEN v01.einh_bez_kaufm END), 'N/A') AS einh_bez_kaufm_de
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.einh_bez_kaufm END), einh_bez_kaufm_de) AS einh_bez_kaufm_cz
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.einh_bez_kaufm END), einh_bez_kaufm_de) AS einh_bez_kaufm_sk
,COALESCE(MAX(CASE WHEN v01.spr_id =  65 THEN v01.einh_bez_kaufm END), einh_bez_kaufm_de) AS einh_bez_kaufm_hr
,COALESCE(MAX(CASE WHEN v01.spr_id =  90 THEN v01.einh_bez_kaufm END), einh_bez_kaufm_de) AS einh_bez_kaufm_pl
,COALESCE(MAX(CASE WHEN v01.spr_id =  95 THEN v01.einh_bez_kaufm END), einh_bez_kaufm_de) AS einh_bez_kaufm_ro
,COALESCE(MAX(CASE WHEN v01.spr_id =  18 THEN v01.einh_bez_kaufm END), einh_bez_kaufm_de) AS einh_bez_kaufm_bg

FROM dbp_view.v_einh_spr_zu v01

GROUP BY
-- v01.mandant_id
v01.einh_id;