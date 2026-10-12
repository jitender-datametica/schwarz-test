create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_LAGER_BEWART_TYP_SPR_ZU_HIST(
	MANDANT_ID,
	SPR_ID,
	LAGER_BEWART_TYP_ID,
	HIST_FG,
	LAGER_BEWART_TYP_BEZ
) as 
-- AP0014173, srom0404, system_id entfällt
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.spr_id,
   v01.lager_bewart_typ_id,
   v01.hist_fg,
   v01.lager_bewart_typ_bez
FROM
   dbp_view.v_lager_bewart_typ_spr_zu v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU v02 
   ON v01.spr_id = v02.spr_id
WHERE
   hist_fg = 1;