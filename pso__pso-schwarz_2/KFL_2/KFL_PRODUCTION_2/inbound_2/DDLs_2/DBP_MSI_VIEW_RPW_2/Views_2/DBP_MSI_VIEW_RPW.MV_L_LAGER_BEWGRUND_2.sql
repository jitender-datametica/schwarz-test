CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_LAGER_BEWGRUND_2
 (
 mandant_id
 ,system_id
 ,grund_id
 ,lager_bewart_id
 ,retourenart_id

 )
 AS
    SELECT
    mandant_id,
    7 AS system_id,
    grund_id,
    lager_bewart_id,
    retourenart_id

    FROM dbp_view.v_l_lager_bewgrund_2
    WHERE mandant_id = 1;