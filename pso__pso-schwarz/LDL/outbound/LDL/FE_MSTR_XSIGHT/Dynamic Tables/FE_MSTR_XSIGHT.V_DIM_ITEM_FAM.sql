CREATE OR REPLACE MATERIALIZED VIEW ldl_fe_mstr_xsight.v_dim_item_fam
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
SELECT DISTINCT COALESCE(item_fam_grp_cd, '-1') AS item_fam_grp_cd,
 MAX(COALESCE(item_fam_grp_name_de, 'N/A')) AS item_fam_grp_name,
 MAX(COALESCE(item_fam_grp_name_en, 'N/A')) AS item_fam_grp_name_en,
 MAX(COALESCE(item_fam_grp_cd, '-1') || ' ' || COALESCE(item_fam_grp_name_de, 'N/A')) AS item_fam_grp_name2,
 MAX(COALESCE(item_fam_grp_cd, '-1') || ' ' || COALESCE(item_fam_grp_name_en, 'N/A')) AS item_fam_grp_name2_en
FROM ldl_p_lew_core_ac.v_market_research_product
GROUP BY v_market_research_product.item_fam_grp_cd;