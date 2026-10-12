CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_L_KREISTYP_GRUPPE_2(
MANDANT_ID,
KREISTYP_GRUPPE_ID
) AS
 --13.06.2024, SPEC0255380, prescherad, Neualange 
 SELECT
 mandant_id, 
 kreistyp_gruppe_id
 FROM dbp_view.v_l_kreistyp_gruppe_2
 WHERE mandant_id = 1;