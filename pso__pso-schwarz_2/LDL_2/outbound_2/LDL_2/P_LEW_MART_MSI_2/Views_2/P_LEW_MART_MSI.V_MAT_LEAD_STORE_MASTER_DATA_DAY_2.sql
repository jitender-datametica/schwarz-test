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


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_lead_store_master_data_day_2 (dat_calendar, client_id, store_id,
open_store_fg, new_store_fg, moved_store_fg, closed_store_fg, real_closed_store_fg, sales_area, currency_iso_cd,
curr_tot_id, building_type_id, building_status_id, bereinigt_fg, bereinigt_vjw_fg, bereinigt_vjm_fg,
time_working_netto_fg, bereinigt_vvj_fg, bereinigt_vvjw_fg, bereinigt_vvjm_fg, bereinigt_vvvj_fg, bereinigt_vvvjw_fg,
bereinigt_vvvjm_fg) AS SELECT DISTINCT CAL.cal_dt AS dat_calendar,
 STORE.client_id,
 STORE.store_id,
  CASE
  WHEN CAL.cal_dt BETWEEN STORE.dat_opening_ovis AND (DATE_SUB(STORE.dat_closing_ovis, INTERVAL 1 DAY)) OR CAL.cal_dt >=
     STORE.dat_opening_ovis AND STORE.dat_closing_ovis IS NULL
  THEN 1
  ELSE 0
  END AS open_store_fg,
  CASE
  WHEN CAL.cal_dt = STORE.dat_opening_ovis AND RELOC2.move_fg = 0
  THEN 1
  ELSE 0
  END AS new_store_fg,
  CASE
  WHEN CAL.cal_dt = STORE.dat_closing_ovis AND RELOC.move_fg = 1
  THEN 1
  ELSE 0
  END AS moved_store_fg,
  CASE
  WHEN CAL.cal_dt = STORE.dat_closing_ovis
  THEN 1
  ELSE 0
  END AS closed_store_fg,
  CASE
  WHEN CAL.cal_dt = STORE.dat_closing_ovis AND RELOC.move_fg = 0
  THEN 1
  ELSE 0
  END AS real_closed_store_fg,
 area.val_indicator AS sales_area,
 cur.curr_cd AS currency_iso_cd,
 CAST(CASE
   WHEN cur.curr_cd = 'EUR'
   THEN 0
   WHEN cur.curr_cd = 'GBP'
   THEN 40
   ELSE cur.client_id
   END AS BIGNUMERIC) AS curr_tot_id,
 BLD.building_type_id,
 BLDHST.building_status_id,
  CASE
  WHEN CAL.cal_dt >= STORE.dat_calc_start_py AND STORE.move_fg = 1 OR CAL.cal_dt BETWEEN STORE.dat_calc_start_py AND
     STORE.dat_calc_end_py OR CAL.cal_dt >= STORE.dat_calc_start_py AND STORE.dat_calc_end_py IS NULL
  THEN 1
  ELSE 0
  END AS bereinigt_fg,
  CASE
  WHEN CALWKBER.dat_calendar >= STORE.dat_calc_start_py AND STORE.move_fg = 1 OR CALWKBER.dat_calendar BETWEEN STORE.dat_calc_start_py
     AND STORE.dat_calc_end_py OR CALWKBER.dat_calendar >= STORE.dat_calc_start_py AND STORE.dat_calc_end_py IS NULL
  THEN 1
  ELSE 0
  END AS bereinigt_vjw_fg,
  CASE
  WHEN CALMTHBER.dat_calendar_amd >= STORE.dat_calc_start_py AND STORE.move_fg = 1 OR CALMTHBER.dat_calendar_amd BETWEEN
     STORE.dat_calc_start_py AND STORE.dat_calc_end_py OR CALMTHBER.dat_calendar_amd >= STORE.dat_calc_start_py AND
    STORE.dat_calc_end_py IS NULL
  THEN 1
  ELSE 0
  END AS bereinigt_vjm_fg,
  CASE
  WHEN WRKTIME.time_working_netto_std IS NOT NULL
  THEN 1
  ELSE 0
  END AS time_working_netto_fg,
  CASE
  WHEN CAL.cal_dt >= STORE.dat_calc_start_ppy AND STORE.move_fg = 1 OR CAL.cal_dt BETWEEN STORE.dat_calc_start_ppy AND
     STORE.dat_calc_end_ppy OR CAL.cal_dt >= STORE.dat_calc_start_ppy AND STORE.dat_calc_end_ppy IS NULL
  THEN 1
  ELSE 0
  END AS bereinigt_vvj_fg,
  CASE
  WHEN CALWKBER_VVJ.dat_calendar >= STORE.dat_calc_start_ppy AND STORE.move_fg = 1 OR CALWKBER_VVJ.dat_calendar BETWEEN
     STORE.dat_calc_start_ppy AND STORE.dat_calc_end_ppy OR CALWKBER_VVJ.dat_calendar >= STORE.dat_calc_start_ppy AND
    STORE.dat_calc_end_ppy IS NULL
  THEN 1
  ELSE 0
  END AS bereinigt_vvjw_fg,
  CASE
  WHEN CALMTHBER_VVJ.dat_calendar_amd >= STORE.dat_calc_start_ppy AND STORE.move_fg = 1 OR CALMTHBER_VVJ.dat_calendar_amd
     BETWEEN STORE.dat_calc_start_ppy AND STORE.dat_calc_end_ppy OR CALMTHBER_VVJ.dat_calendar_amd >= STORE.dat_calc_start_ppy
      AND STORE.dat_calc_end_ppy IS NULL
  THEN 1
  ELSE 0
  END AS bereinigt_vvjm_fg,
  CASE
  WHEN CAL.cal_dt >= STORE.dat_calc_start_pppy AND STORE.move_fg = 1 OR CAL.cal_dt BETWEEN STORE.dat_calc_start_pppy AND
     STORE.dat_calc_end_pppy OR CAL.cal_dt >= STORE.dat_calc_start_pppy AND STORE.dat_calc_end_pppy IS NULL
  THEN 1
  ELSE 0
  END AS bereinigt_vvvj_fg,
  CASE
  WHEN CALWKBER_VVVJ.dat_calendar >= STORE.dat_calc_start_pppy AND STORE.move_fg = 1 OR CALWKBER_VVVJ.dat_calendar
     BETWEEN STORE.dat_calc_start_pppy AND STORE.dat_calc_end_pppy OR CALWKBER_VVVJ.dat_calendar >= STORE.dat_calc_start_pppy
      AND STORE.dat_calc_end_pppy IS NULL
  THEN 1
  ELSE 0
  END AS bereinigt_vvvjw_fg,
  CASE
  WHEN CALMTHBER_VVVJ.dat_calendar_amd >= STORE.dat_calc_start_pppy AND STORE.move_fg = 1 OR CALMTHBER_VVVJ.dat_calendar_amd
     BETWEEN STORE.dat_calc_start_pppy AND STORE.dat_calc_end_pppy OR CALMTHBER_VVVJ.dat_calendar_amd >= STORE.dat_calc_start_pppy
      AND STORE.dat_calc_end_pppy IS NULL
  THEN 1
  ELSE 0
  END AS bereinigt_vvvjm_fg
FROM ldl_p_lew_mart_msi_ac.v_org_store_pre_2 AS STORE
 INNER JOIN ldl_p_lew_core.t_cal_calendarday_2 AS CAL ON TRUE
 INNER JOIN ldl_p_lew_mart_msi.v_cal_week_ber_2 AS CALWKBER ON CAL.cal_dt = CALWKBER.prev_cy_dat_calendar_swd_ber
 INNER JOIN ldl_p_lew_mart_msi.t_cal_month_ber_2 AS CALMTHBER ON CAL.cal_dt = CALMTHBER.dat_calendar_pyd
 INNER JOIN ldl_p_lew_mart_msi.v_cal_week_ber_2 AS CALWKBER_VVJ ON CAL.cal_dt = CALWKBER_VVJ.prev_prev_cy_dat_calendar_swd_ber
  
 INNER JOIN ldl_p_lew_mart_msi.t_cal_month_ber_2 AS CALMTHBER_VVJ ON CAL.cal_dt = CALMTHBER_VVJ.dat_calendar_ppy
 INNER JOIN ldl_p_lew_mart_msi.v_cal_week_ber_2 AS CALWKBER_VVVJ ON CAL.cal_dt = CALWKBER_VVVJ.prev_prev_prev_cy_dat_calendar_swd_ber
  
 INNER JOIN ldl_p_lew_mart_msi.t_cal_month_ber_2 AS CALMTHBER_VVVJ ON CAL.cal_dt = CALMTHBER_VVVJ.dat_calendar_pppy
 INNER JOIN ldl_p_lew_core.t_wawi_org_all_store_reloc_act_2 AS RELOC ON STORE.client_id = RELOC.client_id AND STORE.store_id
    = RELOC.st_loc_sid
 INNER JOIN ldl_p_lew_core.t_wawi_org_all_store_reloc_act_2 AS RELOC2 ON STORE.client_id = RELOC2.client_id AND STORE.move_to_store_id
    = RELOC2.st_loc_sid
 LEFT JOIN ldl_p_lew_mart_msi.v_ptm_working_time_store_2 AS WRKTIME ON STORE.client_id = WRKTIME.client_id AND STORE.store_id
     = WRKTIME.store_id AND CAL.cal_dt = WRKTIME.dat_working
 LEFT JOIN (SELECT KPGES.client_id,
   KPGES.store_id,
   KPGES.val_indicator,
   C.cal_dt
  FROM ldl_p_lew_mart_msi.v_kpges_week_store_2 AS KPGES
   INNER JOIN ldl_p_lew_core.t_cal_calendarday_2 AS C ON KPGES.cy_week = C.cy_week AND KPGES.indicator_id = 246 AND KPGES
     .currency_iso_cd = 'EUR') AS area ON STORE.client_id = area.client_id AND STORE.store_id = area.store_id AND CAL.cal_dt
    = area.cal_dt
 INNER JOIN (SELECT client_id,
    'EUR' AS curr_cd
   FROM ldl_p_lew_core.t_client_2
   WHERE curr_cd <> 'EUR'
   GROUP BY client_id,
    curr_cd
   UNION ALL
   SELECT client_id,
    curr_cd
   FROM ldl_p_lew_core.t_client_2
   GROUP BY client_id,
    curr_cd
   UNION ALL
   SELECT client_id,
    'HRK' AS curr_cd
   FROM ldl_p_lew_core.t_client_2
   WHERE client_id = 15
   GROUP BY client_id,
    curr_cd) AS cur ON STORE.client_id = cur.client_id
 LEFT JOIN ldl_p_lew_core_ac.v_building_2 AS BLD ON STORE.client_id = BLD.client_id AND CAST(SUBSTR(BLD.src_object_no, 3, 10) AS FLOAT64)
   = STORE.orig_store_nr /* bld.src_object_no is store number prefixed with client code eg. DE */
 LEFT JOIN ldl_p_lew_core_ac.v_building_hist_2 AS BLDHST ON BLD.client_id = BLDHST.client_id AND BLD.building_sid = BLDHST
      .building_sid AND CAL.cal_dt BETWEEN BLDHST.dwh_valid_from AND BLDHST.dwh_valid_to AND STORE.wh_id <> STORE.orig_store_nr
     AND (STORE.client_id <> 18 OR NOT STORE.orig_store_nr BETWEEN 7501 AND 7599)
WHERE CAL.busyear_seq BETWEEN - 4 AND 0
 AND CAL.cy_day_seq <= 0;