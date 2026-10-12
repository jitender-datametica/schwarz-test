CREATE OR REPLACE MATERIALIZED VIEW ldl_fe_mstr_xsight.v_dim_brand
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT DISTINCT COALESCE(brand_name, 'N/A') AS brand_name,
 market_research_country_cd AS country_cd,
 own_brand_fg
FROM ldl_p_lew_core_ac.v_market_research_product;