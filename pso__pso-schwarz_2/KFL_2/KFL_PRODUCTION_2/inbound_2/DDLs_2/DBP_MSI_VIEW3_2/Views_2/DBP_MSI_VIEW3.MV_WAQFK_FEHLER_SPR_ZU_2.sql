CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_WAQFK_FEHLER_SPR_ZU_2 (
   mandant_id,
   waqfk_fehler_id,
   waqfk_fehler_bez
) AS 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.waqfk_fehler_id,
   v01.waqfk_fehler_bez
FROM
   dbp_view.v_waqfk_fehler_spr_zu_2 v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU_2 v02 
   ON v01.spr_id = v02.spr_id;