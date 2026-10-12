
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_RPT_PM_LEGEND
(
 legend_id
 ,rate_coverage
 ,desc_coverage
 ,desc_coverage_EN
 ,rate_trend
 ,desc_trend
 ,desc_trend_EN
 ,rate_direction
 ,desc_direction
 ,desc_direction_EN
 ,rate_trend_dev
 ,desc_trend_dev
 ,desc_trend_dev_EN
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM
AS
SELECT 
 CAST(rpl.legend_id AS SMALLINT) AS legend_id
 ,CAST(rpl.rate_coverage AS SMALLINT) AS rate_coverage
 ,CAST(COALESCE(trde.trans_text, rpl.desc_coverage) AS VARCHAR(128)) AS desc_coverage
 ,CAST(COALESCE(tren.trans_text, rpl.desc_coverage) AS VARCHAR(128)) AS desc_coverage_EN
 ,CAST(rpl.rate_trend AS SMALLINT) AS rate_trend
 ,CAST(COALESCE(trdet.trans_text, rpl.desc_trend) AS VARCHAR(128)) AS desc_trend
 ,CAST(COALESCE(trent.trans_text, rpl.desc_trend) AS VARCHAR(128)) AS desc_trend_EN
 ,CAST(rpl.rate_direction AS SMALLINT) AS rate_direction
 ,CAST(COALESCE(trded.trans_text, rpl.desc_direction) AS VARCHAR(128)) AS desc_direction
 ,CAST(COALESCE(trend.trans_text, rpl.desc_direction) AS VARCHAR(128)) AS desc_direction_EN
 ,CAST(rpl.rate_trend_dev AS SMALLINT) AS rate_trend_dev
 ,CAST(COALESCE(trdetd.trans_text, rpl.desc_trend_dev) AS VARCHAR(128)) AS desc_trend_dev
 ,CAST(COALESCE(trentd.trans_text, rpl.desc_trend_dev) AS VARCHAR(128)) AS desc_trend_dev_EN
FROM P_LEW_PROCESS_MSTR_AC.v_lil_rpt_pm_legend AS rpl
LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation AS trde
  ON trde.context = 'RPL_DESC_COVERAGE'
 AND trde.trans_id = rpl.legend_id
 AND trde.lang_cd = 'DE'
 AND trde.active_fg = 1
 LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation AS tren
  ON tren.context = 'RPL_DESC_COVERAGE'
 AND tren.trans_id = rpl.legend_id
 AND tren.lang_cd = 'EN'
 AND tren.active_fg = 1
LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation AS trdet
  ON trdet.context = 'RPL_DESC_TREND'
 AND trdet.trans_id = rpl.legend_id
 AND trdet.lang_cd = 'DE'
 AND trdet.active_fg = 1
 LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation AS trent
  ON trent.context = 'RPL_DESC_TREND'
 AND trent.trans_id = rpl.legend_id
 AND trent.lang_cd = 'EN'
 AND trent.active_fg = 1
LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation AS trded
  ON trded.context = 'RPL_DESC_DIRECTION'
 AND trded.trans_id = rpl.legend_id
 AND trded.lang_cd = 'DE'
 AND trded.active_fg = 1
 LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation AS trend
  ON trend.context = 'RPL_DESC_DIRECTION'
 AND trend.trans_id = rpl.legend_id
 AND trend.lang_cd = 'EN'
 AND trend.active_fg = 1
LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation AS trdetd
  ON trdetd.context = 'RPL_DESC_TREND_DEV'
 AND trdetd.trans_id = rpl.legend_id
 AND trdetd.lang_cd = 'DE'
 AND trdetd.active_fg = 1
 LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation AS trentd
  ON trentd.context = 'RPL_DESC_TREND_DEV'
 AND trentd.trans_id = rpl.legend_id
 AND trentd.lang_cd = 'EN'
 AND trentd.active_fg = 1;
