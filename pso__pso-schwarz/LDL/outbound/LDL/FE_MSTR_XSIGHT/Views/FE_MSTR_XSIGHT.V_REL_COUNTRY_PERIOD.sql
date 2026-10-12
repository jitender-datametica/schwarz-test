CREATE OR REPLACE VIEW ldl_fe_mstr_xsight.v_rel_country_period (period_type_cd, country_cd) AS SELECT DISTINCT PER2.market_research_period_type_cd
  AS period_type_cd,
 FACT.market_research_country_cd AS country_cd
FROM ldl_p_lew_core_ac.v_market_research_metric AS FACT
 INNER JOIN ldl_p_lew_core_ac.v_market_research_period AS PERIOD ON FACT.market_research_period_sid = PERIOD.market_research_period_sid
  
 INNER JOIN ldl_p_lew_core_ac.v_market_research_period_relation AS REL ON PERIOD.market_research_period_sid = REL.market_research_period_sid
  
 INNER JOIN ldl_p_lew_core_ac.v_market_research_period AS PER2 ON REL.rel_market_research_period_sid = PER2.market_research_period_sid;