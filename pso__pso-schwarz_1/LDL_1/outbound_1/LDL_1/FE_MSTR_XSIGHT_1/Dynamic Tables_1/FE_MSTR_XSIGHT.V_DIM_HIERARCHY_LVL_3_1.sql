CREATE OR REPLACE MATERIALIZED VIEW ldl_fe_mstr_xsight.v_dim_hierarchy_lvl_3_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT DISTINCT COALESCE(data_provider_hierarchy_lvl_3_name, 'N/A') AS hierarchy_lvl_3,
 market_research_country_cd AS country_cd
FROM ldl_p_lew_core_ac.v_market_research_product_1
WHERE market_research_data_src_name = 'Retail Panel FMCG'
 AND market_research_data_provider_name = 'Nielsen IQ';