CREATE OR REPLACE VIEW DBP_VIEW.V_EKC_PLANWERTE_1 AS 
    SELECT 
        mandant_id
        ,hwg_id
        ,arthiertyp_id
        ,dat
        ,wrg_id
        ,abschriftsbetrag_werbung_netto
        ,umsatz_netto_sa
        ,umsatz_netto_af
        ,abschriftsbetrag_ohne_werbung_netto
        ,wa_kalk_netto
        ,wa_kalk_netto_af
        ,wa_kalk_netto_sa


FROM DBP_DATA.ekc_planwerte_1 ;