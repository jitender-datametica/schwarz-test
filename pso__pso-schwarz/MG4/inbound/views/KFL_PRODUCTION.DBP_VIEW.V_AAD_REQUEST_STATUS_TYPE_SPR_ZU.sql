create or replace view KFL_PRODUCTION.DBP_VIEW.V_AAD_REQUEST_STATUS_TYPE_SPR_ZU(
	REQUEST_STATUS_TYPE_ID,
	MANDANT_ID,
	SPR_ID,
	REQUEST_STATUS_TYPE_DESCR
) as 
    SELECT 
        request_status_type_id,
        mandant_id,
        spr_id,
        request_status_type_descr

FROM DBP_DATA.AAD_REQUEST_STATUS_TYPE_SPR_ZU ;