CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_adv_int_2 AS SELECT (t3.cy_week - t3.adv_week_int) / 100 AS cy,
 t3.adv_week_int,
 t3.adv_wt_nr_int,
 t3.cy_week,
 t3.client_id,
 t3.country_iso_cd,
 t3.wh_id,
 t3.week_adv,
 t3.dat_adv
FROM (SELECT CAL.cy,
   MOD(CAST(CAL.cy_week AS BIGNUMERIC), 100) AS adv_week_int,
    CASE
    WHEN CAL.day_of_week IN (1, 2)
    THEN 1
    WHEN CAL.day_of_week IN (6, 7)
    THEN 3
    ELSE 2
    END AS adv_wt_nr_int,
   CAL.cy_week,
   adv.client_id,
   CO.country_iso_cd,
   VLMK.wawi_dwh_wh_id AS wh_id,
   TRIM('KW ' || TRIM(SUBSTR(CAST(CASE
             WHEN CAL.day_of_week IN (1, 2)
             THEN 1
             WHEN CAL.day_of_week IN (6, 7)
             THEN 3
             ELSE 2
             END AS STRING), 1, 10)) || ' / ' || TRIM(SUBSTR(CAST(MOD(CAST(CAL.cy_week AS BIGNUMERIC), 100) AS STRING),
         1, 10)) || '  ' || TRIM(SUBSTR(CAST(CAL.cy AS STRING), 1, 39))) AS week_adv,
   adv.dat_adv
  FROM (SELECT client_id,
      wh_loc_sid,
      dat_adv
     FROM ldl_p_lew_core_ac.v_wawi_adv_item_advertising_2 AS ADV
     UNION DISTINCT
     SELECT client_id,
      wh_loc_sid,
      dat_adv
     FROM ldl_p_lew_core_ac.v_wawi_adv_item_advertising_s_ap_2 AS ADV_S_AP) AS adv
   INNER JOIN ldl_p_lew_core_ac.v_loc_map_key_2 AS VLMK ON adv.wh_loc_sid = VLMK.loc_sid
   INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_calendarday_2 AS CAL ON adv.dat_adv = CAL.dat_calendar
   INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country_2 AS CO ON adv.client_id = CO.country_id
  GROUP BY CAL.cy,
   adv_week_int,
   adv_wt_nr_int,
   CAL.cy_week,
   adv.client_id,
   CO.country_iso_cd,
   wh_id,
   week_adv,
   adv.dat_adv) AS t3;