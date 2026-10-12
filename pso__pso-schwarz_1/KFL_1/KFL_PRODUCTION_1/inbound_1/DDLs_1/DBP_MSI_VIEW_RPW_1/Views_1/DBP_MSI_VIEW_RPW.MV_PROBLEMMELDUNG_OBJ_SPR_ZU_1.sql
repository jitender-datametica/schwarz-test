CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_PROBLEMMELDUNG_OBJ_SPR_ZU_1
    (
    system_id
    ,mandant_id
    ,spr_id
    ,zus_obj_id
    ,zus_obj_bez
    )
    AS
       SELECT
       7,
       mandant_id,
       spr_id,
       zus_obj_id,
       zus_obj_bez
       FROM dbp_view.v_problemmeldung_obj_spr_zu_1
       WHERE mandant_id = 1
       AND spr_id = 22
 ;