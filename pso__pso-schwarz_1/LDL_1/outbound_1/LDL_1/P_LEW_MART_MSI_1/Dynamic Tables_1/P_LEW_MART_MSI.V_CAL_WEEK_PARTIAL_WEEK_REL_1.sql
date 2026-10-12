
CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_cal_week_partial_week_rel_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
SELECT cal_dt AS dat_calendar,
 cy_week AS cy_week_partial_week_id1,
 week_part_seq AS cy_week_partial_week_id2,
 cy_week_part AS cy_week_partial_week_id,
 cal_dt_offset AS cy_day_sequence
FROM ldl_p_lew_bil_ac.v_dim_cal_day_1
UNION ALL
SELECT cal_dt AS dat_calendar,
 cy_week AS cy_week_partial_week_id1,
 9 AS cy_week_partial_week_id2,
   cy_week * 10 + 9 AS cy_week_partial_week_id,
 cal_dt_offset AS cy_day_sequence
FROM ldl_p_lew_bil_ac.v_dim_cal_day_1;


