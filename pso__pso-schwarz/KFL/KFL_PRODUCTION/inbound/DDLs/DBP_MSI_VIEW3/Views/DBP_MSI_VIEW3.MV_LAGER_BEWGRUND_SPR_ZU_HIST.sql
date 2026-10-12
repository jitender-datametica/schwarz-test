CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_LAGER_BEWGRUND_SPR_ZU_HIST (
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
   dbp_view.v_lager_bewgrund_spr_zu v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU v02 
   ON v01.spr_id = v02.spr_id
WHERE
   hist_fg = 1;