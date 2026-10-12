CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_LAGER_BEWART_1
 (
   mandant_id
   ,lager_bewart_id
   ,system_id
 )
 AS
    SELECT
       mandant_id,
    lager_bewart_id,
    7
    FROM dbp_view.v_l_lager_bewart_1
    WHERE mandant_id = 1
 ;