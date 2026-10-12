create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_RETAIL_STORE_CUSTOMER_REVIEW_1(
	EXT_CUSTOMER_REVIEW_ID,
	EXT_SYSTEM_NAME,
	WUP_ID,
	MANDANT_ID,
	EXT_RETAIL_COMPANY_ID,
	EXT_STORE_ID,
	REVIEW_DAT,
	REVIEW_RATING,
	SEC_KZ,
	REVIEW_NATIVE_TXT,
	REVIEW_ENGLISH_TXT,
	REVIEW_STATUS_CD
) as



SELECT   ext_customer_review_id
        ,ext_system_name
        ,wup_id
        ,mandant_id
        ,ext_retail_company_id
        ,ext_store_id
        ,DATE(review_tmsp) AS review_dat
        ,review_rating
        , 2::BYTEINT AS sec_kz
        ,REVIEW_NATIVE_TXT
        ,REVIEW_ENGLISH_TXT
        ,REVIEW_STATUS_CD
FROM dbp_view.v_retail_store_customer_review_1 
;