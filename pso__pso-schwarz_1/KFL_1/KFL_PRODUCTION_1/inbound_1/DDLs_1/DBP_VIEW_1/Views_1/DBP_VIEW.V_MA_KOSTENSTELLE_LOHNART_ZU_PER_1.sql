CREATE OR REPLACE VIEW DBP_VIEW.V_MA_KOSTENSTELLE_LOHNART_ZU_PER_1 AS 
    SELECT 
        mandant_id
        ,kostenstelle_id
        ,mitarbeiter_id
        ,lohnart_id
        ,zeitart_id
        ,kjmo
        ,kostenstelle_von_id
        ,kostenstelle_nach_id
        ,abrechnung_fuer_periode
        ,abrechnungstyp_fuer_periode
        ,zahlung_dat
        ,krk_id
        ,abrechnung_in_periode
        ,anzahl_lohnart
        ,system_id
FROM DBP_DATA.MA_KOSTENSTELLE_LOHNART_ZU_PER_1 ;