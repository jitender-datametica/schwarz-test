CREATE OR REPLACE MATERIALIZED VIEW ldl_fe_mstr_xsight.v_rel_item_grp_sub_item_grp_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT DISTINCT sub_item_grp_cd,
 item_grp_int_cd,
 item_fam_grp_cd
FROM ldl_p_lew_core_ac.v_market_research_product_1;