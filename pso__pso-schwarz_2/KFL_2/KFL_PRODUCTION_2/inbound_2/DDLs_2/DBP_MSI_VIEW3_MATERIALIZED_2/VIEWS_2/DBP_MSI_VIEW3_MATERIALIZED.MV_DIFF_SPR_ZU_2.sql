create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_DIFF_SPR_ZU_2(
	MANDANT_ID,
	DIFF_ID,
	SPR_ID,
	DIFF_BEZ
) as 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.diff_id,
   v01.spr_id,
   CASE
      WHEN v01.diff_bez = 'System generated' THEN 'system generated'
      ELSE v01.diff_bez
   END AS diff_bez
FROM
   dbp_view.v_diff_spr_zu_2 v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_2 v02 
   ON v01.spr_id = v02.spr_id;