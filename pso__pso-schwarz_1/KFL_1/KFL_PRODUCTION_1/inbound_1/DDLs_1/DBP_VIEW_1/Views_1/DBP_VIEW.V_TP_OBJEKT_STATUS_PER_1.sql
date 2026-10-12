CREATE OR REPLACE VIEW DBP_VIEW.V_TP_OBJEKT_STATUS_PER_1 AS 
    SELECT 
        mandant_id
        ,tp_objekt_nr
        ,tp_objekt_status_id
        ,dat_von
        ,dat_bis
        ,tp_objekt_id
        ,tp_objekt_status_fg


FROM DBP_DATA.tp_objekt_status_per_1 ;