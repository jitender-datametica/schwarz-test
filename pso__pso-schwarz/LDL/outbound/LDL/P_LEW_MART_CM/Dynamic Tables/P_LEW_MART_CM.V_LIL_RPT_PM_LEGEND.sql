
CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_cm.v_lil_rpt_pm_legend
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT CAST(RPL.legend_id AS BIGNUMERIC) AS legend_id,
 CAST(RPL.rate_coverage AS BIGNUMERIC) AS rate_coverage,
 CAST(COALESCE(TRDE.trans_text, RPL.desc_coverage) AS STRING) AS desc_coverage,
 CAST(COALESCE(TREN.trans_text, RPL.desc_coverage) AS STRING) AS desc_coverage_en,
 CAST(RPL.rate_trend AS BIGNUMERIC) AS rate_trend,
 CAST(COALESCE(TRDET.trans_text, RPL.desc_trend) AS STRING) AS desc_trend,
 CAST(COALESCE(TRENT.trans_text, RPL.desc_trend) AS STRING) AS desc_trend_en,
 CAST(RPL.rate_direction AS BIGNUMERIC) AS rate_direction,
 CAST(COALESCE(TRDED.trans_text, RPL.desc_direction) AS STRING) AS desc_direction,
 CAST(COALESCE(TREND.trans_text, RPL.desc_direction) AS STRING) AS desc_direction_en,
 CAST(RPL.rate_trend_dev AS BIGNUMERIC) AS rate_trend_dev,
 CAST(COALESCE(TRDETD.trans_text, RPL.desc_trend_dev) AS STRING) AS desc_trend_dev,
 CAST(COALESCE(TRENTD.trans_text, RPL.desc_trend_dev) AS STRING) AS desc_trend_dev_en
FROM ldl_p_lew_process_mstr_ac.v_lil_rpt_pm_legend AS RPL
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation AS TRDE ON TRDE.context = 'RPL_DESC_COVERAGE' AND RPL.legend_id =
     TRDE.trans_id AND TRDE.lang_cd = 'DE' AND TRDE.active_fg = 1
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation AS TREN ON TREN.context = 'RPL_DESC_COVERAGE' AND RPL.legend_id =
     TREN.trans_id AND TREN.lang_cd = 'EN' AND TREN.active_fg = 1
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation AS TRDET ON TRDET.context = 'RPL_DESC_TREND' AND RPL.legend_id =
     TRDET.trans_id AND TRDET.lang_cd = 'DE' AND TRDET.active_fg = 1
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation AS TRENT ON TRENT.context = 'RPL_DESC_TREND' AND RPL.legend_id =
     TRENT.trans_id AND TRENT.lang_cd = 'EN' AND TRENT.active_fg = 1
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation AS TRDED ON TRDED.context = 'RPL_DESC_DIRECTION' AND RPL.legend_id
      = TRDED.trans_id AND TRDED.lang_cd = 'DE' AND TRDED.active_fg = 1
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation AS TREND ON TREND.context = 'RPL_DESC_DIRECTION' AND RPL.legend_id
      = TREND.trans_id AND TREND.lang_cd = 'EN' AND TREND.active_fg = 1
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation AS TRDETD ON TRDETD.context = 'RPL_DESC_TREND_DEV' AND RPL.legend_id
      = TRDETD.trans_id AND TRDETD.lang_cd = 'DE' AND TRDETD.active_fg = 1
 LEFT JOIN ldl_p_lew_process_mstr_ac.v_lil_translation AS TRENTD ON TRENTD.context = 'RPL_DESC_TREND_DEV' AND RPL.legend_id
      = TRENTD.trans_id AND TRENTD.lang_cd = 'EN' AND TRENTD.active_fg = 1;


