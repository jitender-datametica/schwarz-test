CREATE OR REPLACE VIEW DBP_VIEW.V_AAD_REQUEST_STATUS_TYPE_SPR_ZU_2 AS 
    SELECT 
        request_status_type_id,
        mandant_id,
        spr_id,
        request_status_type_descr

FROM DBP_DATA.AAD_REQUEST_STATUS_TYPE_SPR_ZU_2 ;