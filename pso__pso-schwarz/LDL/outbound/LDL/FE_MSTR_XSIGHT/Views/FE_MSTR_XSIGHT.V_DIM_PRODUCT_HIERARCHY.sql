CREATE OR REPLACE VIEW ldl_fe_mstr_xsight.v_dim_product_hierarchy (hierarchy_type_cd, prod_sid,
rel_market_research_prod_sid, dwh_valid_from, dwh_valid_to) AS SELECT market_research_prod_hierarchy_type_cd AS
 hierarchy_type_cd,
 market_research_prod_sid AS prod_sid,
 rel_market_research_prod_sid,
 dwh_valid_from,
 dwh_valid_to
FROM ldl_p_lew_core.t_market_research_product_hierarchy;