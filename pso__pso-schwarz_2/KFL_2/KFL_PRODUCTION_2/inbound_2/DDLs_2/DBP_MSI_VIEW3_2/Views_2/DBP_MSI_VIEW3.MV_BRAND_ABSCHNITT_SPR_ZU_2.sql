CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BRAND_ABSCHNITT_SPR_ZU_2 (
   brand_abschnitt_id,
   mandant_id,
   lagernummer_id,
   spr_id,
   brand_abschnitt_bez
) AS 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.brand_abschnitt_id,
   v01.mandant_id,
   v01.lagernummer_id,
   v01.spr_id,
   v01.brand_abschnitt_bez
FROM
   DBP_MSI_VIEW3.TBL_MV_BRAND_ABSCHNITT_SPR_ZU_2 v01
   INNER JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU_2 v02 
   ON v01.spr_id = v02.spr_id;