CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_kmr_competitor_store_1 (mandant_id, system_name,
competitor_store_id, competitor_store_name, competitor_store_address, competitor_company_id, breitengrad, laengengrad,
competitor_wup_id) AS SELECT RST.mandant_id,
 RST.ext_system_name AS system_name,
 RST.ext_store_id AS competitor_store_id,
 RST.retail_store_name AS competitor_store_name,
 RST.retail_store_address AS competitor_store_address,
 RST.ext_retail_company_id AS competitor_company_id,
 RST.breitengrad,
 RST.laengengrad,
 RST.competitor_wup_id
FROM kfl_production_dbp_view.v_retail_store_1 AS RST
 INNER JOIN kfl_production_dbp_view.v_retail_company_1 AS RCO ON RST.ext_retail_company_id = RCO.ext_retail_company_id AND
   RST.ext_system_name = RCO.ext_system_name
WHERE RCO.competitor_fg = 1;