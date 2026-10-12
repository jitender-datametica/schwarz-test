/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_VAL_NET_PERFORM_HR_MSTR_1
#----------------------------------------------------------------------------
# History:
#  1.0  13.03.2023    Ulrich Ross               Init, User Story 449330
#  1.1  19.04.2023    Ulrich Ross               User Story 466935, remove columns and change values in column client_desc
#  1.2  23.06.2023    Ulrich Ross               User Story 493455, Change attribut country_cd to country_iso_cd
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_bw_val_net_perform_hr_mstr_1 AS WITH TURNOVER AS (SELECT CAL.dat_calendar,
   STORE.move_to_store_id AS store_id,
   STORE.aspect_id,
   STORE.client_id,
   SUM(TURNOVER.val_rtl_net) AS m1401
  FROM ldl_p_lew_mart_msi_ac.v_agg_store_day_turnover_ext_1 AS TURNOVER
   INNER JOIN ldl_p_lew_mart_msi_ac.v_org_store_merge_1 AS STORE ON TURNOVER.client_id = STORE.client_id AND TURNOVER.store_id
      = STORE.store_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_currency_1 AS CURRENCY ON TURNOVER.client_id = CURRENCY.client_id AND TURNOVER.currency_iso_cd
      = CURRENCY.currency_iso_cd
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday_1 AS CAL ON TURNOVER.dat_formdate = CAL.dat_calendar
  WHERE CAL.byr BETWEEN EXTRACT(YEAR FROM CURRENT_DATE) - 3 AND (EXTRACT(YEAR FROM CURRENT_DATE))
   AND STORE.aspect_id IN (1)
   AND CURRENCY.curr_tot_id = 0
   AND CURRENCY.currency_iso_cd = 'eur'
   AND STORE.dashboard_relevant_fg = 1
  GROUP BY CAL.dat_calendar,
   store_id,
   STORE.aspect_id,
   STORE.client_id), WORKTIME_SALESPIECES AS (SELECT CAL0.dat_calendar,
   STORE0.move_to_store_id AS store_id,
   STORE0.aspect_id,
   STORE0.client_id,
   SUM(SP_P.sales_pieces) AS wjxbfs1,
   SUM(SP_P.work_time_total_hr) AS wjxbfs2,
   SUM(CASE
     WHEN CAL0.cy_day_sequence <= 0
     THEN SP_P.sales_pieces
     ELSE NULL
     END) AS wjxbfs3
  FROM ldl_p_lew_mart_lead_ac.v_agg_store_day_sales_piece_perf_1 AS SP_P
   INNER JOIN ldl_p_lew_mart_msi_ac.v_org_store_merge_1 AS STORE0 ON SP_P.client_id = STORE0.client_id AND SP_P.loc_sid_store
      = STORE0.store_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_currency_1 AS CURRENCY0 ON SP_P.client_id = CURRENCY0.client_id AND SP_P.currency_iso_cd
      = CURRENCY0.currency_iso_cd
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday_1 AS CAL0 ON SP_P.dwh_cal_dt = CAL0.dat_calendar
  WHERE CAL0.byr BETWEEN EXTRACT(YEAR FROM CURRENT_DATE) - 3 AND (EXTRACT(YEAR FROM CURRENT_DATE))
   AND STORE0.aspect_id IN (1)
   AND CURRENCY0.curr_tot_id = 0
   AND CURRENCY0.currency_iso_cd = 'eur'
   AND STORE0.dashboard_relevant_fg = 1
  GROUP BY CAL0.dat_calendar,
   store_id,
   STORE0.aspect_id,
   STORE0.client_id), TURNOVER_WORKTIME_SALESPIECES AS (SELECT COALESCE(turnover.dat_calendar, sp_p.dat_calendar) AS
   dat_calendar,
   COALESCE(turnover.store_id, sp_p.store_id) AS store_id,
   COALESCE(turnover.aspect_id, sp_p.aspect_id) AS aspect_id,
   COALESCE(turnover.client_id, sp_p.client_id) AS client_id,
   turnover.m1401,
   sp_p.wjxbfs1,
   sp_p.wjxbfs2
  FROM TURNOVER AS turnover
   FULL JOIN WORKTIME_SALESPIECES AS sp_p ON turnover.aspect_id = sp_p.aspect_id AND turnover.client_id = sp_p.client_id
        AND turnover.dat_calendar = sp_p.dat_calendar AND turnover.store_id = sp_p.store_id) (SELECT CAL2.byr,
   STORE2.client_id,
   STORE2.country_iso_cd AS client_desc,
   STORE2.move_to_store_id AS store_id,
   STORE2.aspect_id,
   STORE2.orig_store_nr,
   CAL2.dat_calendar AS dat_calendar1,
   CAL2.cy_month,
   MAX(tws.wjxbfs1) AS wjxbfs1,
   MAX(tws.wjxbfs2) AS wjxbfs3
  FROM TURNOVER_WORKTIME_SALESPIECES AS tws
   FULL JOIN WORKTIME_SALESPIECES AS sp_p ON tws.aspect_id = sp_p.aspect_id AND tws.client_id = sp_p.client_id AND tws.dat_calendar
       = sp_p.dat_calendar AND tws.store_id = sp_p.store_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday_1 AS CAL2 ON COALESCE(tws.dat_calendar, sp_p.dat_calendar) = CAL2.dat_calendar
    
   INNER JOIN ldl_p_lew_mart_msi_ac.v_org_all_store_merge_1 AS STORE2 ON COALESCE(tws.aspect_id, sp_p.aspect_id) = STORE2
      .aspect_id AND COALESCE(tws.client_id, sp_p.client_id) = STORE2.client_id AND COALESCE(tws.store_id, sp_p.store_id
      ) = STORE2.move_to_store_id
  GROUP BY CAL2.byr,
   STORE2.client_id,
   client_desc,
   store_id,
   STORE2.aspect_id,
   STORE2.orig_store_nr,
   dat_calendar1,
   CAL2.cy_month);