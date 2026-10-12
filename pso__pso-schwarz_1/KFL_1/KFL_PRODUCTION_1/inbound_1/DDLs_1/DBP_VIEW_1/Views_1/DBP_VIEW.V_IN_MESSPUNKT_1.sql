CREATE OR REPLACE VIEW DBP_VIEW.V_IN_MESSPUNKT_1 AS 
    SELECT 
        mandant_id
        ,messpunkt_id
        ,tp_objekt_id
        ,tp_objekt_nr


FROM DBP_DATA.in_messpunkt_1 ;