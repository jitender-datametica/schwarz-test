CREATE OR REPLACE VIEW DBP_VIEW.V_ART_NIELSEN_FAKTEN_KJMO_2 AS 
    SELECT 
        mandant_id
        ,kjmo
        ,nielsen_market_id
        ,art_nielsen_id
        ,wrg_id
        ,umsatz_brutto
        ,umsatz_brutto_af
        ,umsatz_brutto_sa
        ,menge
        ,menge_af
        ,menge_sa
        ,distr_num
        ,distr_gew
        ,anz_maerkte
        ,menge_verkaufseinheiten_normiert


FROM DBP_DATA.art_nielsen_fakten_kjmo_2 ;