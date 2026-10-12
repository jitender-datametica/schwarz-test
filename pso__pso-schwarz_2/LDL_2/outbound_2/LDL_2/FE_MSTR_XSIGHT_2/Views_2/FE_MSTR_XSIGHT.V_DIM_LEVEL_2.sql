CREATE OR REPLACE VIEW ldl_fe_mstr_xsight.v_dim_level_2 (level_cd) AS SELECT DISTINCT market_research_prod_type_cd AS
 level_cd
FROM ldl_p_lew_core_ac.v_market_research_product_2;