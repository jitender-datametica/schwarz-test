CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_OWG_SPR_ZU_2 AS
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.owg_id,
   v01.owg_bez,
   owg_id_bez,
   v01.mandant_id,
   v01.arthiertyp_id,
   v01.spr_id
FROM
   dbp_msi_view3.tbl_mv_owg_spr_zu_2 v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU_2 v02 
   ON v01.spr_id = v02.spr_id
WHERE
   v01.arthiertyp_id = 2;