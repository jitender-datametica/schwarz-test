create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_SONDERABWICKLUNG_SPR_ZU_1(
	MANDANT_ID,
	SONDERABWICKLUNG_ID,
	SPR_ID,
	SONDERABWICKLUNG_BEZ
) as 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.sonderabwicklung_id,
   v01.spr_id,
   v01.sonderabwicklung_bez
FROM
   dbp_view.v_sonderabwicklung_spr_zu_1 v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_1 v02 
   ON v01.spr_id = v02.spr_id;