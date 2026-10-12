CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_WAQFK_KENNZIFFER_SPR_ZU (
   mandant_id,
   waqfk_fehler_id,
   waqfk_kennziffer_id,
   waqfk_kennziffer_bez
) AS 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.waqfk_fehler_id,
   v01.waqfk_kennziffer_id,
   v01.waqfk_kennziffer_bez
FROM
   dbp_view.v_waqfk_kennziffer_spr_zu v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU v02 
   ON v01.spr_id = v02.spr_id;