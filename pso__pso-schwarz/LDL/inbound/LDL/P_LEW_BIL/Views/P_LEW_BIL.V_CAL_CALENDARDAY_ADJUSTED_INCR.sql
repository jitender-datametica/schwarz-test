CREATE OR REPLACE VIEW P_LEW_BIL.V_CAL_CALENDARDAY_ADJUSTED_INCR
/*
#DescStart#
#$Revision: 6878 $, $LastChangedBy: hwieber $
#SubjectAreas#: Bereinigte Steigerung Kalender / Calendar Adjusted Increase
#DescEnd#
*/
(

  cal_dt
, cnt_dat_adj_increase
, day_of_week
, day_of_month
, day_of_cy
, cy
, cy_week
, cy_week_99
, cy_week_part
, cy_month
, cy_month_prev_1m
, busyear
, cal_dt_prev_1d
, cal_dt_prev_7d
, cal_dt_month_day_prev_1y
, cal_dt_month_day_prev_2y
, cal_dt_month_day_prev_3y
, cal_dt_month_day_prev_4y
, cal_dt_month_day_prev_5y
, cal_dt_prev_md
, cal_dt_prev_yd
, cal_dt_prev_py
, cal_dt_swday_prev_1y
, cal_dt_swday_prev_2y
, cal_dt_swday_prev_3y
, cal_dt_swday_prev_4y
, cal_dt_swday_prev_5y
, cal_dt_swday_prev_1y_1w
, cal_dt_last_day_prev_1w
, cal_dt_last_day_prev_1m
, cal_dt_last_day_prev_1y
, cal_dt_first_day_next_1w
, prev_m_dat_adj_inc
, prev_y_dat_adj_inc
, prev_y_pm_dat
, prev_2y_dat_adj_inc
, cnt_dat_adj_increase_week
, cal_dt_swday_prev_1y_adjusted
, last_day_week_fg
, last_day_week_partial_fg
, last_day_month_fg
, last_day_year_fg
, cy_day_seq
, cy_month_seq
, cy_week_seq
, busyear_seq
, dwh_load_id
, dwh_created
, dwh_updated
)
AS
(SELECT
tcal.cal_dt,
cmb.cnt_dat_adj_increase,
tcal.day_of_week,
tcal.day_of_month,
tcal.day_of_cy,
tcal.cy,
tcal.cy_week,
tcal.cy_week_99,
tcal.cy_week_part,
tcal.cy_month,
tcal.cy_month_prev_1m,
tcal.busyear,
tcal.cal_dt_prev_1d,
tcal.cal_dt_prev_7d,
CASE WHEN cmb.cnt_dat_adj_increase IN (0,1)
   THEN CASE WHEN (MOD((tcal.cy-1), 400) = 0 AND tcal.day_of_cy = 59 AND cmb.cnt_dat_adj_increase = 1)
THEN tcal.cal_dt_prev_yd + 1
WHEN (MOD((tcal.cy-1), 100) = 0 AND tcal.day_of_cy = 59 AND cmb.cnt_dat_adj_increase = 1)
THEN tcal.cal_dt_prev_yd
WHEN (MOD((tcal.cy-1),   4) = 0 AND tcal.day_of_cy = 59 AND cmb.cnt_dat_adj_increase = 1)
THEN tcal.cal_dt_prev_yd + 1
WHEN cmb.cnt_dat_adj_increase = 0
THEN Coalesce(tcal.cal_dt_prev_yd,  Add_Months(tcal.cal_dt,-12) )
END
END                                                                                        AS cal_dt_month_day_prev_1y,
CASE WHEN cmb.cnt_dat_adj_increase IN (0,1)
       THEN CASE WHEN (MOD((tcal.cy-2), 400) = 0 AND tcal.day_of_cy = 59 AND cmb.cnt_dat_adj_increase = 1)
THEN ADD_MONTHS(tcal.cal_dt_prev_yd, -12) + 1
WHEN (MOD((tcal.cy-2), 100) = 0 AND tcal.day_of_cy = 59 AND cmb.cnt_dat_adj_increase = 1)
THEN  ADD_MONTHS(tcal.cal_dt_prev_yd, -12)
WHEN (MOD((tcal.cy-2),   4) = 0 AND tcal.day_of_cy = 59 AND cmb.cnt_dat_adj_increase = 1)
THEN  ADD_MONTHS(tcal.cal_dt_prev_yd, -12)  + 1
WHEN cmb.cnt_dat_adj_increase = 0
THEN Coalesce(Add_Months(tcal.cal_dt,-24), (tcal.cal_dt_prev_yd -364))
END
END                                                                                        AS cal_dt_month_day_prev_2y,
CASE WHEN cmb.cnt_dat_adj_increase IN (0,1)
   THEN CASE WHEN (MOD((tcal.cy-3), 400) = 0 AND tcal.day_of_cy = 59 AND cmb.cnt_dat_adj_increase = 1)
THEN ADD_MONTHS(tcal.cal_dt_prev_yd, -24) + 1
WHEN (MOD((tcal.cy-3), 100) = 0 AND tcal.day_of_cy = 59 AND cmb.cnt_dat_adj_increase = 1)
THEN ADD_MONTHS(tcal.cal_dt_prev_yd, -24)
WHEN (MOD((tcal.cy-3),   4) = 0 AND tcal.day_of_cy = 59 AND cmb.cnt_dat_adj_increase = 1)
THEN ADD_MONTHS(tcal.cal_dt_prev_yd, -24) + 1
WHEN cmb.cnt_dat_adj_increase = 0
THEN Coalesce( Add_Months(tcal.cal_dt,-36) , (tcal.cal_dt_prev_yd -(364*2)))
END
END                                                                                         AS cal_dt_month_day_prev_3y,
CASE WHEN cmb.cnt_dat_adj_increase IN (0,1)
       THEN CASE WHEN (MOD(   (tcal.cy-4), 400) =  0 AND tcal.day_of_cy = 59 AND cmb.cnt_dat_adj_increase = 1)
THEN  CASE WHEN (MOD( tcal.cy, 400) <> 0 OR MOD( tcal.cy, 4) <> 0 ) AND tcal.day_of_cy = 59
THEN ADD_MONTHS(tcal.cal_dt_prev_yd, -36)
ELSE ADD_MONTHS(tcal.cal_dt_prev_yd, -36) + 1
END
WHEN (MOD((tcal.cy-4), 100) = 0 AND tcal.day_of_cy = 59 AND cmb.cnt_dat_adj_increase = 1)
THEN ADD_MONTHS(tcal.cal_dt_prev_yd, -36)
WHEN (MOD((tcal.cy-4),   4) = 0 AND tcal.day_of_cy = 59 AND cmb.cnt_dat_adj_increase = 1)
THEN  CASE WHEN (MOD(tcal.cy, 400) <> 0 OR MOD( tcal.cy, 4) <> 0 ) AND tcal.day_of_cy = 59
THEN ADD_MONTHS(tcal.cal_dt_prev_yd, -36)
ELSE ADD_MONTHS(tcal.cal_dt_prev_yd, -36) + 1
END
WHEN cmb.cnt_dat_adj_increase = 0
THEN CASE WHEN tcal.day_of_cy = 60
THEN Coalesce(ADD_MONTHS(tcal.cal_dt_prev_yd, -36) + 1 , Coalesce( Add_Months(tcal.cal_dt, -48 ),ADD_MONTHS(tcal.cal_dt_prev_yd, -36) ))
ELSE Coalesce(Add_Months(tcal.cal_dt, -48) ,ADD_MONTHS(tcal.cal_dt_prev_yd, -36))
END
END
END                                                                                          AS cal_dt_month_day_prev_4y,
CASE WHEN cmb.cnt_dat_adj_increase IN (0,1)
       THEN CASE WHEN (MOD((tcal.cy-5), 400) = 0 AND tcal.day_of_cy = 59 AND cmb.cnt_dat_adj_increase = 1)
THEN ADD_MONTHS(tcal.cal_dt_prev_yd, -48) +1
WHEN (MOD((tcal.cy-5), 100) = 0 AND tcal.day_of_cy = 59 AND cmb.cnt_dat_adj_increase = 1)
THEN ADD_MONTHS(tcal.cal_dt_prev_yd, -48)
WHEN (MOD((tcal.cy-5),   4) = 0 AND tcal.day_of_cy = 59 AND cmb.cnt_dat_adj_increase = 1)
THEN ADD_MONTHS(tcal.cal_dt_prev_yd, -48) +1
WHEN cmb.cnt_dat_adj_increase = 0
THEN Coalesce( Add_Months(tcal.cal_dt ,-60), tcal.cal_dt_prev_yd - (364*4))
END
END                                                                                        AS cal_dt_month_day_prev_5y,
tcal.cal_dt_prev_md,
tcal.cal_dt_prev_yd,
tcal.cal_dt_prev_py,
tcal.cal_dt_swday_prev_1y,
tcal.cal_dt_swday_prev_2y,
tcal.cal_dt_swday_prev_3y,
tcal.cal_dt_swday_prev_4y,
tcal.cal_dt_swday_prev_5y,
tcal.cal_dt_swday_prev_1y_1w,
tcal.cal_dt_last_day_prev_1w,
tcal.cal_dt_last_day_prev_1m,
tcal.cal_dt_last_day_prev_1y,
tcal.cal_dt_first_day_next_1w,
cmb.dat_calendar_pmd                       AS prev_m_dat_adj_inc,
cmb.dat_calendar_pyd                       AS prev_y_dat_adj_inc,
cmb.dat_calendar_pypm                      AS prev_y_pm_dat,
cmb.dat_calendar_ppy                         AS prev_2y_dat_adj_inc,
cwb.cnt_dat_adj_increase_week        AS cnt_dat_adj_increase_week,
cwb.prev_cy_dat_calendar_swd_ber AS cal_dt_swday_prev_1y_adjusted,
CASE WHEN tcal.last_day_week_fg = 1 AND cmb.cnt_dat_adj_increase = 0
           THEN 1
           ELSE 0
       END     AS last_day_week_fg,
CASE WHEN Row_Number() Over(PARTITION BY tcal.busyear, tcal.cy_week, tcal.cy_week_part ORDER BY  cmb.cnt_dat_adj_increase, tcal.day_of_week DESC NULLS LAST) = 1
           THEN 1
           ELSE 0
        END                                          AS last_day_week_partial_fg,
CASE WHEN Row_Number() Over(PARTITION BY tcal.cy, tcal.cy_month ORDER BY cmb.cnt_dat_adj_increase, tcal.day_of_month DESC NULLS LAST) = 1
           THEN 1
           ELSE 0
        END                                          AS last_day_month_fg,
tcal.last_day_year_fg,
tcal.cy_day_seq,
tcal.cy_month_seq,
tcal.cy_week_seq,
tcal.busyear_seq,
tcal.dwh_load_id,
tcal.dwh_created,
tcal.dwh_updated
FROM p_lew_core_ac.v_cal_calendarday as tcal
LEFT OUTER JOIN
(SELECT
cmb.*,
(Rank() Over (PARTITION BY dat_calendar_amd ORDER BY dat_calendar_pmd)) -1 AS cnt_dat_adj_increase
FROM
(SELECT
dd.cal_dt AS dat_calendar_amd   --Aktueller Kalendertag 
,
pd.cal_dt AS dat_calendar_pmd   --zugehörige Kalendertage des Vormonats 
,
CASE
           WHEN (py.cal_dt  IS NULL AND dat_calendar_pmd IS NULL )
           THEN ADD_MONTHS(dd.cal_dt,-12)
           ELSE py.cal_dt
         END AS dat_calendar_pyd     --zugehörige Kalendertage des Monats im Vorjahr 
,
CASE
           WHEN (pypm.cal_dt IS NULL
           AND EXTRACT(DAY FROM dat_calendar_pyd) = 29
           AND EXTRACT(MONTH FROM dat_calendar_pyd) = 3
           AND (MOD(EXTRACT(YEAR FROM dat_calendar_pyd), 4)) = 0  )
THEN ADD_MONTHS(dat_calendar_pyd,-1)

WHEN (pypm.cal_dt IS NULL
AND EXTRACT(DAY FROM dat_calendar_pmd) = 29
AND EXTRACT(MONTH FROM dat_calendar_pmd) = 2
AND (MOD(EXTRACT(YEAR FROM dat_calendar_pmd), 4)) = 0  )
THEN NULL

ELSE ADD_MONTHS(dat_calendar_pmd ,-12)
END AS dat_calendar_pypm     --zugehörige Kalendertage des Vormonats im Vorjahr 
,
CASE
            WHEN (ppy.cal_dt  IS NULL AND dat_calendar_pmd IS NULL )
            THEN ADD_MONTHS(dd.cal_dt,-24)
            ELSE ppy.cal_dt
          END AS dat_calendar_ppy     --zugehörige Kalendertage im Vorvorjahr 
,
mm.cy_month              --aktueller Monat 
,
mm.cy_month_prev_1m      --Vormonat 

--FROM p_lew_core.t_cal_month AS mm 
FROM p_lew_core_ac.v_cal_month AS mm

INNER JOIN p_lew_core_ac.v_cal_calendarday AS dd
ON mm.cy_month = dd.cy_month

-- Vormonat 
LEFT OUTER JOIN p_lew_core_ac.v_cal_calendarday AS pd
ON mm.cy_month_prev_1m = pd.cy_month
AND ADD_MONTHS(pd.cal_dt,1) = dd.cal_dt

--Vorjahresmonat 
LEFT OUTER JOIN p_lew_core_ac.v_cal_calendarday AS py
ON mm.cy_month = py.cy_month + 100
AND ADD_MONTHS(py.cal_dt,12) = dd.cal_dt
AND ADD_MONTHS(py.cal_dt,11) = pd.cal_dt

--Vorjahresvormonat 
LEFT OUTER JOIN p_lew_core_ac.v_cal_calendarday as pypm
ON mm.cy_month_prev_1m = pypm.cy_month + 100
AND ADD_MONTHS(pypm.cal_dt,1) = py.cal_dt
AND ADD_MONTHS(pypm.cal_dt,12) = pd.cal_dt

--Vorvorjahresmonat 
LEFT OUTER JOIN p_lew_core_ac.v_cal_calendarday as ppy
ON mm.cy_month = ppy.cy_month + 200
AND ADD_MONTHS(ppy.cal_dt,24) = dd.cal_dt
AND ADD_MONTHS(ppy.cal_dt,23) = pd.cal_dt

WHERE dat_calendar_amd IS NOT NULL
AND dat_calendar_amd >= '2005-01-01'
)AS cmb
) AS cmb             --adjusted month comparision   
ON  tcal.cal_dt = cmb.dat_calendar_amd

LEFT OUTER JOIN (SELECT
cwb.*,
(Rank() Over (PARTITION BY cwb.dat_calendar ORDER BY cwb.prev_cy_dat_calendar_swd_ber )) -1 AS cnt_dat_adj_increase_week
FROM p_lew_core_ac.v_wawi_cal_week_ber AS cwb ) AS cwb                    --adjusted week comparision
ON  tcal.cal_dt              = cwb.dat_calendar
AND cmb.cnt_dat_adj_increase = cwb.cnt_dat_adj_increase_week
)
;



