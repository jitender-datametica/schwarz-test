CREATE OR REPLACE VIEW ldl_fe_mstr_xsight.v_dim_country_2 (country_cd, country_name) AS SELECT DISTINCT C.market_research_country_cd
  AS country_cd,
 C.market_research_country_name AS country_name
FROM ldl_p_lew_core_ac.v_market_research_country_2 AS C
 INNER JOIN ldl_p_lew_core_ac.v_market_research_data_delivery_2 AS DD ON C.market_research_country_cd = DD.market_research_country_cd;