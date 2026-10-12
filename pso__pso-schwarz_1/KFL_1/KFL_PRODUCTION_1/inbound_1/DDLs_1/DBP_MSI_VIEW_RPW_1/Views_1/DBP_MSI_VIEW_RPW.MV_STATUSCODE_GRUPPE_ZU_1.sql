CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_STATUSCODE_GRUPPE_ZU_1
    (
    system_id
    ,mandant_id
    ,statuscode_id
    ,statusgruppe_id
    )
    AS
       SELECT
       7,
       mandant_id,
       statuscode_id,
       statusgruppe_id
       FROM dbp_view.v_statuscode_gruppe_zu_1
       WHERE mandant_id = 1
 ;