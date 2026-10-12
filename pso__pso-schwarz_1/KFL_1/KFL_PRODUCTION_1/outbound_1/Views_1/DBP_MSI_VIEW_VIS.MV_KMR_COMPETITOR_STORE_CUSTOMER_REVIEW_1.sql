CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_kmr_competitor_store_customer_review_1 (mandant_id, system_name
, competitor_store_id, dat, competitor_review_rating, competitor_review_nmbr, competitor_review_id,
competitor_review_tmsp) AS SELECT RSR.mandant_id,
 RSR.ext_system_name AS system_name,
 RSR.ext_store_id AS competitor_store_id,
 DATE(RSR.review_tmsp) AS dat,
 RSR.review_rating AS competitor_review_rating,
 1 AS competitor_review_nmbr,
 RSR.ext_customer_review_id AS competitor_review_id,
 RSR.review_tmsp AS competitor_review_tmsp
FROM kfl_production_dbp_view.v_retail_store_customer_review_1 AS RSR
 INNER JOIN kfl_production_dbp_view.v_retail_company_1 AS RCO ON RSR.ext_retail_company_id = RCO.ext_retail_company_id AND
   RSR.ext_system_name = RCO.ext_system_name
WHERE RCO.competitor_fg = 1;