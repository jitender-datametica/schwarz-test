create or replace view KFL_PRODUCTION.DBP_VIEW.V_AAD_REQUEST_REASON_TYPE_SPR_ZU_2(
	REQUEST_REASON_TYPE_ID,
	MANDANT_ID,
	SPR_ID,
	REQUEST_REASON_TYPE_DESCR
) as 
    SELECT 
        request_reason_type_id,
        mandant_id,
        spr_id,
        request_reason_type_descr

FROM DBP_DATA.AAD_REQUEST_REASON_TYPE_SPR_ZU_2 ;