CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_BELEGKLASSE_GRUPPE_SPR_ZU_1
    (
    system_id
    ,mandant_id
    ,spr_id
    ,belegklasse_gruppe_id
    ,belegklasse_gruppe_bez
    )
    AS
       SELECT
       7,
       mandant_id,
       spr_id,
       belegklasse_gruppe_id,
       belegklasse_gruppe_bez
       FROM dbp_view.v_belegklasse_gruppe_spr_zu_1
       WHERE spr_id = 22
       AND mandant_id = 1;