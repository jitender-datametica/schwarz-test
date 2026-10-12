CREATE OR REPLACE VIEW DBP_VIEW.V_IN_WARTUNGSPLAN_DET AS 
    SELECT 
        mandant_id
        ,wart_plan_pos_id
        ,wart_plan_id
        ,wart_plan_pos_bez
        ,tp_objekt_id
        ,plantyp_id
        ,plangruppe_id
        ,plangruppenzaehler
        ,werk_id
        ,wart_plan_status
        ,standort_kontierung_id
        ,instandhaltung_leistungsart_id
        ,qual_meldung_id


FROM DBP_DATA.IN_WARTUNGSPLAN_DET ;