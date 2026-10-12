CREATE OR REPLACE VIEW DBP_VIEW.V_BELOS_TRANSPORTAUFTRAG_AUFWAND_UPLOAD_1 AS 
    SELECT 
        mandant_id
        ,belos_vorgang_id
        ,transportauftrag_id
        ,wrg_id
        ,aufwand_vorlauf
        ,aufwand_hauptlauf
        ,aufwand_umschlag
        ,aufwand_diesel
        ,aufwand_gesamt


FROM DBP_DATA.belos_transportauftrag_aufwand_upload_1 ;