CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BELOS_TOURSTATUS_SPR_ZU (
   mandant_id,
   belos_tourstatus_id,
   spr_id,
   belos_tourstatus_bez
) AS 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.belos_tourstatus_id,
   v01.spr_id,
   v01.belos_tourstatus_bez
FROM
   dbp_view.v_belos_tourstatus_spr_zu v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU v02 
   ON v01.spr_id = v02.spr_id;