CREATE OR REPLACE VIEW DBP_VIEW.V_ART_LAGERNUMMER_ZU_PER_EWM_1 AS 
    SELECT 
        mandant_id
        ,art_guid_c22
        ,art_id
        ,scu_guid
        ,lagernummer_id
        ,verfuegungsberechtigter_guid
        ,dat_von
        ,dat_bis
        ,loesch_fg
        ,einlager_steuerung_id
        ,lagerplatztyp_id
        ,blocklagertyp_id
        ,auslager_steuerung_id
        ,lagerbereichskennzeichen_id
        ,verpackungsklasse_id
        ,anz_ladtraeger_max
        ,artikelsortiment_id
        ,referenzgewicht_id
        ,dat_we_check
        ,anz_tage_bis_we_check
        ,stellplatz_faktor
        ,automation_kennz
        ,datzeit_aenderung


FROM DBP_DATA.art_lagernummer_zu_per_ewm_1 ;