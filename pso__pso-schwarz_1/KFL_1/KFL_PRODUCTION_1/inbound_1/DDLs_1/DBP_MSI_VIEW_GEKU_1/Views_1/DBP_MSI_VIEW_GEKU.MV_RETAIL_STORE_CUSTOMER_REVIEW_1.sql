CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_RETAIL_STORE_CUSTOMER_REVIEW_1 
AS
--21.11.2024 twie: SPEC0267631 PK wird geändert von retail_company_sid auf ext_retail_company_id, store und customer_review analog
--27.11.2024 twie: SPEC0267631 Felder mit sid werden komplett entfernt

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