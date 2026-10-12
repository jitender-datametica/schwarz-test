
CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_adv_date
 AS
/* Take only currently valid rows from base table */ SELECT t10.client_id,
 t10.wh_id,
 t10.dat_adv,
     SUBSTR(TRIM(SUBSTR(CAST(t10.cy_week AS STRING), 1, 39)), 5, 2) || '/' || TRIM(SUBSTR(CAST(t10.day_of_week AS STRING)
      , 1, 39)) || ' ' || TRIM(SUBSTR(CAST(t10.cy_week / 100 AS STRING), 1, 20)) AS week_adv,
 t10.day_of_week,
 t10.cy_week,
 t10.cy_month,
   (t10.cy_week - MOD(CAST(t10.cy_week AS BIGNUMERIC), 100)) / 100 AS cy_year,
 t10.busyear,
 t10.rec_src_fg_std,
 t10.rec_src_fg_apt
FROM (SELECT d.client_id,
   d.wh_id,
   d.dat_adv,
       SUBSTR(TRIM(SUBSTR(CAST(CAL.cy_week AS STRING), 1, 39)), 5, 2) || '/' || TRIM(SUBSTR(CAST(CAL.day_of_week AS STRING)
        , 1, 39)) || ' ' || TRIM(SUBSTR(CAST((CAL.cy_week - MOD(CAST(CAL.cy_week AS BIGNUMERIC), 100)) / 100 AS STRING)
      , 1, 20)) AS dm__operand,
   CAL.day_of_week,
   CAL.cy_week,
   CAL.cy_month,
   CAL.busyear,
   MAX(d.rec_src_fg_std) AS rec_src_fg_std,
   MAX(d.rec_src_fg_apt) AS rec_src_fg_apt
  FROM (SELECT STD.client_id,
      WH.src_wh_id AS wh_id,
      STD.dat_adv,
      STD.week_adv,
      CAST(NULL AS STRING) AS adv_desc_apt,
      1 AS rec_src_fg_std,
      0 AS rec_src_fg_apt
     FROM ldl_p_lew_core_ac.v_wawi_adv_item_advertising AS STD
      INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON STD.client_id = WH.client_id AND STD.wh_loc_sid = WH.loc_sid_wh
       AND WH.dwh_actual_fg = 1
     GROUP BY STD.client_id,
      wh_id,
      STD.dat_adv,
      STD.week_adv
     UNION ALL
     SELECT APT.client_id,
      WH.src_wh_id AS wh_id,
      APT.dat_adv,
      CAST(NULL AS STRING) AS adv_desc_std,
      APT.dat_adv_desc AS adv_desc_apt,
      0 AS rec_src_fg_std,
      1 AS rec_src_fg_apt
     FROM ldl_p_lew_core_ac.v_wawi_adv_item_advertising_s_ap AS APT
      INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON APT.client_id = WH.client_id AND APT.wh_loc_sid = WH.loc_sid_wh
       AND WH.dwh_actual_fg = 1
     WHERE CURRENT_DATE BETWEEN APT.dat_rec_start AND APT.dat_rec_end
     GROUP BY APT.client_id,
      wh_id,
      APT.dat_adv,
      adv_desc_apt) AS d
   INNER JOIN (ldl_p_lew_core_ac.v_cal_calendarday AS CAL LEFT JOIN (SELECT MAX(cy) - 6 AS a1956017650
     FROM ldl_p_lew_core_ac.v_cal_calendarday) AS t8 ON TRUE) ON d.dat_adv = CAL.cal_dt AND CAL.cy < t8.a1956017650
  GROUP BY d.client_id,
   d.wh_id,
   d.dat_adv,
   dm__operand,
   CAL.day_of_week,
   CAL.cy_week,
   CAL.cy_month,
   CAL.busyear) AS t10;

