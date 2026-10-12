CREATE OR REPLACE VIEW DBP_VIEW.V_IT_PROJEKT_PLAN_DET AS 
    SELECT 
        it_projekt_id
        ,plan_revision_id
        ,berichts_position_it_id
        ,gj
        ,sparte_id
        ,plan_betrag
        ,plan_betrag_betrieb
        ,ahk_aufwand_kz
        ,ahk_euro
        ,ahk_quote
        ,aufwand_euro


FROM DBP_DATA.it_projekt_plan_det ;