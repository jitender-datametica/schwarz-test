create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_TRANSPORT_GV_SPR_ZU_2(
	MANDANT_ID,
	TRANSPORT_GV_ID,
	SPR_ID,
	TRANSPORT_GV_BEZ
) as 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.transport_gv_id,
   v01.spr_id,
   v01.transport_gv_bez
FROM
   dbp_view.v_transport_gv_spr_zu_2 v01
   INNER JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_2 v02 
   ON v01.spr_id = v02.spr_id;