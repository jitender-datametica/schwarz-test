CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_LAGERORT_SPR_ZU_2
    (
    wup_id
    ,mandant_id
    ,lagerort_id
    ,nb_id
    ,spr_id
    ,lagerort_bez
    ,system_id
    )
    AS
       SELECT
       wup_id,
       mandant_id,
       lagerort_id,
       nb_id,
       spr_id,
       lagerort_bez,
       7
       FROM dbp_view.v_lagerort_spr_zu_2
       WHERE mandant_id = 1
       AND spr_id = 22;