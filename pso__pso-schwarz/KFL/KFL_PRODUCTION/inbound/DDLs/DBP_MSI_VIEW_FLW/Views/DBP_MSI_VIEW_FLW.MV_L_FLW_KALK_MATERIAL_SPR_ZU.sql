CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_KALK_MATERIAL_SPR_ZU
-- 26.10.2011 system_id entfernt
(
mandant_id
--, system_id
, materialwert_kalk_id
, spr_id
, material_kalk_bez
)
AS
   SELECT
   v01.mandant_id, v01.materialwert_kalk_id, v01.spr_id, v01.material_kalk_bez

   FROM dbp_view.v_flw_kalk_material_spr_zu v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id;