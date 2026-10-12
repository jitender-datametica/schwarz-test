CREATE OR REPLACE MATERIALIZED VIEW ldl_fe_mstr_xsight.v_dim_item_grp
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
SELECT DISTINCT COALESCE(item_grp_int_cd, '-1') AS item_grp_int_cd,
 MAX(COALESCE(item_grp_int_name_en, 'N/A')) AS item_grp_int_name_en,
 MAX(COALESCE(item_grp_int_name_de, 'N/A')) AS item_grp_int_name,
 MAX(item_grp_int_cd || ' ' || item_grp_int_name_de) AS item_grp_name2,
 MAX(item_grp_int_cd || ' ' || item_grp_int_name_en) AS item_grp_name2_en
FROM ldl_p_lew_core_ac.v_market_research_product
GROUP BY v_market_research_product.item_grp_int_cd;