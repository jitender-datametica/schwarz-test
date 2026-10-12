CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_WAQFK_FEHLER
(
mandant_id
, waqfk_fehler_id
)
AS
   SELECT
  mandant_id, waqfk_fehler_id

   FROM dbp_view.v_l_waqfk_fehler;