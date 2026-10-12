CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_retail_store_customer_review AS SELECT ext_customer_review_id
 ,
 ext_system_name,
 wup_id,
 mandant_id,
 ext_retail_company_id,
 ext_store_id,
 DATE(review_tmsp) AS review_dat,
 review_rating,
 2 AS sec_kz,
 review_native_txt,
 review_english_txt,
 review_status_cd
FROM kfl_production_dbp_view.v_retail_store_customer_review;