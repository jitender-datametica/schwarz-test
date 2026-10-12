CREATE OR REPLACE VIEW DBP_VIEW.V_KMR_PRUEFPROGRAMM_UNTERBEREICH_2 AS 
    SELECT 
        amx_system_id
        ,unterbereich_id
        ,pruefung_id
        ,teilbereich_id
        ,hauptbereich_id
        ,pruefprogramm_id
        ,kapitel_nr
        ,sort_nr
        ,fehlerverdacht_fg
        ,unterbereich_bez
        ,gepr_prozess_id
        ,ergebnis
        ,ergebnis_berechnet
        ,ergebnis_manuell


FROM DBP_DATA.KMR_PRUEFPROGRAMM_UNTERBEREICH_2 ;