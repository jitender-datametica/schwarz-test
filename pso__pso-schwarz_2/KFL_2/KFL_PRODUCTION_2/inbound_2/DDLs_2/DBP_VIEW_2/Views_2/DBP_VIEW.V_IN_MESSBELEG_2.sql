CREATE OR REPLACE VIEW DBP_VIEW.V_IN_MESSBELEG_2 AS 
    SELECT 
        mandant_id
        ,messbeleg_id
        ,auftrag_id
        ,auftrag_nr
        ,messpunkt_id
        ,dat_messung
        ,messwert
        ,menge_einh_id_messung


FROM DBP_DATA.in_messbeleg_2 ;