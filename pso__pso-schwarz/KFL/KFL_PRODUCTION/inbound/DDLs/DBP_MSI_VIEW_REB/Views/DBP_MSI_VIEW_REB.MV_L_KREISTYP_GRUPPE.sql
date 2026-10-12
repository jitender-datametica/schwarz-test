CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_L_KREISTYP_GRUPPE
(
mandant_id
, kreistyp_gruppe_id
)
AS
   SELECT
   mandant_id, kreistyp_gruppe_id
   FROM dbp_view.v_l_kreistyp_gruppe;