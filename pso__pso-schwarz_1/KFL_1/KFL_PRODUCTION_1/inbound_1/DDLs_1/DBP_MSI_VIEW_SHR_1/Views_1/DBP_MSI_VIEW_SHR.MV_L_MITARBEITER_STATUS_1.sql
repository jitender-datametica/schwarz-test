CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_L_MITARBEITER_STATUS_1
(
mandant_id
, ma_status_id
)
AS
   SELECT
   v01.mandant_id, v01.ma_status_id

   FROM dbp_view.v_l_mitarbeiter_status_1 v01;