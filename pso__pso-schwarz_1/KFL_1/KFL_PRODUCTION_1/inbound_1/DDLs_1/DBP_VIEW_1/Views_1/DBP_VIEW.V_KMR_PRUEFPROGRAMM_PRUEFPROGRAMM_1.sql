CREATE OR REPLACE VIEW DBP_VIEW.V_KMR_PRUEFPROGRAMM_PRUEFPROGRAMM_1 AS 
    SELECT 
        amx_system_id
        ,pruefprogramm_id
        ,pruefung_id
        ,kapitel_nr
        ,sort_nr
        ,fehlerverdacht_fg
        ,pruefprogramm_bez
        ,gepr_prozess_id
        ,ergebnis
        ,ergebnis_berechnet
        ,ergebnis_manuell


FROM DBP_DATA.KMR_PRUEFPROGRAMM_PRUEFPROGRAMM_1 ;