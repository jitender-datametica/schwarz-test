CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_PROZESSBEREICH_SPR_ZU_1
    (
    system_id
    ,mandant_id
    ,prozessbereich_id
    ,spr_id
    ,prozessbereich_bez

    )
    AS
       SELECT
       7,
       mandant_id,
       prozessbereich_id,
       spr_id,
       prozessbereich_bez

       FROM dbp_view.v_prozessbereich_spr_zu_1
       WHERE mandant_id = 1
       AND spr_id = 22;