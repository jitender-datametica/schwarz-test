CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_cal_month_ber (dat_calendar_amd, dat_calendar_pmd, dat_calendar_pyd,
dat_calendar_pypm, dat_calendar_ppy, dat_calendar_pppy, cy_month, prev_month) AS SELECT DD.dat_calendar AS
 dat_calendar_amd,
 PD.dat_calendar AS dat_calendar_pmd,
  CASE
  WHEN PY.dat_calendar IS NULL AND PD.dat_calendar IS NULL
  THEN DATE_ADD(DD.dat_calendar, INTERVAL - 12 MONTH)
  ELSE PY.dat_calendar
  END AS dat_calendar_pyd,
  CASE
  WHEN PYPM.dat_calendar IS NULL AND EXTRACT(DAY FROM CASE
        WHEN PY.dat_calendar IS NULL AND PD.dat_calendar IS NULL
        THEN DATE_ADD(DD.dat_calendar, INTERVAL - 12 MONTH)
        ELSE PY.dat_calendar
        END) = 29 AND EXTRACT(MONTH FROM CASE
       WHEN PY.dat_calendar IS NULL AND PD.dat_calendar IS NULL
       THEN DATE_ADD(DD.dat_calendar, INTERVAL - 12 MONTH)
       ELSE PY.dat_calendar
       END) = 3 AND MOD(EXTRACT(YEAR FROM CASE
       WHEN PY.dat_calendar IS NULL AND PD.dat_calendar IS NULL
       THEN DATE_ADD(DD.dat_calendar, INTERVAL - 12 MONTH)
       ELSE PY.dat_calendar
       END), 4) = 0
  THEN DATE_ADD(CASE
    WHEN PY.dat_calendar IS NULL AND PD.dat_calendar IS NULL
    THEN DATE_ADD(DD.dat_calendar, INTERVAL - 12 MONTH)
    ELSE PY.dat_calendar
    END, INTERVAL - 1 MONTH)
  WHEN PYPM.dat_calendar IS NULL AND EXTRACT(DAY FROM PD.dat_calendar) = 29 AND EXTRACT(MONTH FROM PD.dat_calendar) = 2
   AND MOD(EXTRACT(YEAR FROM PD.dat_calendar), 4) = 0
  THEN NULL
  ELSE DATE_ADD(PD.dat_calendar, INTERVAL - 12 MONTH)
  END AS dat_calendar_pypm,
  CASE
  WHEN PPY.dat_calendar IS NULL AND PD.dat_calendar IS NULL
  THEN DATE_ADD(DD.dat_calendar, INTERVAL - 24 MONTH)
  ELSE PPY.dat_calendar
  END AS dat_calendar_ppy,
  CASE
  WHEN PPPY.dat_calendar IS NULL AND PD.dat_calendar IS NULL
  THEN DATE_ADD(DD.dat_calendar, INTERVAL - 36 MONTH)
  ELSE PPPY.dat_calendar
  END AS dat_calendar_pppy,
 MM.cy_month,
 MM.prev_month
FROM ldl_p_lew_mart_msi.v_cal_month AS MM
 INNER JOIN ldl_p_lew_mart_msi.v_cal_calendarday AS DD ON MM.cy_month = DD.cy_month
 LEFT JOIN ldl_p_lew_mart_msi.v_cal_calendarday AS PD ON MM.prev_month = PD.cy_month AND DATE_ADD(PD.dat_calendar,
    INTERVAL 1 MONTH) = DD.dat_calendar
 LEFT JOIN ldl_p_lew_mart_msi.v_cal_calendarday AS PY ON MM.cy_month = PY.cy_month + 100 AND DATE_ADD(PY.dat_calendar,
     INTERVAL 12 MONTH) = DD.dat_calendar AND DATE_ADD(PY.dat_calendar, INTERVAL 11 MONTH) = PD.dat_calendar
 LEFT JOIN ldl_p_lew_mart_msi.v_cal_calendarday AS PYPM ON MM.prev_month = PYPM.cy_month + 100 AND DATE_ADD(PYPM.dat_calendar
     ,INTERVAL 1 MONTH) = PY.dat_calendar AND DATE_ADD(PYPM.dat_calendar, INTERVAL 12 MONTH) = PD.dat_calendar
 LEFT JOIN ldl_p_lew_mart_msi.v_cal_calendarday AS PPY ON MM.cy_month = PPY.cy_month + 200 AND DATE_ADD(PPY.dat_calendar
     ,INTERVAL 24 MONTH) = DD.dat_calendar AND DATE_ADD(PPY.dat_calendar, INTERVAL 23 MONTH) = PD.dat_calendar
 LEFT JOIN ldl_p_lew_mart_msi.v_cal_calendarday AS PPPY ON MM.cy_month = PPPY.cy_month + 300 AND DATE_ADD(PPPY.dat_calendar
     ,INTERVAL 36 MONTH) = DD.dat_calendar AND DATE_ADD(PPPY.dat_calendar, INTERVAL 35 MONTH) = PD.dat_calendar
WHERE DD.dat_calendar >= DATE '2005-01-01';