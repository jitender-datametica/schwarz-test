/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL.V_CAL_WEEK_PARTIAL_WEEK_REL.
#----------------------------------------------------------------------------
# History:
#  1.0  15.09.2021    Syrokosz, Jaroslaw       First draft 
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_bil.v_cal_week_partial_week_rel (dat_calendar, cy_week_partial_week_id1,
cy_week_partial_week_id2, cy_week_partial_week_id, cy_day_sequence) AS SELECT *
FROM (SELECT DCD.cal_dt AS dat_calendar,
    CW.cy_week AS cy_week_partial_week_id1,
     CASE
     WHEN CW.cy_week_part_full_week_fg = 1
     THEN 9
     ELSE DCD.week_part_seq
     END AS cy_week_partial_week_id2,
      10 * CW.cy_week + CASE
      WHEN CW.cy_week_part_full_week_fg = 1
      THEN 9
      ELSE DCD.week_part_seq
      END AS cy_week_partial_week_id,
    DCD.cal_dt_offset AS cy_day_sequence
   FROM ldl_p_lew_bil.t_dim_cal_week_partial AS CW
    INNER JOIN ldl_p_lew_bil.t_dim_cal_day AS DCD ON CW.cy_week = DCD.cy_week AND CW.cy = DCD.cy
   UNION DISTINCT
   SELECT DCD.cal_dt AS dat_calendar,
    CW.cy_week AS cy_week_partial_week_id1,
    9 AS cy_week_partial_week_id2,
      10 * CW.cy_week + 9 AS cy_week_partial_week_id,
    DCD.cal_dt_offset AS cy_day_sequence
   FROM ldl_p_lew_bil.t_dim_cal_week_partial AS CW
    INNER JOIN ldl_p_lew_bil.t_dim_cal_day AS DCD ON CW.cy_week = DCD.cy_week AND CW.cy = DCD.cy
   WHERE CW.week_part_seq = 2)
UNION ALL
SELECT DCD.cal_dt AS dat_calendar,
 CW.cy_week AS cy_week_partial_week_id1,
 9 AS cy_week_partial_week_id2,
   10 * CW.cy_week + 9 AS cy_week_partial_week_id,
 DCD.cal_dt_offset AS cy_day_sequence
FROM ldl_p_lew_bil.t_dim_cal_week_partial AS CW
 INNER JOIN ldl_p_lew_bil.t_dim_cal_day AS DCD ON CW.cy_week = DCD.cy_week AND CW.cy = DCD.cy
WHERE DCD.month_of_year = 12
 AND CW.cy_week_part_full_week_fg = 0
 AND DCD.week_of_year IN (1, 52, 53);