create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_TRANSPORT_BEWART_SPR_ZU_1(
	MANDANT_ID,
	LVS_BEWART_ID,
	LAGERNUMMER_ID,
	SPR_ID,
	LVS_BEWART_BEZ
) as 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.lvs_bewart_id,
   v01.lagernummer_id,
   v01.spr_id,
   v01.lvs_bewart_bez
FROM
   dbp_view.v_transport_bewart_spr_zu_1 v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_1 v02 
   ON v01.spr_id = v02.spr_id;