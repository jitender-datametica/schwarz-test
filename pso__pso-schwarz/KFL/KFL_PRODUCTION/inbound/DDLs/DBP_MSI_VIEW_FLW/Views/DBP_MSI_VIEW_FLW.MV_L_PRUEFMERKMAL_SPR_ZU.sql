CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_PRUEFMERKMAL_SPR_ZU
-- 26.10.2011 system_id entfernt
(
mandant_id
--, system_id
, werk_id
, stp_merkmal_id
, spr_id
, merkmal_bez
)
AS
   SELECT
   v01.mandant_id, v01.werk_id, v01.stp_merkmal_id, v01.spr_id, v01.merkmal_bez

   FROM dbp_view.v_flw_pruefmerkmal_spr_zu v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id;