CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_LAGERZONE_SPR_ZU_1 (
   lagerzone_bez,
   lagerzone_id,
   mandant_id,
   spr_id
) AS 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.lagerzone_bez,
   v01.lagerzone_id,
   v01.mandant_id,
   v01.spr_id
FROM
   dbp_view.v_lagerzone_spr_zu_1 v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU_1 v02 
   ON v01.spr_id = v02.spr_id;