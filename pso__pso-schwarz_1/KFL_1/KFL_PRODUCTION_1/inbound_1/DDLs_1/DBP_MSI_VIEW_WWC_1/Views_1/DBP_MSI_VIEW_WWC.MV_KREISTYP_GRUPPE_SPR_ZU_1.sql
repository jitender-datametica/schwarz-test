CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_KREISTYP_GRUPPE_SPR_ZU_1(
MANDANT_ID,
KREISTYP_GRUPPE_ID,
SPR_ID,
KREISTYP_GRUPPE_BEZ
) AS
  --11.06.2024, SPEC0255380, prescherad, Neualange 
  SELECT
  mandant_id, 
  kreistyp_gruppe_id, 
  spr_id, 
  kreistyp_gruppe_bez
  FROM dbp_view.v_kreistyp_gruppe_spr_zu_1
  WHERE mandant_id = 1
  AND spr_id = 22;