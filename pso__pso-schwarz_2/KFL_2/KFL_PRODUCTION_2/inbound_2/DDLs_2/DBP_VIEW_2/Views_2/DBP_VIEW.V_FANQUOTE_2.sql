CREATE OR REPLACE VIEW DBP_VIEW.V_fanquote_2 AS 
    SELECT 
        mandant_id,
        matching_id,
        kjwo_update,
        d423_fanquote,
        a507_umsatz_cardholder,
        a508_anteil_SA_cardholder,
        a509_anz_kaeufer,
        substitute_matching_id
FROM DBP_DATA.fanquote_2 ;