CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_PROBLEMKLASSE
    (
    mandant_id
    ,problemklasse_id
    ,system_id
    )
    AS
       SELECT
       mandant_id,
       problemklasse_id,
       7
       FROM dbp_view.v_l_problemklasse
       WHERE mandant_id = 1;