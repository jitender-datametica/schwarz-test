CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_PROZESSBEREICH_2
    (
    system_id
    ,mandant_id
    ,prozessbereich_id

    )
    AS
       SELECT
       7,
       mandant_id,
       prozessbereich_id

       FROM dbp_view.v_l_prozessbereich_2
       WHERE mandant_id = 1;