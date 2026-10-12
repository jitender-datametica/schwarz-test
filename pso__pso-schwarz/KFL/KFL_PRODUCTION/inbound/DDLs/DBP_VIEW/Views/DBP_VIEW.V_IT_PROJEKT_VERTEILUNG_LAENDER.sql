CREATE OR REPLACE VIEW DBP_VIEW.V_IT_PROJEKT_VERTEILUNG_LAENDER AS 
    SELECT 
        it_plan_ebene_id
        ,it_projekt_id
        ,berichts_position_it_id
        ,gj
        ,verteilung_betrag
        ,verteilung_quote


FROM DBP_DATA.it_projekt_verteilung_laender ;