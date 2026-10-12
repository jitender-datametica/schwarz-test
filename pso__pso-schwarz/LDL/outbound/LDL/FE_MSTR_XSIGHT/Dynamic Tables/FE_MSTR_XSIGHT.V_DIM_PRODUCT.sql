CREATE OR REPLACE MATERIALIZED VIEW ldl_fe_mstr_xsight.v_dim_product
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT DISTINCT market_research_prod_sid AS prod_sid,
 market_research_country_cd AS country_cd,
 market_research_prod_name AS prod_name,
 market_research_prod_type_cd AS hierarchy_level_0,
 market_research_data_src_name AS data_src_name,
 market_research_data_src_segment_name AS data_src_segment_name,
 market_research_data_provider_name AS data_provider_name,
 COALESCE(brand_name, 'N/A') AS brand_name,
 own_brand_fg,
 COALESCE(manufacturer_name, 'N/A') AS manufacturer_name,
 COALESCE(sub_brand_name, 'N/A') AS sub_brand_name,
 COALESCE(item_fam_grp_cd, '-1') AS item_fam_grp_cd,
 COALESCE(sub_item_grp_cd, '-1') AS sub_item_grp_cd,
 COALESCE(item_grp_int_cd, '-1') AS item_grp_int_cd,
 COALESCE(data_provider_hierarchy_lvl_1_name, 'N/A') AS hierarchy_lvl_1,
 COALESCE(data_provider_hierarchy_lvl_2_name, 'N/A') AS hierarchy_lvl_2,
 COALESCE(data_provider_hierarchy_lvl_3_name, 'N/A') AS hierarchy_lvl_3,
 COALESCE(data_provider_hierarchy_lvl_4_name, 'N/A') AS hierarchy_lvl_4,
 COALESCE(data_provider_hierarchy_lvl_5_name, 'N/A') AS hierarchy_lvl_5,
 COALESCE(data_provider_hierarchy_2nd_lowest_lvl_name, 'N/A') AS hierarchy_2nd_lowest_lvl,
 COALESCE(data_provider_hierarchy_lowest_lvl_name, 'N/A') AS hierarchy_lowest_lvl
FROM ldl_p_lew_core_ac.v_market_research_product AS P;