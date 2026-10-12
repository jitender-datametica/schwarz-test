CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_TRANSPORTSTATUS_SPR_ZU (
   mandant_id,
   transportstatus_id,
   spr_id,
   transportstatus_bez
) AS 
-- 13.12.2018, aszu1204, AP0027269, neue View
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.transportstatus_id,
   v01.spr_id,
   v01.transportstatus_bez
FROM
   dbp_view.v_transportstatus_spr_zu v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU v02 
   ON v01.spr_id = v02.spr_id;