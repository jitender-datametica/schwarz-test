create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_SOND_BEST_SPR_ZU_1(
	MANDANT_ID,
	SOND_BEST_ID,
	SPR_ID,
	SOND_BEST_BEZ
) as 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.sond_best_id,
   v01.spr_id,
   v01.sond_best_bez
FROM
   dbp_view.v_sond_best_spr_zu_1 v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_1 v02 
   ON v01.spr_id = v02.spr_id;