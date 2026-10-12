CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_BESTELLART_1
             (
                mandant_id
               ,bestellart_id
               ,system_id
             )
             AS
                SELECT
                   mandant_id,
                bestellart_id,
                7
                FROM dbp_view.v_l_bestellart_1
                WHERE mandant_id = 1
 ;