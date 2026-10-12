CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_LIS_REKL_STATUS_SPR_ZU_1 (
   mandant_id,
   lis_rekl_status_id,
   spr_id,
   lis_rekl_status_bez
) AS 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.lis_rekl_status_id,
   v01.spr_id,
   v01.lis_rekl_status_bez
FROM
   dbp_view.v_lis_rekl_status_spr_zu_1 v01
   INNER JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU_1 v02 
   ON v01.spr_id = v02.spr_id;