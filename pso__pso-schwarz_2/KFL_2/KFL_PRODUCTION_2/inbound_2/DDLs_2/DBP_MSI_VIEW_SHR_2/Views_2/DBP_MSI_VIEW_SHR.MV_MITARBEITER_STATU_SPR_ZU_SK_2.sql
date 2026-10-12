CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_MITARBEITER_STATU_SPR_ZU_SK_2
(
mandant_id
, ma_status_id
, ma_status_bez
)
AS
   SELECT
   v01.mandant_id, v01.ma_status_id, v01.ma_status_bez

   FROM dbp_view.v_mitarbeiter_status_spr_zu_2 v01
   WHERE v01.spr_id = 108
;