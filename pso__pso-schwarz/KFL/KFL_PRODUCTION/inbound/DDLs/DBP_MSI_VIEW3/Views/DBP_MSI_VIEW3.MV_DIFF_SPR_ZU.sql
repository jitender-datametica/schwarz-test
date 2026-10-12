CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_DIFF_SPR_ZU (mandant_id, diff_id, spr_id, diff_bez) AS 
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
   dbp_view.v_diff_spr_zu v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU v02 
   ON v01.spr_id = v02.spr_id;