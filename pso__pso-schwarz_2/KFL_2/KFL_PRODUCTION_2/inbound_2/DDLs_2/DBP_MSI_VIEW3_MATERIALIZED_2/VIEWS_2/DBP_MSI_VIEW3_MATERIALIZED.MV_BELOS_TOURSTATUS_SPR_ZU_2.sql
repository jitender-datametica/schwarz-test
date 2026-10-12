create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_BELOS_TOURSTATUS_SPR_ZU_2(
	MANDANT_ID,
	BELOS_TOURSTATUS_ID,
	SPR_ID,
	BELOS_TOURSTATUS_BEZ
) as 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.belos_tourstatus_id,
   v01.spr_id,
   v01.belos_tourstatus_bez
FROM
   dbp_view.v_belos_tourstatus_spr_zu_2 v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_2 v02 
   ON v01.spr_id = v02.spr_id;