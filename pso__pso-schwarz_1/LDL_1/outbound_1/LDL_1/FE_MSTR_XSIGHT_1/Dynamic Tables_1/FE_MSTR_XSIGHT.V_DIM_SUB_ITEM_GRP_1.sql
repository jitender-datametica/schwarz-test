CREATE OR REPLACE MATERIALIZED VIEW ldl_fe_mstr_xsight.v_dim_sub_item_grp_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
SELECT DISTINCT COALESCE(sub_item_grp_cd, '-1') AS sub_item_grp_cd,
 MAX(sub_item_grp_name_de) AS sub_item_grp_name,
 MAX(sub_item_grp_name_en) AS sub_item_grp_name_en,
 MAX(sub_item_grp_cd || ' ' || sub_item_grp_name_de) AS sub_item_grp_name2,
 MAX(sub_item_grp_cd || ' ' || sub_item_grp_name_en) AS sub_item_grp_name2_en
FROM ldl_p_lew_core_ac.v_market_research_product_1
GROUP BY v_market_research_product.sub_item_grp_cd;