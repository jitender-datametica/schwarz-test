CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_SONDERABWICKLUNG_SPR_ZU_2 (
   mandant_id,
   sonderabwicklung_id,
   spr_id,
   sonderabwicklung_bez
) AS 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.sonderabwicklung_id,
   v01.spr_id,
   v01.sonderabwicklung_bez
FROM
   dbp_view.v_sonderabwicklung_spr_zu_2 v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU_2 v02 
   ON v01.spr_id = v02.spr_id;