CREATE OR REPLACE VIEW DBP_VIEW.V_IN_WARTUNGSPLAN_ABRUF AS 
    SELECT 
        mandant_id,
        wart_plan_id,
        wart_plan_abruf_id,
        wart_plan_pos_id,
        auftrag_id,
        dat_start_geplant,
        dat_start,
        dat_abschluss,
        qual_meldung_id

FROM DBP_DATA.IN_WARTUNGSPLAN_ABRUF ;