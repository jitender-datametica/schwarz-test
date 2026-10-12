CREATE OR REPLACE VIEW DBP_VIEW.V_VERRECHFALL AS 
    SELECT 
        mandant_id
        ,verrechfall_id
        ,belos_adresse_empfaenger_id
        ,belos_vorgang_id
        ,verrechfallart_id
        ,wrg_id
        ,storno_fg
        ,betrag_pauschalfracht
        ,betrag_fracht
        ,verrechfall_status_id
        ,belos_leistungsart_id
        ,kunde_fg
        ,fracht_satz_prz
        ,fracht_satz_prz_pro_einh
        ,teilstrecke_nr
        ,belosart_fg
        ,belos_adresse_rechnung_uid
        ,belos_adresse_rechnung_id
        ,belos_adresse_rechnung_name
        ,belos_adresse_steuerung_uid
        ,belos_adresse_steuerung_id
        ,belos_adresse_steuerung_name


FROM DBP_DATA.verrechfall ;