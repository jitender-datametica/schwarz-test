/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_MAT_LEAD_STORE_MASTER_DATA_DAY_2
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  21.09.2017    Wieber,Harald            Change loc_sid to loc_sid_wh
#  1.2  17.10.2017    Toth,Gabriel             Added real_closed_store_fg
#  1.3  15.11.2017    Wieber,Harald            Release 1.1
#  1.4  04.01.2018    Mittler,Patrick          Change WHERE Condition
#  1.5  17.01.2018    Wieber,Harald            Release 2.2
#  1.6  03.10.2019    Khusainov,Timur          Renamed v_ view to v_mat view for materialyzing of logic.
#  1.7  30.10.2020    Rekovsky, Marvin         20201030_2642_Add_Flags_Nettolstg_Ber_Stg: New flags for the metrics Nettoleistung and bereinigte Steigerung
#  1.8  03.02.2021    Rekovsky, Marvin         20210203_2733_Calendar_Replacement: Replace calendar_2 submodel(v_wawi_cal_calendarday_2 and v_wawi_cal_busyear_2)
#  1.9  07.09.2021    Ketley, Andrew           Optimisation for SF: use persisted org_store_pre
#  1.10 24.02.2022    Jaroslaw Syrokosz        B-0011292A-AP0120280 - fix for corrected v_cal_month_ber_2
#  1.10 24.02.2022    Jaroslaw Syrokosz        B-0011292A-AP0120280 - added vvj and vvvj ber flags
#  1.11 25.11.2022    Simon Dite               405752_Croatia_EUR_conversion: added a special currency logic for Croatia
#  1.12 19.03.2024    Lukas Stober             AP0215430 -Added new column curr_tot_id for cube performance
#  1.13 23.09.2024    Marcin Malec             AP0165047; Adding columns building_type_id, building_status_id  from CORE t_building_2, t_building_hist_2
#----------------------------------------------------------------------------
*/ 

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_LEAD_STORE_MASTER_DATA_DAY_2(
    DAT_CALENDAR
    , CLIENT_ID
    , STORE_ID
    , OPEN_STORE_FG
    , NEW_STORE_FG
    , MOVED_STORE_FG
    , CLOSED_STORE_FG
    , REAL_CLOSED_STORE_FG
    , SALES_AREA
    , CURRENCY_ISO_CD
    , CURR_TOT_ID
    , BUILDING_TYPE_ID
    , BUILDING_STATUS_ID
    , BEREINIGT_FG
    , BEREINIGT_VJW_FG
    , BEREINIGT_VJM_FG
    , TIME_WORKING_NETTO_FG
    , BEREINIGT_VVJ_FG
    , BEREINIGT_VVJW_FG
    , BEREINIGT_VVJM_FG
    , BEREINIGT_VVVJ_FG
    , BEREINIGT_VVVJW_FG
    , BEREINIGT_VVVJM_FG
) AS
SELECT DISTINCT
   cal.cal_dt AS dat_calendar
   , store.client_id
   , store.store_id
   , CASE WHEN
            (cal.cal_dt BETWEEN store.dat_opening_ovis AND store.dat_closing_ovis - 1)
            OR (cal.cal_dt >= store.dat_opening_ovis AND store.dat_closing_ovis IS NULL)
        THEN 1
        ELSE 0
   END AS open_store_fg
   , CASE WHEN cal.cal_dt = store.dat_opening_ovis AND reloc2.move_fg = 0
        THEN 1
        ELSE 0
   END AS new_store_fg
   , CASE WHEN cal.cal_dt = store.dat_closing_ovis AND reloc.move_fg = 1
        THEN 1
        ELSE 0
   END AS moved_store_fg
   , CASE WHEN cal.cal_dt = store.dat_closing_ovis
        THEN 1
        ELSE 0
   END AS closed_store_fg
   , CASE WHEN cal.cal_dt = store.dat_closing_ovis 
          AND reloc.move_fg = 0
        THEN 1
        ELSE 0
   END AS real_closed_store_fg
   , area.val_indicator AS sales_area
   , cur.curr_cd AS currency_iso_cd
   ,Cast(CASE WHEN cur.curr_cd = 'EUR' THEN 0
              WHEN cur.curr_cd = 'GBP' THEN 40
          ELSE cur.client_id
          END AS SMALLINT) AS curr_tot_id
   , bld.building_type_id AS building_type_id
   , bldhst.building_status_id AS building_status_id
   , CASE WHEN  
            ((cal.cal_dt >= store.dat_calc_start_py AND store.move_fg = 1) 
            OR cal.cal_dt BETWEEN store.dat_calc_start_py AND store.dat_calc_end_py)
            OR (cal.cal_dt >= store.dat_calc_start_py AND store.dat_calc_end_py IS NULL)
        THEN 1
        ELSE 0
   END AS bereinigt_fg
   , CASE WHEN 
            ((calwkber.dat_calendar >=  store.dat_calc_start_py AND store.move_fg = 1)
            OR calwkber.dat_calendar BETWEEN store.dat_calc_start_py AND store.dat_calc_end_py)
            OR (calwkber.dat_calendar >=  store.dat_calc_start_py
            AND store.dat_calc_end_py IS NULL)
        THEN 1
        ELSE 0
   END AS bereinigt_VJW_fg
   , CASE WHEN  
            ((calmthber.dat_calendar_amd >= store.dat_calc_start_py AND store.move_fg = 1) 
            OR calmthber.dat_calendar_amd BETWEEN store.dat_calc_start_py AND store.dat_calc_end_py)
            OR (calmthber.dat_calendar_amd >= store.dat_calc_start_py AND store.dat_calc_end_py IS NULL) 
        THEN 1
        ELSE 0
   END AS bereinigt_VJM_fg
   , CASE WHEN wrktime.time_working_netto_std IS NOT NULL
        THEN 1
        ELSE 0
   END AS time_working_netto_fg
   , CASE WHEN  
            ((cal.cal_dt >= store.dat_calc_start_ppy AND store.move_fg = 1) 
            OR cal.cal_dt BETWEEN store.dat_calc_start_ppy AND store.dat_calc_end_ppy)
            OR (cal.cal_dt >= store.dat_calc_start_ppy AND store.dat_calc_end_ppy IS NULL)
        THEN 1
        ELSE 0
   END AS bereinigt_vvj_fg
   , CASE WHEN 
            ((calwkber_vvj.dat_calendar >=  store.dat_calc_start_ppy AND store.move_fg = 1)
            OR calwkber_vvj.dat_calendar BETWEEN store.dat_calc_start_ppy AND store.dat_calc_end_ppy)
            OR (calwkber_vvj.dat_calendar >=  store.dat_calc_start_ppy
            AND store.dat_calc_end_ppy IS NULL)
        THEN 1
        ELSE 0
   END AS bereinigt_VVJW_fg
   , CASE WHEN  
            ((calmthber_vvj.dat_calendar_amd >= store.dat_calc_start_ppy AND store.move_fg = 1) 
            OR calmthber_vvj.dat_calendar_amd BETWEEN store.dat_calc_start_ppy AND store.dat_calc_end_ppy)
            OR (calmthber_vvj.dat_calendar_amd >= store.dat_calc_start_ppy AND store.dat_calc_end_ppy IS NULL) 
        THEN 1
        ELSE 0
   END AS bereinigt_VVJM_fg
   , CASE WHEN  
            ((cal.cal_dt >= store.dat_calc_start_pppy AND store.move_fg = 1) 
            OR cal.cal_dt BETWEEN store.dat_calc_start_pppy AND store.dat_calc_end_pppy)
            OR (cal.cal_dt >= store.dat_calc_start_pppy AND store.dat_calc_end_pppy IS NULL)
        THEN 1
        ELSE 0
   END AS bereinigt_vvvj_fg
   , CASE WHEN 
            ((calwkber_vvvj.dat_calendar >=  store.dat_calc_start_pppy AND store.move_fg = 1)
            OR calwkber_vvvj.dat_calendar BETWEEN store.dat_calc_start_pppy AND store.dat_calc_end_pppy)
            OR (calwkber_vvvj.dat_calendar >=  store.dat_calc_start_pppy
            AND store.dat_calc_end_pppy IS NULL)
        THEN 1
        ELSE 0
   END AS bereinigt_VVVJW_fg
   , CASE WHEN  
            ((calmthber_vvvj.dat_calendar_amd >= store.dat_calc_start_pppy AND store.move_fg = 1) 
            OR calmthber_vvvj.dat_calendar_amd BETWEEN store.dat_calc_start_pppy AND store.dat_calc_end_pppy)
            OR (calmthber_vvvj.dat_calendar_amd >= store.dat_calc_start_pppy AND store.dat_calc_end_pppy IS NULL) 
        THEN 1
        ELSE 0
   END AS bereinigt_VVVJM_fg   
FROM      p_lew_mart_msi_ac.v_org_store_pre_2                                             AS store
          CROSS JOIN     p_lew_core.t_cal_calendarday_2                                AS cal
          INNER JOIN     p_lew_mart_msi.v_cal_week_ber_2                               AS calwkber
                         ON calwkber.prev_cy_dat_calendar_swd_ber = cal.cal_dt
          INNER JOIN     p_lew_mart_msi.t_cal_month_ber_2                              AS calmthber
                         ON calmthber.dat_calendar_pyd = cal.cal_dt
                         
          INNER JOIN     p_lew_mart_msi.v_cal_week_ber_2                               AS calwkber_vvj
                         ON calwkber_vvj.prev_prev_cy_dat_calendar_swd_ber = cal.cal_dt
          INNER JOIN     p_lew_mart_msi.t_cal_month_ber_2                              AS calmthber_vvj
                         ON calmthber_vvj.dat_calendar_ppy = cal.cal_dt

          INNER JOIN     p_lew_mart_msi.v_cal_week_ber_2                               AS calwkber_vvvj
                         ON calwkber_vvvj.prev_prev_prev_cy_dat_calendar_swd_ber = cal.cal_dt
          INNER JOIN     p_lew_mart_msi.t_cal_month_ber_2                              AS calmthber_vvvj
                         ON calmthber_vvvj.dat_calendar_pppy = cal.cal_dt
                         
          INNER JOIN     p_lew_core.t_wawi_org_all_store_reloc_act_2                   AS reloc
                         ON  reloc.client_id      = store.client_id
                         AND reloc.st_loc_sid     = store.store_id
          INNER JOIN     p_lew_core.t_wawi_org_all_store_reloc_act_2                   AS reloc2
                         ON  reloc2.client_id     = store.client_id
                         AND reloc2.st_loc_sid    = store.move_to_store_id
          LEFT JOIN      p_lew_mart_msi.v_ptm_working_time_store_2                     AS wrktime
                         ON  wrktime.client_id    = store.client_id
                         AND wrktime.store_id     = store.store_id
                         AND wrktime.dat_working  = cal.cal_dt

          LEFT JOIN      (
                              SELECT    kpges.client_id
                                        , kpges.store_id
                                        , kpges.val_indicator
                                        , c.cal_dt
                              FROM      p_lew_mart_msi.v_kpges_week_store_2            AS kpges
                                        INNER JOIN p_lew_core.t_cal_calendarday_2      AS c
                                        ON  kpges.cy_week             = c.cy_week
                                        AND kpges.indicator_id        = 246
                                        AND kpges.currency_iso_cd     = 'EUR'
                         )                                                           AS area
                         ON  area.client_id  = store.client_id
                         AND area.store_id   = store.store_id
                         AND area.cal_dt     = cal.cal_dt

          INNER JOIN     (
                              SELECT    client_id
                                        ,'EUR' AS curr_cd
                              FROM      p_lew_core.t_client_2 
                              WHERE     curr_cd <> 'EUR'
                              GROUP BY  1,2
                              UNION ALL
                              SELECT    client_id
                                        , curr_cd
                              FROM      p_lew_core.t_client_2
                              GROUP BY  1, 2
                              UNION ALL
                              SELECT    client_id
                                        ,'HRK' AS curr_cd
                              FROM      p_lew_core.t_client_2
                              WHERE     client_id = 15
                              GROUP BY  1,2
                         )                                                           AS cur 
                         ON  cur.client_id = store.client_id

          LEFT OUTER JOIN p_lew_core_ac.v_building_2                                   AS bld
                         ON  bld.client_id                    = store.client_id 
                         AND SUBSTR(bld.src_object_no, 3, 10) = store.orig_store_nr  /* bld.src_object_no is store number prefixed with client code eg. DE */ 
                         
          LEFT OUTER JOIN p_lew_core_ac.v_building_hist_2                              AS bldhst
                         ON  bldhst.client_id                 = bld.client_id 
                         AND bldhst.building_sid              = bld.building_sid
                         AND cal.cal_dt                       BETWEEN bldhst.dwh_valid_from AND bldhst.dwh_valid_to

WHERE     cal.busyear_seq BETWEEN -4 AND 0
          AND cal.cy_day_seq <= 0
          AND store.wh_id <> store.orig_store_nr
          AND NOT   (
                         store.client_id = 18
                         AND store.orig_store_nr BETWEEN 7501 AND 7599
                    )
;