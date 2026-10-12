create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_LAGER_BEWGRUND_SPR_ZU_HIST_2(
	GRUND_ID,
	SPR_ID,
	LAGER_BEWART_ID,
	MANDANT_ID,
	HIST_FG,
	GRUND_BEZ
) as 
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
   dbp_view.v_lager_bewgrund_spr_zu_2 v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_2 v02 
   ON v01.spr_id = v02.spr_id
WHERE
   hist_fg = 1;