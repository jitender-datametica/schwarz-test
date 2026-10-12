CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_VORGANGSART_AG08_SPR_ZU_2
 (
 system_id
 ,mandant_id
 ,vorgangsart_ag08_id
 ,spr_id
 ,vorgangsart_ag08_bez
 )
 AS
    SELECT
    7,
    mandant_id,
    vorgangsart_ag08_id,
    spr_id,
    vorgangsart_ag08_bez
    FROM dbp_view.v_vorgangsart_ag08_spr_zu_2
    WHERE  mandant_id = 1
    AND spr_id=22;