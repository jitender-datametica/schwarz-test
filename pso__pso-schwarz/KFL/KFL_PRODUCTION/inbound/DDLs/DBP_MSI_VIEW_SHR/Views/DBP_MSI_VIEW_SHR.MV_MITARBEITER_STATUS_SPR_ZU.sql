CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_MITARBEITER_STATUS_SPR_ZU
(
mandant_id
, ma_status_id
, ma_status_bez
)
AS
   SELECT
   v01.mandant_id, v01.ma_status_id, v01.ma_status_bez

   FROM DBP_MSI_VIEW_SHR.TBL_MV_MITARBEITER_STATUS_SPR_ZU v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id
   --WHERE v01.spr_id = 22
   ;