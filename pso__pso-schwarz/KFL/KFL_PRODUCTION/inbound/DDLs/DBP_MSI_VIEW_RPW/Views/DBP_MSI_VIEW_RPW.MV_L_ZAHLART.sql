CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_ZAHLART
    (
    mandant_id
    ,zahlart_id
    ,system_id
    )
    AS
       SELECT
       mandant_id,
       zahlart_id,
       7
       FROM dbp_view.v_l_zahlart
       WHERE mandant_id = 1
 ;