CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BELOS_TOURART_SPR_ZU_1 AS 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.belos_tourart_id,
   v01.spr_id,
   v01.belos_tourart_bez
FROM
   DBP_MSI_VIEW3.TBL_MV_BELOS_TOURART_SPR_ZU_1 v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU_1 v02 
   ON v01.spr_id = v02.spr_id;