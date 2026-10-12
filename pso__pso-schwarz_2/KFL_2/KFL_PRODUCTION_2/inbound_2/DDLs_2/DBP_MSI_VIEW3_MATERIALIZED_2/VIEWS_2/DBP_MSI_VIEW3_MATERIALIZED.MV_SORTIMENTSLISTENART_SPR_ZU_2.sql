create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_SORTIMENTSLISTENART_SPR_ZU_2(
	MANDANT_ID,
	SPR_ID,
	SORTIMENTSLISTENART_ID,
	SORTIMENTSLISTENART_BEZ
) as 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.spr_id,
   v01.sortimentslistenart_id,
   v01.sortimentslistenart_bez
FROM
   dbp_view.v_sortimentslistenart_spr_zu_2 v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_2 v02 
   ON v01.spr_id = v02.spr_id;