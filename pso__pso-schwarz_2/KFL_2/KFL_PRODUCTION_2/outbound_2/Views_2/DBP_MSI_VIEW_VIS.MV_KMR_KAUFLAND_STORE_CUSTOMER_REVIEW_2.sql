CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_kmr_kaufland_store_customer_review_2 (mandant_id, system_name,
nb_id, wup_id, dat, kfl_review_rating, kfl_review_nmbr, kfl_review_id, kfl_review_tmsp) AS SELECT RSR.mandant_id,
 RSR.ext_system_name AS system_name,
 RSR.nb_id,
 WUP.aktuell_wup_id AS wup_id,
 DATE(RSR.review_tmsp) AS dat,
 RSR.review_rating AS kfl_review_rating,
 1 AS kfl_review_nmbr,
 RSR.ext_customer_review_id AS kfl_review_id,
 RSR.review_tmsp AS kfl_review_tmsp
FROM kfl_production_dbp_view.v_retail_store_customer_review_2 AS RSR
 INNER JOIN kfl_production_dbp_view.v_retail_company_2 AS RCO ON RSR.ext_retail_company_id = RCO.ext_retail_company_id AND
   RSR.ext_system_name = RCO.ext_system_name
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON RSR.mandant_id = WUP.mandant_id AND RSR.wup_id = WUP.wup_id
WHERE RCO.competitor_fg <> 1;