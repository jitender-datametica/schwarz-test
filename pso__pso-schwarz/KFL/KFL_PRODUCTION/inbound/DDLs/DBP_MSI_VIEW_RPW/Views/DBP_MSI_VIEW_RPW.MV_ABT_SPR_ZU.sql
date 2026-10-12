CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_ABT_SPR_ZU
    (
    abt_id
    ,spr_id
    ,arthiertyp_id
    ,abt_bez
    ,mandant_id
    ,system_id
    )
    AS
       SELECT
       abt_id,
       spr_id,
       arthiertyp_id,
       abt_bez,
       mandant_id,
       7
       FROM dbp_view.v_abt_spr_zu
       WHERE mandant_id = 1
       AND spr_id = 22
       AND arthiertyp_id = 2
       AND abt_id NOT IN (0,-1,-2,-3);