CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_ABTEILUNG_RPW_SPR_ZU_2
    (
    mandant_id
    ,abteilung_id
    ,spr_id
    ,abteilung_rpw_bez
    ,system_id
    )
    AS
       SELECT
       mandant_id,
       abteilung_id,
       spr_id,
       abteilung_rpw_bez,
       7
       FROM dbp_view.v_abteilung_rpw_spr_zu_2
       WHERE mandant_id = 1
       AND spr_id = 22;