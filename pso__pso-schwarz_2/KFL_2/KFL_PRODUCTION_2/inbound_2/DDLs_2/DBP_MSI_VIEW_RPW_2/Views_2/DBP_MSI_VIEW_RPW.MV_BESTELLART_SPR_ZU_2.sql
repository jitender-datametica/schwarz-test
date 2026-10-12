CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_BESTELLART_SPR_ZU_2
 (
 mandant_id
 ,bestellart_id
 ,spr_id
 ,bestellart_bez
 ,system_id
 )
 AS
    SELECT
    mandant_id,
    bestellart_id,
    spr_id,
    bestellart_bez,
    7
    FROM dbp_view.v_bestellart_spr_zu_2
    WHERE spr_id = 22
    AND mandant_id = 1;