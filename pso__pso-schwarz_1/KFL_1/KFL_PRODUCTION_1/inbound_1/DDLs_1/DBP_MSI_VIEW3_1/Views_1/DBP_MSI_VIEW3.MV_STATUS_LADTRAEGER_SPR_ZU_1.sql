CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_STATUS_LADTRAEGER_SPR_ZU_1 (
   mandant_id,
   status_ladtraeger,
   status_ladtraeger_bez
) AS 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.status_ladtraeger,
   v01.status_ladtraeger_bez
FROM
   dbp_view.v_status_ladtraeger_spr_zu_1 v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU_1 v02 
   ON v01.spr_id = v02.spr_id;