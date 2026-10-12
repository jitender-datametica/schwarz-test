CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_PROFIT_CENTER_SPR_ZU_2
-- 26.10.2011 system_id entfernt
(
mandant_id
, pc_id
, spr_id
--, system_id
, krk_id
, pc_bez
)
AS
   SELECT
   v01.mandant_id, v01.pc_id, v01.spr_id, v01.krk_id, v01.pc_bez

   FROM dbp_view.v_profit_center_spr_zu_2 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
   ON v01.spr_id = v02.spr_id;