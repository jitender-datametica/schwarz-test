create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_WAQFK_FEHLER_SPR_ZU_2(
	MANDANT_ID,
	WAQFK_FEHLER_ID,
	WAQFK_FEHLER_BEZ
) as 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.waqfk_fehler_id,
   v01.waqfk_fehler_bez
FROM
   dbp_view.v_waqfk_fehler_spr_zu_2 v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_2 v02 
   ON v01.spr_id = v02.spr_id;