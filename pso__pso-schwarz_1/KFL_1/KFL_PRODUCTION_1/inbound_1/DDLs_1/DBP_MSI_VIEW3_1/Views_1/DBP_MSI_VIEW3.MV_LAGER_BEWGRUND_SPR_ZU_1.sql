CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_LAGER_BEWGRUND_SPR_ZU_1 (
   grund_id,
   spr_id,
   lager_bewart_id,
   mandant_id,
   hist_fg,
   grund_bez
) AS 
-- AP0014173, srom0404, hist_fg aufgenommen
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.grund_id,
   v01.spr_id,
   v01.lager_bewart_id,
   v01.mandant_id,
   v01.hist_fg,
   v01.grund_bez
FROM
   DBP_MSI_VIEW3.TBL_MV_LAGER_BEWGRUND_SPR_ZU_1 v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU_1 v02 
   ON v01.spr_id = v02.spr_id
WHERE
   hist_fg = 0;