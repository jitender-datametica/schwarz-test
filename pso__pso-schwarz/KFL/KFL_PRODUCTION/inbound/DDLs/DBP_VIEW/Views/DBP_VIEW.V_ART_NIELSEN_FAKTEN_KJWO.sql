CREATE OR REPLACE VIEW DBP_VIEW.V_ART_NIELSEN_FAKTEN_KJWO AS 
    SELECT 
        mandant_id
        ,kjwo
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
        ,distr_num_4_wo
        ,distr_gew_4_wo


FROM DBP_DATA.art_nielsen_fakten_kjwo ;