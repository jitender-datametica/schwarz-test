CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BELOS_VORGANGART_SPR_ZU_1 (
   belos_vorgangart_bez,
   belos_vorgangart_id,
   belos_vorgangart_kbez,
   mandant_id,
   spr_id
) AS 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.belos_vorgangart_bez,
   v01.belos_vorgangart_id,
   v01.belos_vorgangart_kbez,
   v01.mandant_id,
   v01.spr_id
FROM
   dbp_view.v_belos_vorgangart_spr_zu_1 v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU_1 v02 
   ON v01.spr_id = v02.spr_id;