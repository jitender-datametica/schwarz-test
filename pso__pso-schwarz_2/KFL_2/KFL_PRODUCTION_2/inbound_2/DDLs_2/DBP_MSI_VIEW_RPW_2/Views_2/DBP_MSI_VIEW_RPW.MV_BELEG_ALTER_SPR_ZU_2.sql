CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_BELEG_ALTER_SPR_ZU_2
(
 mandant_id
 , beleg_alter_id
 , spr_id
 , beleg_alter_bez
 , system_id
)
AS
   SELECT
    mandant_id,
   beleg_alter_id,
   spr_id,
   beleg_alter_bez,
   7
  FROM dbp_view.v_beleg_alter_spr_zu_2
  WHERE spr_id = 22
    AND mandant_id = 1
 ;