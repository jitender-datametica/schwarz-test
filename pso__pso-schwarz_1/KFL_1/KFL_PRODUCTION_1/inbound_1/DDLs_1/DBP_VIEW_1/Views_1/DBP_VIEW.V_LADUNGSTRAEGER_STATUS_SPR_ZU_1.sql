CREATE OR REPLACE VIEW DBP_VIEW.V_LADUNGSTRAEGER_STATUS_SPR_ZU_1 AS 
    SELECT 
        mandant_id
        ,spr_id
        ,ladungstraeger_status_id
        ,ladungstraeger_status_bez


FROM DBP_DATA.ladungstraeger_status_spr_zu_1 ;