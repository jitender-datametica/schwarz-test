CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_HWG_SPR_ZU_1
    (
    hwg_id
    ,arthiertyp_id
    ,mandant_id
    ,spr_id
    ,hwg_bez
    ,system_id
    )
    AS
       SELECT
       hwg_id,
       arthiertyp_id,
       mandant_id,
       spr_id,
       hwg_bez,
       7
       FROM dbp_view.v_hwg_spr_zu_1
       WHERE mandant_id = 1
       AND spr_id = 22;