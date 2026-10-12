CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_KREISTYP_GRUPPE_SPR_ZU
(
mandant_id
, kreistyp_gruppe_id
, spr_id
, kreistyp_gruppe_bez
)
AS
   SELECT
   mandant_id, kreistyp_gruppe_id, spr_id, kreistyp_gruppe_bez
   FROM dbp_view.v_kreistyp_gruppe_spr_zu

   WHERE spr_id = 22;