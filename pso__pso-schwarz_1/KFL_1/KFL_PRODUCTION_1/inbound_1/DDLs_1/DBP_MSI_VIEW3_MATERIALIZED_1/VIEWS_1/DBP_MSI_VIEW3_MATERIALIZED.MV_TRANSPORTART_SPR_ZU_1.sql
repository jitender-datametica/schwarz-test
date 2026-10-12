create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_TRANSPORTART_SPR_ZU_1(
	MANDANT_ID,
	SPR_ID,
	TRANSPORTART_BEZ,
	TRANSPORTART_ID
) as 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.spr_id,
   v01.transportart_bez,
   v01.transportart_id
FROM
   dbp_view.v_transportart_spr_zu_1 v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_1 v02 
   ON v01.spr_id = v02.spr_id;