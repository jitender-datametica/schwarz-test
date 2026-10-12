create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_WG_VERKETTUNG_SPR_ZU_2(
	MANDANT_ID,
	SPR_ID,
	WG_VERKETT_ID,
	WG_VERKETT_BEZ
) as 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.spr_id,
   v01.wg_verkett_id,
   v01.wg_verkett_bez
FROM
   dbp_view.v_wg_verkettung_spr_zu_2 v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_2 v02 
   ON v01.spr_id = v02.spr_id;