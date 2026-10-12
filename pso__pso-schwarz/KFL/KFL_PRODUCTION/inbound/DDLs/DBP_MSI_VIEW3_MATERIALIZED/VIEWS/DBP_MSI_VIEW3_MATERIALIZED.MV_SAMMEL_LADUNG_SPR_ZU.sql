create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_SAMMEL_LADUNG_SPR_ZU(
	SAMMEL_LADUNG_FG,
	SPR_ID,
	SAMMEL_LADUNG_BEZ
) as 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.sammel_ladung_fg,
   v01.spr_id,
   v01.sammel_ladung_bez
FROM
   dbp_view.v_sammel_ladung_spr_zu v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU v02 
   ON v01.spr_id = v02.spr_id;