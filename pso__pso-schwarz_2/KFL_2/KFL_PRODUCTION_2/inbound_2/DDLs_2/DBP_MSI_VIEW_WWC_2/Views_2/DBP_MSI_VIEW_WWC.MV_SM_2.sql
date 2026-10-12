CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_SM_2(
SM_ID,
SM_BEZ,
MANDANT_ID,
SPR_ID
) AS
 --11.06.2024, SPEC0255380, prescherad, Neualange 
   SELECT
   sm_id,
   sm_bez,
   mandant_id,
   spr_id
   FROM dbp_view.v_sm_2
   WHERE mandant_id=1
   AND sm_id <> -9;