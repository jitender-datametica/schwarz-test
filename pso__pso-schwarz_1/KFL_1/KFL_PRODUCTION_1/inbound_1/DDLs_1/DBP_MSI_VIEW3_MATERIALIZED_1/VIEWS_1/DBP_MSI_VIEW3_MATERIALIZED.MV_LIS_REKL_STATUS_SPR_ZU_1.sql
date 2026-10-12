create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_LIS_REKL_STATUS_SPR_ZU_1(
	MANDANT_ID,
	LIS_REKL_STATUS_ID,
	SPR_ID,
	LIS_REKL_STATUS_BEZ
) as 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.lis_rekl_status_id,
   v01.spr_id,
   v01.lis_rekl_status_bez
FROM
   dbp_view.v_lis_rekl_status_spr_zu_1 v01
   INNER JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_1 v02 
   ON v01.spr_id = v02.spr_id;