CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_RECH_KONTOART
 (
 system_id
 ,mandant_id
 ,rech_kontoart_id
 )
 AS
    SELECT
    7,
    mandant_id,
    rech_kontoart_id
    FROM dbp_view.v_l_rech_kontoart
    WHERE mandant_id = 1
 ;