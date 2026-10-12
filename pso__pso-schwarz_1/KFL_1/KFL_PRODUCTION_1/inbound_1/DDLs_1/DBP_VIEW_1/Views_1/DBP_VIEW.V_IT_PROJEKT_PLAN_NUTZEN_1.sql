CREATE OR REPLACE VIEW DBP_VIEW.V_IT_PROJEKT_PLAN_NUTZEN_1 AS 
    SELECT 
        it_projekt_id
        ,plan_revision_id
        ,gj
        ,einm_nutzen_betrag
        ,lfd_nutzen_betrag


FROM DBP_DATA.it_projekt_plan_nutzen_1 ;