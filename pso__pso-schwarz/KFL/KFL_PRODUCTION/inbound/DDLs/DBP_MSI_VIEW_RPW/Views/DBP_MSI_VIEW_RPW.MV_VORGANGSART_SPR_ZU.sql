CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_VORGANGSART_SPR_ZU
 (
    mandant_id
   ,vorgangsart_id
   ,spr_id
   ,vorgangsart_bez
   ,system_id
 )
 AS
    SELECT
       mandant_id,
    vorgangsart_id,
    spr_id,
    vorgangsart_bez,
    7
    FROM dbp_view.v_vorgangsart_spr_zu
    WHERE spr_id=22
      AND mandant_id = 1;