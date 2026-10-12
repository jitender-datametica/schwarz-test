CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_WAQFK_KENNZIFFER_1
(
mandant_id
, waqfk_fehler_id
, waqfk_kennziffer_id
)
AS
   SELECT
  mandant_id, waqfk_fehler_id, waqfk_kennziffer_id

   FROM dbp_view.v_l_waqfk_kennziffer_1;