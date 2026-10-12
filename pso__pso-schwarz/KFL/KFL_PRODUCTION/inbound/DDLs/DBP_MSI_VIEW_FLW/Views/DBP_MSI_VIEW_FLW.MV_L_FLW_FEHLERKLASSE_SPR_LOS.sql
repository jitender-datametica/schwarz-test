CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_FEHLERKLASSE_SPR_LOS
-- 26.10.2011 system_id entfernt
(
--  system_id
mandant_id
, fehlerklasse_id
, spr_id
, fehlerklasse_bez
)
AS
   SELECT
   --  v01.system_id
   v01.mandant_id, v01.fehlerklasse_id, v01.spr_id, v01.fehlerklasse_bez

   FROM dbp_view.v_flw_fehlerklasse_spr_zu v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id;