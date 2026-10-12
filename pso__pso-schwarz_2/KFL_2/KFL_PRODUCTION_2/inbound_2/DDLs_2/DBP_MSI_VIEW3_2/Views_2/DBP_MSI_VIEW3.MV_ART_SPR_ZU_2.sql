CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_ART_SPR_ZU_2 AS
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.spr_id,
   v01.art_id,
   v01.mandant_id,
   v01.art_bez,
   v01.art_id_bez
FROM
   DBP_MSI_VIEW3.TBL_MV_ART_SPR_ZU_2 v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU_2 v02 
   ON v01.spr_id = v02.spr_id;