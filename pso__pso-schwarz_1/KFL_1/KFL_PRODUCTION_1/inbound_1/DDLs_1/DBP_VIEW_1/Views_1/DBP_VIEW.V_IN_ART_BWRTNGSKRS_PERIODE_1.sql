CREATE OR REPLACE VIEW DBP_VIEW.V_IN_ART_BWRTNGSKRS_PERIODE_1 AS 
    SELECT 
        mandant_id
        ,gjmo
        ,bewertungskreis_id
        ,in_art_id
        ,wrg_id
        ,dat_aenderung
        ,gjmo_bis
        ,mbew_fg
        ,menge_bestand_bme
        ,wert_bestand
FROM DBP_DATA.in_art_bwrtngskrs_periode_1 ;