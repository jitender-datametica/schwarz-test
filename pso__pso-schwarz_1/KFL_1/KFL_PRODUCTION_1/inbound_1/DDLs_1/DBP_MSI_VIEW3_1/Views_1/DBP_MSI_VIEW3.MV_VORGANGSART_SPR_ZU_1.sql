CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_VORGANGSART_SPR_ZU_1 (
   mandant_id,
   vorgangsart_id,
   spr_id,
   vorgangsart_bez
) AS 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.vorgangsart_id,
   v01.spr_id,
   v01.vorgangsart_bez
FROM
   dbp_view.v_vorgangsart_spr_zu_1 v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU_1 v02 
   ON v01.spr_id = v02.spr_id;