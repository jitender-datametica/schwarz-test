CREATE OR REPLACE VIEW DBP_VIEW.V_AAD_REQUEST_TYPE_SPR_ZU AS 
    SELECT 
        request_type_id,
        mandant_id,
        spr_id,
        request_type_descr

FROM DBP_DATA.AAD_REQUEST_TYPE_SPR_ZU ;