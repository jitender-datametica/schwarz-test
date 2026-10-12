CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_VERURSACHER_SPR_ZU_2
 (
 system_id
 ,mandant_id
 ,verursacher_id
 ,spr_id
 ,verursacher_bez
 )
 AS
    SELECT
    7,
    mandant_id,
    verursacher_id,
    spr_id,
    verursacher_bez
    FROM dbp_view.v_verursacher_spr_zu_2
    WHERE mandant_id = 1
    AND spr_id = 22
 ;