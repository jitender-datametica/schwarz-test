CREATE OR REPLACE VIEW ldl_fe_mstr_xsight.v_dim_benchmark_channel (channel_name, data_provider_name, data_src_name,
country_cd, data_src_segment_name, channel_sid, benchmark_channel_fg) AS SELECT CH.market_research_channel_name AS
 channel_name,
 BCH.market_research_data_provider_name AS data_provider_name,
 BCH.market_research_data_src_name AS data_src_name,
 BCH.market_research_country_cd AS country_cd,
 BCH.market_research_data_src_segment_name AS data_src_segment_name,
 BCH.market_research_channel_sid AS channel_sid,
 BCH.default_benchmark_channel_fg AS benchmark_channel_fg
FROM ldl_p_lew_core_ac.v_market_research_benchmark_channel AS BCH
 INNER JOIN ldl_p_lew_core_ac.v_market_research_channel AS CH ON BCH.market_research_data_provider_name = CH.market_research_data_provider_name
     AND BCH.market_research_data_src_name = CH.market_research_data_src_name AND BCH.market_research_channel_sid = CH.market_research_channel_sid;