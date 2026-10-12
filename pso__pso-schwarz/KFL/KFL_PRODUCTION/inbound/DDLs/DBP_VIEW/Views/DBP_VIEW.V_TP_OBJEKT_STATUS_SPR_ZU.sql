CREATE OR REPLACE VIEW DBP_VIEW.V_TP_OBJEKT_STATUS_SPR_ZU AS 
    SELECT 
        mandant_id
        ,tp_objekt_status_id
        ,spr_id
        ,tp_objekt_status_kbez
        ,tp_objekt_status_bez


FROM DBP_DATA.tp_objekt_status_spr_zu ;