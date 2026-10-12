CREATE OR REPLACE VIEW DBP_VIEW.V_DRA_WUP_TAG AS 
    SELECT 
        mandant_id
        ,wup_id
        ,dat
        ,betrag_dra
        ,anz_bon
        ,wrg_id
FROM DBP_DATA.dra_wup_tag ;