CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_PROBLEMGRUPPE_SPR_ZU_2
    (
    system_id
    ,mandant_id
    ,problemgruppe_id
    ,spr_id
    ,problemgruppe_bez
    )
    AS
       SELECT
       7,
       mandant_id,
       problemgruppe_id,
       spr_id,
       problemgruppe_bez
       FROM dbp_view.v_problemgruppe_spr_zu_2
       WHERE spr_id = 22
       AND mandant_id = 1
 ;