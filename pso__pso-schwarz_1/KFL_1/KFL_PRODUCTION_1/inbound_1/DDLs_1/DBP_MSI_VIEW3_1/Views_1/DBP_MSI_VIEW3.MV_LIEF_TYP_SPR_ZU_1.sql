CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_LIEF_TYP_SPR_ZU_1 (
   lief_typ_bez,
   lief_typ_id,
   mandant_id,
   spr_id
) AS 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.lief_typ_bez,
   v01.lief_typ_id,
   v01.mandant_id,
   v01.spr_id
FROM
   dbp_view.v_lief_typ_spr_zu_1 v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU_1 v02 
   ON v01.spr_id = v02.spr_id;