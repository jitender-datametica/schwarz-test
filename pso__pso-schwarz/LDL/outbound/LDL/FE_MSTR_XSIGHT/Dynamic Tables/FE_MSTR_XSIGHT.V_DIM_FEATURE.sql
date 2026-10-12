CREATE OR REPLACE MATERIALIZED VIEW ldl_fe_mstr_xsight.v_dim_feature
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT DISTINCT market_research_prod_sid,
 feature_sid,
 market_research_prod_feature_txt,
 dwh_valid_from,
 dwh_valid_to
FROM ldl_p_lew_core_ac.v_market_research_product_feature;