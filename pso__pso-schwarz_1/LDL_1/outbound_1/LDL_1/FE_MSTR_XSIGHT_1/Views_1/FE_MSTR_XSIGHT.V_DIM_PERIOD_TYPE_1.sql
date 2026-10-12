CREATE OR REPLACE VIEW ldl_fe_mstr_xsight.v_dim_period_type_1 (period_type_cd, period_type_descr) AS SELECT DISTINCT BP.market_research_period_type_cd
  AS period_type_cd,
 PT.market_research_period_type_descr AS period_type_descr
FROM ldl_p_lew_core_ac.v_market_research_period_1 AS BP
 INNER JOIN ldl_p_lew_core_ac.v_market_research_period_relation_1 AS PR ON BP.market_research_period_sid = PR.rel_market_research_period_sid
   -- GET NIELSEN PERIOD
 AND PR.market_research_period_rel_type_cd = 'src_to_bc'
 INNER JOIN ldl_p_lew_core_ac.v_local_market_research_period_1 AS LP ON PR.market_research_period_sid
  -- GET LOCAL PERIOD BY COUNTRY_1 AND SRC_SEGMENT
 = LP.market_research_period_sid
 INNER JOIN ldl_p_lew_core_ac.v_market_research_period_relation_1 AS PYPR ON BP.market_research_period_sid = PYPR.market_research_period_sid
   -- GET PREVIOUS YEAR BUSINESS PERIOD
 AND PYPR.market_research_period_rel_type_cd = 'prev_year'
 INNER JOIN ldl_p_lew_core_ac.v_market_research_period_1 AS PYBP ON PYPR.rel_market_research_period_sid = PYBP.market_research_period_sid
  
 INNER JOIN ldl_p_lew_core_ac.v_market_research_period_relation_1 AS PRPYLP ON PYPR.rel_market_research_period_sid =
   PRPYLP.rel_market_research_period_sid -- GET PREVIOS YEAR NIELSEN PERIOD
 AND PRPYLP.market_research_period_rel_type_cd
    = 'src_to_bc'
 INNER JOIN ldl_p_lew_core_ac.v_local_market_research_period_1 AS PYLP ON PRPYLP.market_research_period_sid
  -- GET PREVIOS YEAR LOCAL PERIOD BY COUNTRY_1 AND SRC_SEGMENT
 = PYLP.market_research_period_sid
 INNER JOIN ldl_p_lew_core_ac.v_market_research_period_type_1 AS PT ON BP.market_research_period_type_cd = PT.market_research_period_type_cd
  -- GET PREVIOS YEAR LOCAL PERIOD BY COUNTRY_1 AND SRC_SEGMENT
;