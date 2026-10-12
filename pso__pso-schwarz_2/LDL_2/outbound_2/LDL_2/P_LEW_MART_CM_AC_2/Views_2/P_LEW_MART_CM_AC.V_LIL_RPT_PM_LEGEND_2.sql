CREATE OR REPLACE VIEW ldl_p_lew_mart_cm_ac.v_lil_rpt_pm_legend_2 (legend_id, rate_coverage, desc_coverage,
desc_coverage_en, rate_trend, desc_trend, desc_trend_en, rate_direction, desc_direction, desc_direction_en,
rate_trend_dev, desc_trend_dev, desc_trend_dev_en) AS SELECT *
FROM ldl_p_lew_mart_cm.v_lil_rpt_pm_legend_2;