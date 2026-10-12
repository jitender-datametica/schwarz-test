CREATE OR REPLACE VIEW DBP_VIEW.V_RPM_IMMOBILIE_PER_2 AS 
    SELECT 
        rpm_hierarchie_id
        ,dat_von
        ,techn_platz_id
        ,vs_id
        ,mandant_id
        ,wrg_id
        ,gesamtbew_note
        ,bewertungszahl_a
        ,bewertungszahl_b
        ,bewertungszahl_c
        ,dat_bis
        ,gj_umbvorschl
        ,wup_id
        ,nb_id
        ,wup_standort
        ,strasse
        ,plz
        ,zielumsatz_3gj
        ,dat_eroeffn_fb_imm
        ,uebernahme_von
FROM DBP_DATA.rpm_immobilie_per_2 ;