create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_WTAG_SPR_ZU_1(
	WTAG_ID,
	SPR_ID,
	WTAG_BEZ
) as
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.wtag_id,
   v01.spr_id,
   v01.wtag_bez
FROM
   dbp_view.v_wtag_spr_zu_1 v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_1 v02 
   ON v01.spr_id = v02.spr_id;