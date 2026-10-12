CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_VORGANGSART_AG08_2
 (
 system_id
 ,mandant_id
 ,vorgangsart_ag08_id
 )
 AS
    SELECT
    7,
    mandant_id,
    vorgangsart_ag08_id
    FROM dbp_view.v_l_vorgangsart_ag08_2
    WHERE mandant_id = 1
 ;