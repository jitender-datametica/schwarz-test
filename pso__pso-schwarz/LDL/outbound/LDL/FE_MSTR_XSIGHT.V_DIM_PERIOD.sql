CREATE OR REPLACE VIEW ldl_fe_mstr_xsight.v_dim_period (period_sid, period_sid_py, period_name_py, calendar_name,
period_name, period_type_cd) AS SELECT DISTINCT BP.market_research_period_sid AS period_sid,
 PYBP.market_research_period_sid AS period_sid_py,
 PYBP.market_research_period_name AS period_name_py,
 BP.market_research_calendar_name AS calendar_name,
 BP.market_research_period_name AS period_name,
 BP.market_research_period_type_cd AS period_type_cd
FROM ldl_p_lew_core_ac.v_market_research_period AS BP
 INNER JOIN ldl_p_lew_core_ac.v_market_research_period_relation AS PR ON BP.market_research_period_sid = PR.rel_market_research_period_sid
    AND PR.market_research_period_rel_type_cd = 'src_to_bc'
 INNER JOIN ldl_p_lew_core_ac.v_local_market_research_period AS LP ON PR.market_research_period_sid = LP.market_research_period_sid
  
 INNER JOIN ldl_p_lew_core_ac.v_market_research_period_relation AS PYPR ON PYPR.market_research_period_rel_type_cd =
  'prev_year'
 INNER JOIN ldl_p_lew_core_ac.v_market_research_period AS PYBP ON PYPR.rel_market_research_period_sid = PYBP.market_research_period_sid
  
 INNER JOIN ldl_p_lew_core_ac.v_market_research_period_relation AS PRPYLP ON PYPR.rel_market_research_period_sid =
   PRPYLP.rel_market_research_period_sid AND PRPYLP.market_research_period_rel_type_cd = 'src_to_bc'
 INNER JOIN ldl_p_lew_core_ac.v_local_market_research_period AS PYLP ON PRPYLP.market_research_period_sid = PYLP.market_research_period_sid;