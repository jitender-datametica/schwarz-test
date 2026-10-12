CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_L_ZAEHLER_SPR_ZU
-- 26.10.2011 system_id entfernt
(
mandant_id
--, system_id
, zaehler_id
, spr_id
, zaehler_bez
)
AS
   SELECT
   v01.mandant_id, v01.zaehler_id, v01.spr_id, v01.zaehler_bez

   FROM dbp_view.v_flw_zaehler_spr_zu v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id;