create or replace view KFL_PRODUCTION.DBP_VIEW.V_AAD_REQUEST_TYPE_SPR_ZU_2(
	REQUEST_TYPE_ID,
	MANDANT_ID,
	SPR_ID,
	REQUEST_TYPE_DESCR
) as 
    SELECT 
        request_type_id,
        mandant_id,
        spr_id,
        request_type_descr

FROM DBP_DATA.AAD_REQUEST_TYPE_SPR_ZU_2 ;