CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_ADV_INT_1
AS
  /*
  2021-12-30 Martin Murtenthaler Correction of evaluation of column cy,
                               as sometimes it is incorrect  Incident INC4030129
  */
   SELECT
   (cal.cy_week - MOD(cal.cy_week,100)) / 100 AS cy            -- Kalenderjahr 
   ,MOD( cal.cy_week, 100) AS adv_week_int  -- Werbeterminwoche 
   ,CASE cal.day_of_week
      WHEN 1 THEN 1
      WHEN 2 THEN 1
      WHEN 6 THEN 3
      WHEN 7 THEN 3
      ELSE 2
    END                  AS adv_wt_nr_int -- Werbeterminwoche 
   ,cal.cy_week         AS cy_week    -- zugehorige Woche_1 
   ,adv.client_id
   ,co.country_iso_cd
   ,vlmk.wawi_dwh_wh_id AS wh_id                                             -- BGES 
   ,Trim(   'KW '
          || Trim(adv_wt_nr_int)
          || ' / '
          || Trim(adv_week_int)
          || '  '
          || Trim(cy)
        )               AS week_adv        -- Werbetermin BGES 
   ,adv.dat_adv                            -- Werbetermindatum BGES 
   FROM
  (SELECT
     adv.client_id
    ,adv.wh_loc_sid
    ,adv.dat_adv
   FROM p_lew_core_ac.v_wawi_adv_item_advertising_1 AS adv
   UNION
   SELECT
     adv_s_ap.client_id
    ,adv_s_ap.wh_loc_sid
    ,adv_s_ap.dat_adv
   FROM p_lew_core_ac.v_wawi_adv_item_advertising_s_ap_1 AS adv_s_ap
   ) AS adv
   INNER JOIN p_lew_core_ac.v_loc_map_key_1 AS vlmk
   ON vlmk.loc_sid =  adv.wh_loc_sid
   INNER JOIN p_lew_core_ac.v_wawi_cal_calendarday_1 AS cal
   ON  cal.dat_calendar = adv.dat_adv
   INNER JOIN p_lew_core_ac.v_wawi_ref_country_1 AS co
   ON  co.country_id = adv.client_id
   GROUP BY
     cal.cy
   , adv_week_int
   , adv_wt_nr_int
   , cy_week
   , adv.client_id
   , co.country_iso_cd
   , wh_id
   , week_adv
   , adv.dat_adv
;