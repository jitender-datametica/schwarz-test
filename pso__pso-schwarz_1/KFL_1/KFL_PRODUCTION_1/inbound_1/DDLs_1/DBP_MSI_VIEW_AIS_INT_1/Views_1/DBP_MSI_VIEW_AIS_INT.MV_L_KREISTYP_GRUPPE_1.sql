CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_L_KREISTYP_GRUPPE_1
(
mandant_id
, kreistyp_gruppe_id
)
AS
   SELECT
   v01.mandant_id, v01.kreistyp_gruppe_id

   FROM dbp_view.v_l_kreistyp_gruppe_1 v01;