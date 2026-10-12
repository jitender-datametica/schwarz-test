create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_TOURART_SUBTYP_SPR_ZU_1(
	TOURART_SUBTYP_ID,
	SPR_ID,
	MANDANT_ID,
	TOURART_SUBTYP_BEZ
) as 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.tourart_subtyp_id,
   v01.spr_id,
   v01.mandant_id,
   v01.tourart_subtyp_bez
FROM
   dbp_view.v_tourart_subtyp_spr_zu_1 v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_1 v02 
   ON v01.spr_id = v02.spr_id;