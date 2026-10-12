CREATE OR REPLACE MATERIALIZED VIEW ldl_fe_mstr_xsight.v_dim_sub_brand_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT DISTINCT COALESCE(sub_brand_name, 'N/A') AS sub_brand_name,
 market_research_country_cd AS country_cd
FROM ldl_p_lew_core_ac.v_market_research_product_1;