CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_GRUPPE_RPW_SPR_ZU_2
 (
 mandant_id
 ,gruppe_id
 ,abteilung_id
 ,spr_id
 ,gruppe_rpw_bez
 ,system_id
 )
 AS
    SELECT
    mandant_id,
    gruppe_id,
    abteilung_id,
    spr_id,
    gruppe_rpw_bez,
    7
    FROM dbp_view.v_gruppe_rpw_spr_zu_2
    WHERE mandant_id = 1
    AND spr_id = 22;