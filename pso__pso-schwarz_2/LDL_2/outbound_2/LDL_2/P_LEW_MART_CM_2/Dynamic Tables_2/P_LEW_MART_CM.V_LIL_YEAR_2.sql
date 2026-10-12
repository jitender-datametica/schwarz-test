CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_cm.v_lil_year_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT CAST(PC.period_year AS BIGNUMERIC) AS per_yr,
 MAX(PP.liam_avbl_fg) AS liam_avbl_fg,
 MAX(PP.lift_avbl_fg) AS lift_avbl_fg
FROM ldl_p_lew_core_ac.v_lil_period_2 AS PC
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_period_2 AS PP ON PC.period_sid = PP.period_sid
GROUP BY PC.period_year;