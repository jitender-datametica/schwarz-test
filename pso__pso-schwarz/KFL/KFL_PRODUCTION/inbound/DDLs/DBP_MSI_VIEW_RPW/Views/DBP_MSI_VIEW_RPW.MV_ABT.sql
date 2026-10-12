CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_ABT
    (
    abt_id
    ,arthiertyp_id
    ,mandant_id
    ,system_id
    )
    AS
       SELECT
       abt_id,
       arthiertyp_id,
       mandant_id,
       7
       FROM dbp_view.v_abt
       WHERE mandant_id = 1
       AND arthiertyp_id = 2
       AND abt_id NOT IN (0, -1, -2,-3);