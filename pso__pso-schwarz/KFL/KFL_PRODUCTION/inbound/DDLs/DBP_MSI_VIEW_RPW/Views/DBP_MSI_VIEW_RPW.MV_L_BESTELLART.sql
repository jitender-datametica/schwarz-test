CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_BESTELLART
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
                FROM dbp_view.v_l_bestellart
                WHERE mandant_id = 1
 ;