CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_BELEGKLASSE_GRUPPE_ZU_2
    (
    system_id
    ,mandant_id
    ,belegklasse_id
    ,belegklasse_gruppe_id
    )
    AS
       SELECT
       7,
       mandant_id,
       belegklasse_id,
       belegklasse_gruppe_id
       FROM dbp_view.v_belegklasse_gruppe_zu_2
       WHERE mandant_id = 1;