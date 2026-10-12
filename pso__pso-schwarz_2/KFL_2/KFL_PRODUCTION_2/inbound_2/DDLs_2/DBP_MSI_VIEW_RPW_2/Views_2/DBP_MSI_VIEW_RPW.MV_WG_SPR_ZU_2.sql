CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_WG_SPR_ZU_2
 (
 wg_id
 ,spr_id
 ,arthiertyp_id
 ,mandant_id
 ,wg_bez
 ,system_id
 )
 AS
    SELECT
    wg_id,
    spr_id,
    arthiertyp_id,
    mandant_id,
    wg_bez,
    7 AS system_id
    FROM dbp_view.v_wg_spr_zu_2
    WHERE mandant_id = 1
    AND  spr_id = 22
    AND  arthiertyp_id = 2
    --17.07.10: Filterung der Korrektur- WG aus VIS/MIS
    AND wg_id >= -3;