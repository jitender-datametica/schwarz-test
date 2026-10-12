CREATE OR REPLACE VIEW ldl_p_lew_bil.v_cal_calendarday_adjusted_incr_1 (cal_dt, cnt_dat_adj_increase, day_of_week,
day_of_month, day_of_cy, cy, cy_week, cy_week_99, cy_week_part, cy_month, cy_month_prev_1m, busyear, cal_dt_prev_1d,
cal_dt_prev_7d, cal_dt_month_day_prev_1y, cal_dt_month_day_prev_2y, cal_dt_month_day_prev_3y, cal_dt_month_day_prev_4y,
cal_dt_month_day_prev_5y, cal_dt_prev_md, cal_dt_prev_yd, cal_dt_prev_py, cal_dt_swday_prev_1y, cal_dt_swday_prev_2y,
cal_dt_swday_prev_3y, cal_dt_swday_prev_4y, cal_dt_swday_prev_5y, cal_dt_swday_prev_1y_1w, cal_dt_last_day_prev_1w,
cal_dt_last_day_prev_1m, cal_dt_last_day_prev_1y, cal_dt_first_day_next_1w, prev_m_dat_adj_inc, prev_y_dat_adj_inc,
prev_y_pm_dat, prev_2y_dat_adj_inc, cnt_dat_adj_increase_week, cal_dt_swday_prev_1y_adjusted, last_day_week_fg,
last_day_week_partial_fg, last_day_month_fg, last_day_year_fg, cy_day_seq, cy_month_seq, cy_week_seq, busyear_seq,
dwh_load_id, dwh_created, dwh_updated) AS SELECT TCAL.cal_dt,
 cmb.cnt_dat_adj_increase,
 TCAL.day_of_week,
 TCAL.day_of_month,
 TCAL.day_of_cy,
 TCAL.cy,
 TCAL.cy_week,
 TCAL.cy_week_99,
 TCAL.cy_week_part,
 TCAL.cy_month,
 TCAL.cy_month_prev_1m,
 TCAL.busyear,
 TCAL.cal_dt_prev_1d,
 TCAL.cal_dt_prev_7d,
  CASE
  WHEN cmb.cnt_dat_adj_increase IN (0, 1)
  THEN CASE
   WHEN MOD(TCAL.cy - 1, 400) = 0 AND TCAL.day_of_cy = 59 AND cmb.cnt_dat_adj_increase = 1
   THEN DATE_ADD(TCAL.cal_dt_prev_yd, INTERVAL 1 DAY)
   WHEN MOD(TCAL.cy - 1, 100) = 0 AND TCAL.day_of_cy = 59 AND cmb.cnt_dat_adj_increase = 1
   THEN TCAL.cal_dt_prev_yd
   WHEN MOD(TCAL.cy - 1, 4) = 0 AND TCAL.day_of_cy = 59 AND cmb.cnt_dat_adj_increase = 1
   THEN DATE_ADD(TCAL.cal_dt_prev_yd, INTERVAL 1 DAY)
   WHEN cmb.cnt_dat_adj_increase = 0
   THEN COALESCE(TCAL.cal_dt_prev_yd, IF(TCAL.cal_dt = LAST_DAY(TCAL.cal_dt), LAST_DAY(DATE_ADD(TCAL.cal_dt, INTERVAL -
       12 MONTH)), DATE_ADD(TCAL.cal_dt, INTERVAL - 12 MONTH)))
   ELSE NULL
   END
  ELSE NULL
  END AS cal_dt_month_day_prev_1y,
  CASE
  WHEN cmb.cnt_dat_adj_increase IN (0, 1)
  THEN CASE
   WHEN MOD(TCAL.cy - 2, 400) = 0 AND TCAL.day_of_cy = 59 AND cmb.cnt_dat_adj_increase = 1
   THEN DATE_ADD(IF(TCAL.cal_dt_prev_yd = LAST_DAY(TCAL.cal_dt_prev_yd), LAST_DAY(DATE_ADD(TCAL.cal_dt_prev_yd, INTERVAL
       - 12 MONTH)), DATE_ADD(TCAL.cal_dt_prev_yd, INTERVAL - 12 MONTH)), INTERVAL 1 DAY)
   WHEN MOD(TCAL.cy - 2, 100) = 0 AND TCAL.day_of_cy = 59 AND cmb.cnt_dat_adj_increase = 1
   THEN IF(TCAL.cal_dt_prev_yd = LAST_DAY(TCAL.cal_dt_prev_yd), LAST_DAY(DATE_ADD(TCAL.cal_dt_prev_yd, INTERVAL - 12
      MONTH)), DATE_ADD(TCAL.cal_dt_prev_yd, INTERVAL - 12 MONTH))
   WHEN MOD(TCAL.cy - 2, 4) = 0 AND TCAL.day_of_cy = 59 AND cmb.cnt_dat_adj_increase = 1
   THEN DATE_ADD(IF(TCAL.cal_dt_prev_yd = LAST_DAY(TCAL.cal_dt_prev_yd), LAST_DAY(DATE_ADD(TCAL.cal_dt_prev_yd, INTERVAL
       - 12 MONTH)), DATE_ADD(TCAL.cal_dt_prev_yd, INTERVAL - 12 MONTH)), INTERVAL 1 DAY)
   WHEN cmb.cnt_dat_adj_increase = 0
   THEN COALESCE(IF(TCAL.cal_dt = LAST_DAY(TCAL.cal_dt), LAST_DAY(DATE_ADD(TCAL.cal_dt, INTERVAL - 24 MONTH)), DATE_ADD(TCAL
      .cal_dt, INTERVAL - 24 MONTH)), DATE_SUB(TCAL.cal_dt_prev_yd, INTERVAL 364 DAY))
   ELSE NULL
   END
  ELSE NULL
  END AS cal_dt_month_day_prev_2y,
  CASE
  WHEN cmb.cnt_dat_adj_increase IN (0, 1)
  THEN CASE
   WHEN MOD(TCAL.cy - 3, 400) = 0 AND TCAL.day_of_cy = 59 AND cmb.cnt_dat_adj_increase = 1
   THEN DATE_ADD(IF(TCAL.cal_dt_prev_yd = LAST_DAY(TCAL.cal_dt_prev_yd), LAST_DAY(DATE_ADD(TCAL.cal_dt_prev_yd, INTERVAL
       - 24 MONTH)), DATE_ADD(TCAL.cal_dt_prev_yd, INTERVAL - 24 MONTH)), INTERVAL 1 DAY)
   WHEN MOD(TCAL.cy - 3, 100) = 0 AND TCAL.day_of_cy = 59 AND cmb.cnt_dat_adj_increase = 1
   THEN IF(TCAL.cal_dt_prev_yd = LAST_DAY(TCAL.cal_dt_prev_yd), LAST_DAY(DATE_ADD(TCAL.cal_dt_prev_yd, INTERVAL - 24
      MONTH)), DATE_ADD(TCAL.cal_dt_prev_yd, INTERVAL - 24 MONTH))
   WHEN MOD(TCAL.cy - 3, 4) = 0 AND TCAL.day_of_cy = 59 AND cmb.cnt_dat_adj_increase = 1
   THEN DATE_ADD(IF(TCAL.cal_dt_prev_yd = LAST_DAY(TCAL.cal_dt_prev_yd), LAST_DAY(DATE_ADD(TCAL.cal_dt_prev_yd, INTERVAL
       - 24 MONTH)), DATE_ADD(TCAL.cal_dt_prev_yd, INTERVAL - 24 MONTH)), INTERVAL 1 DAY)
   WHEN cmb.cnt_dat_adj_increase = 0
   THEN COALESCE(IF(TCAL.cal_dt = LAST_DAY(TCAL.cal_dt), LAST_DAY(DATE_ADD(TCAL.cal_dt, INTERVAL - 36 MONTH)), DATE_ADD(TCAL
      .cal_dt, INTERVAL - 36 MONTH)), DATE_SUB(TCAL.cal_dt_prev_yd, INTERVAL 364 * 2 DAY))
   ELSE NULL
   END
  ELSE NULL
  END AS cal_dt_month_day_prev_3y,
  CASE
  WHEN cmb.cnt_dat_adj_increase IN (0, 1)
  THEN CASE
   WHEN MOD(TCAL.cy - 4, 400) = 0 AND TCAL.day_of_cy = 59 AND cmb.cnt_dat_adj_increase = 1
   THEN CASE
    WHEN (MOD(CAST(TCAL.cy AS BIGNUMERIC), 400) <> 0 OR MOD(CAST(TCAL.cy AS BIGNUMERIC), 4) <> 0) AND TCAL.day_of_cy =
      59
    THEN IF(TCAL.cal_dt_prev_yd = LAST_DAY(TCAL.cal_dt_prev_yd), LAST_DAY(DATE_ADD(TCAL.cal_dt_prev_yd, INTERVAL - 36
       MONTH)), DATE_ADD(TCAL.cal_dt_prev_yd, INTERVAL - 36 MONTH))
    ELSE DATE_ADD(IF(TCAL.cal_dt_prev_yd = LAST_DAY(TCAL.cal_dt_prev_yd), LAST_DAY(DATE_ADD(TCAL.cal_dt_prev_yd,
        INTERVAL - 36 MONTH)), DATE_ADD(TCAL.cal_dt_prev_yd, INTERVAL - 36 MONTH)), INTERVAL 1 DAY)
    END
   WHEN MOD(TCAL.cy - 4, 100) = 0 AND TCAL.day_of_cy = 59 AND cmb.cnt_dat_adj_increase = 1
   THEN IF(TCAL.cal_dt_prev_yd = LAST_DAY(TCAL.cal_dt_prev_yd), LAST_DAY(DATE_ADD(TCAL.cal_dt_prev_yd, INTERVAL - 36
      MONTH)), DATE_ADD(TCAL.cal_dt_prev_yd, INTERVAL - 36 MONTH))
   WHEN MOD(TCAL.cy - 4, 4) = 0 AND TCAL.day_of_cy = 59 AND cmb.cnt_dat_adj_increase = 1
   THEN CASE
    WHEN (MOD(CAST(TCAL.cy AS BIGNUMERIC), 400) <> 0 OR MOD(CAST(TCAL.cy AS BIGNUMERIC), 4) <> 0) AND TCAL.day_of_cy =
      59
    THEN IF(TCAL.cal_dt_prev_yd = LAST_DAY(TCAL.cal_dt_prev_yd), LAST_DAY(DATE_ADD(TCAL.cal_dt_prev_yd, INTERVAL - 36
       MONTH)), DATE_ADD(TCAL.cal_dt_prev_yd, INTERVAL - 36 MONTH))
    ELSE DATE_ADD(IF(TCAL.cal_dt_prev_yd = LAST_DAY(TCAL.cal_dt_prev_yd), LAST_DAY(DATE_ADD(TCAL.cal_dt_prev_yd,
        INTERVAL - 36 MONTH)), DATE_ADD(TCAL.cal_dt_prev_yd, INTERVAL - 36 MONTH)), INTERVAL 1 DAY)
    END
   WHEN cmb.cnt_dat_adj_increase = 0
   THEN CASE
    WHEN TCAL.day_of_cy = 60
    THEN COALESCE(DATE_ADD(IF(TCAL.cal_dt_prev_yd = LAST_DAY(TCAL.cal_dt_prev_yd), LAST_DAY(DATE_ADD(TCAL.cal_dt_prev_yd
         ,INTERVAL - 36 MONTH)), DATE_ADD(TCAL.cal_dt_prev_yd, INTERVAL - 36 MONTH)), INTERVAL 1 DAY), COALESCE(IF(TCAL
        .cal_dt = LAST_DAY(TCAL.cal_dt), LAST_DAY(DATE_ADD(TCAL.cal_dt, INTERVAL - 48 MONTH)), DATE_ADD(TCAL.cal_dt,
        INTERVAL - 48 MONTH)), IF(TCAL.cal_dt_prev_yd = LAST_DAY(TCAL.cal_dt_prev_yd), LAST_DAY(DATE_ADD(TCAL.cal_dt_prev_yd
         ,INTERVAL - 36 MONTH)), DATE_ADD(TCAL.cal_dt_prev_yd, INTERVAL - 36 MONTH))))
    ELSE COALESCE(IF(TCAL.cal_dt = LAST_DAY(TCAL.cal_dt), LAST_DAY(DATE_ADD(TCAL.cal_dt, INTERVAL - 48 MONTH)), DATE_ADD(TCAL
       .cal_dt, INTERVAL - 48 MONTH)), IF(TCAL.cal_dt_prev_yd = LAST_DAY(TCAL.cal_dt_prev_yd), LAST_DAY(DATE_ADD(TCAL.cal_dt_prev_yd
        ,INTERVAL - 36 MONTH)), DATE_ADD(TCAL.cal_dt_prev_yd, INTERVAL - 36 MONTH)))
    END
   ELSE NULL
   END
  ELSE NULL
  END AS cal_dt_month_day_prev_4y,
  CASE
  WHEN cmb.cnt_dat_adj_increase IN (0, 1)
  THEN CASE
   WHEN MOD(TCAL.cy - 5, 400) = 0 AND TCAL.day_of_cy = 59 AND cmb.cnt_dat_adj_increase = 1
   THEN DATE_ADD(IF(TCAL.cal_dt_prev_yd = LAST_DAY(TCAL.cal_dt_prev_yd), LAST_DAY(DATE_ADD(TCAL.cal_dt_prev_yd, INTERVAL
       - 48 MONTH)), DATE_ADD(TCAL.cal_dt_prev_yd, INTERVAL - 48 MONTH)), INTERVAL 1 DAY)
   WHEN MOD(TCAL.cy - 5, 100) = 0 AND TCAL.day_of_cy = 59 AND cmb.cnt_dat_adj_increase = 1
   THEN IF(TCAL.cal_dt_prev_yd = LAST_DAY(TCAL.cal_dt_prev_yd), LAST_DAY(DATE_ADD(TCAL.cal_dt_prev_yd, INTERVAL - 48
      MONTH)), DATE_ADD(TCAL.cal_dt_prev_yd, INTERVAL - 48 MONTH))
   WHEN MOD(TCAL.cy - 5, 4) = 0 AND TCAL.day_of_cy = 59 AND cmb.cnt_dat_adj_increase = 1
   THEN DATE_ADD(IF(TCAL.cal_dt_prev_yd = LAST_DAY(TCAL.cal_dt_prev_yd), LAST_DAY(DATE_ADD(TCAL.cal_dt_prev_yd, INTERVAL
       - 48 MONTH)), DATE_ADD(TCAL.cal_dt_prev_yd, INTERVAL - 48 MONTH)), INTERVAL 1 DAY)
   WHEN cmb.cnt_dat_adj_increase = 0
   THEN COALESCE(IF(TCAL.cal_dt = LAST_DAY(TCAL.cal_dt), LAST_DAY(DATE_ADD(TCAL.cal_dt, INTERVAL - 60 MONTH)), DATE_ADD(TCAL
      .cal_dt, INTERVAL - 60 MONTH)), DATE_SUB(TCAL.cal_dt_prev_yd, INTERVAL 364 * 4 DAY))
   ELSE NULL
   END
  ELSE NULL
  END AS cal_dt_month_day_prev_5y,
 TCAL.cal_dt_prev_md,
 TCAL.cal_dt_prev_yd,
 TCAL.cal_dt_prev_py,
 TCAL.cal_dt_swday_prev_1y,
 TCAL.cal_dt_swday_prev_2y,
 TCAL.cal_dt_swday_prev_3y,
 TCAL.cal_dt_swday_prev_4y,
 TCAL.cal_dt_swday_prev_5y,
 TCAL.cal_dt_swday_prev_1y_1w,
 TCAL.cal_dt_last_day_prev_1w,
 TCAL.cal_dt_last_day_prev_1m,
 TCAL.cal_dt_last_day_prev_1y,
 TCAL.cal_dt_first_day_next_1w,
 cmb.dat_calendar_pmd AS prev_m_dat_adj_inc,
 cmb.dat_calendar_pyd AS prev_y_dat_adj_inc,
 cmb.dat_calendar_pypm AS prev_y_pm_dat,
 cmb.dat_calendar_ppy AS prev_2y_dat_adj_inc,
 cwb.cnt_dat_adj_increase_week,
 cwb.prev_cy_dat_calendar_swd_ber AS cal_dt_swday_prev_1y_adjusted,
  CASE
  WHEN TCAL.last_day_week_fg = 1 AND cmb.cnt_dat_adj_increase = 0
  THEN 1
  ELSE 0
  END AS last_day_week_fg,
  CASE
  WHEN (ROW_NUMBER() OVER (PARTITION BY CAST(TCAL.busyear AS STRING), CAST(TCAL.cy_week AS STRING), CAST(TCAL.cy_week_part AS STRING)
       ORDER BY cmb.cnt_dat_adj_increase IS NULL, cmb.cnt_dat_adj_increase, TCAL.day_of_week IS NULL, TCAL.day_of_week)
    ) = 1
  THEN 1
  ELSE 0
  END AS last_day_week_partial_fg,
  CASE
  WHEN (ROW_NUMBER() OVER (PARTITION BY CAST(TCAL.cy AS STRING), CAST(TCAL.cy_month AS STRING) ORDER BY cmb.cnt_dat_adj_increase
       IS NULL, cmb.cnt_dat_adj_increase, TCAL.day_of_month IS NULL, TCAL.day_of_month)) = 1
  THEN 1
  ELSE 0
  END AS last_day_month_fg,
 TCAL.last_day_year_fg,
 TCAL.cy_day_seq,
 TCAL.cy_month_seq,
 TCAL.cy_week_seq,
 TCAL.busyear_seq,
 TCAL.dwh_load_id,
 TCAL.dwh_created,
 TCAL.dwh_updated
FROM ldl_p_lew_core_ac.v_cal_calendarday_1 AS TCAL
 LEFT JOIN (SELECT DD.cal_dt AS dat_calendar_amd,
   PD.cal_dt AS dat_calendar_pmd,
    CASE
    WHEN PY.cal_dt IS NULL AND PD.cal_dt IS NULL
    THEN IF(DD.cal_dt = LAST_DAY(DD.cal_dt), LAST_DAY(DATE_ADD(DD.cal_dt, INTERVAL - 12 MONTH)), DATE_ADD(DD.cal_dt,
      INTERVAL - 12 MONTH))
    ELSE PY.cal_dt
    END AS dat_calendar_pyd,
    CASE
    WHEN PYPM.cal_dt IS NULL AND EXTRACT(DAY FROM CASE
          WHEN PY.cal_dt IS NULL AND PD.cal_dt IS NULL
          THEN IF(DD.cal_dt = LAST_DAY(DD.cal_dt), LAST_DAY(DATE_ADD(DD.cal_dt, INTERVAL - 12 MONTH)), DATE_ADD(DD.cal_dt
            ,INTERVAL - 12 MONTH))
          ELSE PY.cal_dt
          END) = 29 AND EXTRACT(MONTH FROM CASE
         WHEN PY.cal_dt IS NULL AND PD.cal_dt IS NULL
         THEN IF(DD.cal_dt = LAST_DAY(DD.cal_dt), LAST_DAY(DATE_ADD(DD.cal_dt, INTERVAL - 12 MONTH)), DATE_ADD(DD.cal_dt
           ,INTERVAL - 12 MONTH))
         ELSE PY.cal_dt
         END) = 3 AND MOD(EXTRACT(YEAR FROM CASE
         WHEN PY.cal_dt IS NULL AND PD.cal_dt IS NULL
         THEN IF(DD.cal_dt = LAST_DAY(DD.cal_dt), LAST_DAY(DATE_ADD(DD.cal_dt, INTERVAL - 12 MONTH)), DATE_ADD(DD.cal_dt
           ,INTERVAL - 12 MONTH))
         ELSE PY.cal_dt
         END), 4) = 0
    THEN IF(CASE
       WHEN PY.cal_dt IS NULL AND PD.cal_dt IS NULL
       THEN IF(DD.cal_dt = LAST_DAY(DD.cal_dt), LAST_DAY(DATE_ADD(DD.cal_dt, INTERVAL - 12 MONTH)), DATE_ADD(DD.cal_dt,
         INTERVAL - 12 MONTH))
       ELSE PY.cal_dt
       END = LAST_DAY(CASE
        WHEN PY.cal_dt IS NULL AND PD.cal_dt IS NULL
        THEN IF(DD.cal_dt = LAST_DAY(DD.cal_dt), LAST_DAY(DATE_ADD(DD.cal_dt, INTERVAL - 12 MONTH)), DATE_ADD(DD.cal_dt
          ,INTERVAL - 12 MONTH))
        ELSE PY.cal_dt
        END), LAST_DAY(DATE_ADD(CASE
        WHEN PY.cal_dt IS NULL AND PD.cal_dt IS NULL
        THEN IF(DD.cal_dt = LAST_DAY(DD.cal_dt), LAST_DAY(DATE_ADD(DD.cal_dt, INTERVAL - 12 MONTH)), DATE_ADD(DD.cal_dt
          ,INTERVAL - 12 MONTH))
        ELSE PY.cal_dt
        END, INTERVAL - 1 MONTH)), DATE_ADD(CASE
       WHEN PY.cal_dt IS NULL AND PD.cal_dt IS NULL
       THEN IF(DD.cal_dt = LAST_DAY(DD.cal_dt), LAST_DAY(DATE_ADD(DD.cal_dt, INTERVAL - 12 MONTH)), DATE_ADD(DD.cal_dt,
         INTERVAL - 12 MONTH))
       ELSE PY.cal_dt
       END, INTERVAL - 1 MONTH))
    WHEN PYPM.cal_dt IS NULL AND EXTRACT(DAY FROM PD.cal_dt) = 29 AND EXTRACT(MONTH FROM PD.cal_dt) = 2 AND MOD(EXTRACT(YEAR
        FROM PD.cal_dt), 4) = 0
    THEN NULL
    ELSE IF(PD.cal_dt = LAST_DAY(PD.cal_dt), LAST_DAY(DATE_ADD(PD.cal_dt, INTERVAL - 12 MONTH)), DATE_ADD(PD.cal_dt,
      INTERVAL - 12 MONTH))
    END AS dat_calendar_pypm,
    CASE
    WHEN PPY.cal_dt IS NULL AND PD.cal_dt IS NULL
    THEN IF(DD.cal_dt = LAST_DAY(DD.cal_dt), LAST_DAY(DATE_ADD(DD.cal_dt, INTERVAL - 24 MONTH)), DATE_ADD(DD.cal_dt,
      INTERVAL - 24 MONTH))
    ELSE PPY.cal_dt
    END AS dat_calendar_ppy,
   MM.cy_month,
   MM.cy_month_prev_1m,
     (RANK() OVER (PARTITION BY DD.cal_dt ORDER BY PD.cal_dt IS NULL, PD.cal_dt)) - 1 AS cnt_dat_adj_increase
  FROM ldl_p_lew_core_ac.v_cal_month_1 AS MM_1
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS DD ON MM.cy_month = DD.cy_month
   LEFT JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS PD_1 ON MM.cy_month_prev_1m = PD.cy_month AND IF(PD.cal_dt = LAST_DAY(PD_1
        .cal_dt), LAST_DAY(DATE_ADD(PD.cal_dt, INTERVAL 1 MONTH)), DATE_ADD(PD.cal_dt, INTERVAL 1 MONTH)) = DD.cal_dt
   LEFT JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS PY ON MM.cy_month = PY.cy_month + 100 AND IF(PY.cal_dt = LAST_DAY(PY
         .cal_dt), LAST_DAY(DATE_ADD(PY.cal_dt, INTERVAL 12 MONTH)), DATE_ADD(PY.cal_dt, INTERVAL 12 MONTH)) = DD.cal_dt
       AND IF(PY.cal_dt = LAST_DAY(PY.cal_dt), LAST_DAY(DATE_ADD(PY.cal_dt, INTERVAL 11 MONTH)), DATE_ADD(PY.cal_dt,
       INTERVAL 11 MONTH)) = PD.cal_dt
   LEFT JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS PYPM ON MM.cy_month_prev_1m = PYPM.cy_month + 100 AND IF(PYPM.cal_dt
         = LAST_DAY(PYPM.cal_dt), LAST_DAY(DATE_ADD(PYPM.cal_dt, INTERVAL 1 MONTH)), DATE_ADD(PYPM.cal_dt, INTERVAL 1
        MONTH)) = PY.cal_dt AND IF(PYPM.cal_dt = LAST_DAY(PYPM.cal_dt), LAST_DAY(DATE_ADD(PYPM.cal_dt, INTERVAL 12 MONTH)
       ), DATE_ADD(PYPM.cal_dt, INTERVAL 12 MONTH)) = PD.cal_dt
   LEFT JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS PPY ON MM.cy_month = PPY.cy_month + 200 AND IF(PPY.cal_dt = LAST_DAY(PPY
         .cal_dt), LAST_DAY(DATE_ADD(PPY.cal_dt, INTERVAL 24 MONTH)), DATE_ADD(PPY.cal_dt, INTERVAL 24 MONTH)) = DD.cal_dt
       AND IF(PPY.cal_dt = LAST_DAY(PPY.cal_dt), LAST_DAY(DATE_ADD(PPY.cal_dt, INTERVAL 23 MONTH)), DATE_ADD(PPY.cal_dt
       ,INTERVAL 23 MONTH)) = PD.cal_dt
  WHERE DD.cal_dt >= DATE '2005-01-01') AS cmb ON TCAL.cal_dt = cmb.dat_calendar_amd
 LEFT JOIN (SELECT dat_calendar,
   prev_cy_dat_calendar_swd_ber,
   prev_cy_dat_calendar_swd_ber_cum,
     (RANK() OVER (PARTITION BY dat_calendar ORDER BY prev_cy_dat_calendar_swd_ber IS NULL, prev_cy_dat_calendar_swd_ber
        )) - 1 AS cnt_dat_adj_increase_week
  FROM ldl_p_lew_core_ac.v_wawi_cal_week_ber_1 AS CWB) AS cwb ON TCAL.cal_dt = cwb.dat_calendar AND cmb.cnt_dat_adj_increase
    = cwb.cnt_dat_adj_increase_week;