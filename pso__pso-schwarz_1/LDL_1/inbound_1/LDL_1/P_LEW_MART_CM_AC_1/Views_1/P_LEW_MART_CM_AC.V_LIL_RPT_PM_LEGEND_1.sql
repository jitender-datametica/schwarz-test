CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_RPT_PM_LEGEND_1
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
) AS
SELECT
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
FROM P_LEW_MART_CM.V_LIL_RPT_PM_LEGEND_1 ;
