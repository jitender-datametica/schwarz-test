CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_WTAG_SPR_ZU (wtag_id, spr_id, wtag_bez) AS
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.wtag_id,
   v01.spr_id,
   v01.wtag_bez
FROM
   dbp_view.v_wtag_spr_zu v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU v02 
   ON v01.spr_id = v02.spr_id;