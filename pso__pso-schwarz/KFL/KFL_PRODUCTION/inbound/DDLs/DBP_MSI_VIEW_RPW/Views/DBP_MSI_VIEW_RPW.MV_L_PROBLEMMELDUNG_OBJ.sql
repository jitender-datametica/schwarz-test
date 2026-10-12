CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_PROBLEMMELDUNG_OBJ
    (
    system_id
    ,mandant_id
    ,zus_obj_id
    )
    AS
       SELECT
       7,
       mandant_id,
       zus_obj_id
       FROM dbp_view.v_l_problemmeldung_obj
       WHERE mandant_id = 1;