CREATE OR REPLACE VIEW ldl_fe_mstr_xsight.v_dim_region_1 (region_sid, region_name, country_cd, loc_sid_wh, sort_id,
region_type_cd, data_provider_name, data_src_name) AS SELECT market_research_region_sid AS region_sid,
 market_research_region_name AS region_name,
 market_research_country_cd AS country_cd,
 loc_sid_wh,
 display_seq AS sort_id,
 market_research_region_type_cd AS region_type_cd,
 market_research_data_provider_name AS data_provider_name,
 market_research_data_src_name AS data_src_name
FROM ldl_p_lew_core_ac.v_market_research_region_1;