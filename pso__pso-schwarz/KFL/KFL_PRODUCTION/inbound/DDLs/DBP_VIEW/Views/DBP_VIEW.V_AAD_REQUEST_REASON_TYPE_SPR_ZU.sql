CREATE OR REPLACE VIEW DBP_VIEW.V_AAD_REQUEST_REASON_TYPE_SPR_ZU AS 
    SELECT 
        request_reason_type_id,
        mandant_id,
        spr_id,
        request_reason_type_descr

FROM DBP_DATA.AAD_REQUEST_REASON_TYPE_SPR_ZU ;