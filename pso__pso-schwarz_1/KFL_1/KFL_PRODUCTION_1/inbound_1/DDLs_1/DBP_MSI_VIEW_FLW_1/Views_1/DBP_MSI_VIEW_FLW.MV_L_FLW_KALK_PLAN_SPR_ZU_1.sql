CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_KALK_PLAN_SPR_ZU_1
-- 26.10.2011 system_id entfernt
(
mandant_id
--, system_id
, plan_kalk_id
, spr_id
, plan_kalk_bez
)
AS
   SELECT
   v01.mandant_id, v01.plan_kalk_id, v01.spr_id, v01.plan_kalk_bez

   FROM dbp_view.v_flw_kalk_plan_spr_zu_1 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_1 v02
   ON v01.spr_id = v02.spr_id;