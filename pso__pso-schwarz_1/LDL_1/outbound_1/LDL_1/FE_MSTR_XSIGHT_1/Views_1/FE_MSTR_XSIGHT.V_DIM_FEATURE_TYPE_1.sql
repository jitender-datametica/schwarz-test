CREATE OR REPLACE VIEW ldl_fe_mstr_xsight.v_dim_feature_type_1 (feature_sid, feature_cd, feature_descr, country_cd,
data_provider_name, data_src_name) AS SELECT DISTINCT feature_sid,
 feature_cd,
 feature_descr,
 market_research_country_cd AS country_cd,
 market_research_data_provider_name AS data_provider_name,
 market_research_data_src_name AS data_src_name
FROM ldl_p_lew_core_ac.v_market_research_product_feature_type_1;