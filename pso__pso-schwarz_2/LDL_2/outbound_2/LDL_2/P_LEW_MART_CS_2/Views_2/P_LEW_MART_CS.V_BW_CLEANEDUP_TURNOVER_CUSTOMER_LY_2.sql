/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_CLEANEDUP_TURNOVER_CUSTOMER_LY_2
#----------------------------------------------------------------------------
# History:
#  1.0  12.05.2023    Ulrich Ross               Init, User Story 476747
#----------------------------------------------------------------------------
*/


-- bereinigter umsatz vj
 -- bereinigter umsatz lj (auf basis vj)
 -- kundenanzahl bereinigt vj

-- kundenanzahl bereinigt
 -- bereinigter umsatz netto vj

CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_bw_cleanedup_turnover_customer_ly_2 AS WITH TURNOVER_BER AS (SELECT CURR.currency_iso_cd
   ,
   CAL.cy_month,
   STORE.client_id,
   SUM(TURNOVER.val_rtl_net * TURNOVER.bereinigt_fg) AS m1401
  FROM ldl_p_lew_mart_msi_ac.v_agg_store_day_turnover_ext_2 AS TURNOVER
   INNER JOIN ldl_p_lew_mart_msi_ac.v_org_store_merge_2 AS STORE ON TURNOVER.client_id = STORE.client_id AND TURNOVER.store_id
      = STORE.store_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday_2 AS CAL ON TURNOVER.dat_formdate = CAL.dat_calendar
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_currency_2 AS CURR ON TURNOVER.client_id = CURR.client_id AND TURNOVER.currency_iso_cd
      = CURR.currency_iso_cd
  WHERE STORE.aspect_id = 1
   AND CAL.cy_month BETWEEN ROUND(CAST(FORMAT_DATE('%Y%m', DATE_ADD(CURRENT_DATE, INTERVAL - 6 YEAR)) AS BIGNUMERIC), 0
     ) AND (ROUND(CAST(FORMAT_DATE('%Y%m', CURRENT_DATE) AS BIGNUMERIC), 0))
   AND STORE.dashboard_relevant_fg = 1
  GROUP BY CURR.currency_iso_cd,
   CAL.cy_month,
   STORE.client_id), CUSTOMER_BER AS (SELECT CURR0.currency_iso_cd,
   CAL0.cy_month,
   STORE0.client_id,
   SUM(CUSTOMER.cnt_customer_asis * TURNOVER0.bereinigt_fg) AS m1404
  FROM ldl_p_lew_mart_msi_ac.v_agg_store_day_turnover_ext_2 AS TURNOVER0
   INNER JOIN ldl_p_lew_mart_msi_ac.v_agg_str_day_ejr_txj_ww_ext_2 AS CUSTOMER ON TURNOVER0.client_id = CUSTOMER.client_id
        AND TURNOVER0.currency_iso_cd = CUSTOMER.currency_iso_cd AND TURNOVER0.dat_formdate = CUSTOMER.dat_formdate AND
     TURNOVER0.store_id = CUSTOMER.store_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_org_store_merge_2 AS STORE0 ON TURNOVER0.client_id = STORE0.client_id AND TURNOVER0
     .store_id = STORE0.store_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday_2 AS CAL0 ON TURNOVER0.dat_formdate = CAL0.dat_calendar
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_currency_2 AS CURR0 ON TURNOVER0.client_id = CURR0.client_id AND TURNOVER0.currency_iso_cd
      = CURR0.currency_iso_cd
  WHERE STORE0.aspect_id = 1
   AND CAL0.cy_month BETWEEN ROUND(CAST(FORMAT_DATE('%Y%m', DATE_ADD(CURRENT_DATE, INTERVAL - 6 YEAR)) AS BIGNUMERIC), 0
     ) AND (ROUND(CAST(FORMAT_DATE('%Y%m', CURRENT_DATE) AS BIGNUMERIC), 0))
   AND STORE0.dashboard_relevant_fg = 1
  GROUP BY CURR0.currency_iso_cd,
   CAL0.cy_month,
   STORE0.client_id), UMSATZ_CUSTOMER_LY_BER AS (SELECT CURR1.currency_iso_cd,
   CAL_MONTH_BER.cy_month,
   STORE1.client_id,
   SUM(CUSTOMER0.cnt_customer_asis * TURNOVER1.bereinigt_vjm_fg) AS m1404,
   SUM(TURNOVER1.val_rtl_net * TURNOVER1.bereinigt_vjm_fg) AS m1401
  FROM ldl_p_lew_mart_msi_ac.v_agg_store_day_turnover_ext_2 AS TURNOVER1
   INNER JOIN ldl_p_lew_mart_msi_ac.v_agg_str_day_ejr_txj_ww_ext_2 AS CUSTOMER0 ON TURNOVER1.client_id = CUSTOMER0.client_id
        AND TURNOVER1.currency_iso_cd = CUSTOMER0.currency_iso_cd AND TURNOVER1.dat_formdate = CUSTOMER0.dat_formdate
    AND TURNOVER1.store_id = CUSTOMER0.store_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_month_ber_2 AS CAL_MONTH_BER ON TURNOVER1.dat_formdate = CAL_MONTH_BER.dat_calendar_pyd
    
   INNER JOIN ldl_p_lew_mart_msi_ac.v_org_store_merge_2 AS STORE1 ON TURNOVER1.client_id = STORE1.client_id AND TURNOVER1
     .store_id = STORE1.store_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_currency_2 AS CURR1 ON TURNOVER1.client_id = CURR1.client_id AND TURNOVER1.currency_iso_cd
      = CURR1.currency_iso_cd
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday_2 AS CAL1 ON CAL_MONTH_BER.dat_calendar_amd = CAL1.dat_calendar
  WHERE CAL1.cy_day_sequence <= 0
   AND STORE1.aspect_id = 1
   AND CAL1.cy_month BETWEEN ROUND(CAST(FORMAT_DATE('%Y%m', DATE_ADD(CURRENT_DATE, INTERVAL - 6 YEAR)) AS BIGNUMERIC), 0
     ) AND (ROUND(CAST(FORMAT_DATE('%Y%m', CURRENT_DATE) AS BIGNUMERIC), 0))
   AND STORE1.dashboard_relevant_fg = 1
  GROUP BY CURR1.currency_iso_cd,
   CAL_MONTH_BER.cy_month,
   STORE1.client_id), TURNOVER_LY AS (SELECT CURR2.currency_iso_cd,
   CAL_MONTH_BER0.cy_month,
   CURR2.client_id,
   SUM(TURNOVER2.val_rtl_net) AS m1402
  FROM ldl_p_lew_mart_msi_ac.v_agg_store_day_turnover_ext_2 AS TURNOVER2
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_month_ber_2 AS CAL_MONTH_BER0 ON TURNOVER2.dat_formdate = CAL_MONTH_BER0.dat_calendar_pyd
    
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_currency_2 AS CURR2 ON TURNOVER2.client_id = CURR2.client_id AND TURNOVER2.currency_iso_cd
      = CURR2.currency_iso_cd
   INNER JOIN ldl_p_lew_mart_msi_ac.v_org_store_merge_2 AS STORE2 ON TURNOVER2.client_id = STORE2.client_id AND TURNOVER2
     .store_id = STORE2.store_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday_2 AS CAL2 ON CAL_MONTH_BER0.dat_calendar_amd = CAL2.dat_calendar
  WHERE (CAL_MONTH_BER0.dat_calendar_amd >= STORE2.dat_calc_start_py AND STORE2.move_fg = 1 OR CAL_MONTH_BER0.dat_calendar_amd
       BETWEEN STORE2.dat_calc_start_py AND STORE2.dat_calc_end_py OR CAL_MONTH_BER0.dat_calendar_amd >= STORE2.dat_calc_start_py
        AND STORE2.dat_calc_end_py IS NULL)
   AND CAL2.cy_day_sequence <= 0
   AND STORE2.aspect_id = 1
   AND CAL2.cy_month BETWEEN ROUND(CAST(FORMAT_DATE('%Y%m', DATE_ADD(CURRENT_DATE, INTERVAL - 6 YEAR)) AS BIGNUMERIC), 0
     ) AND (ROUND(CAST(FORMAT_DATE('%Y%m', CURRENT_DATE) AS BIGNUMERIC), 0))
   AND STORE2.dashboard_relevant_fg = 1
  GROUP BY CURR2.currency_iso_cd,
   CAL_MONTH_BER0.cy_month,
   CURR2.client_id) (-- bereinigter umsatz lj (auf basis vj)
 -- bereinigter umsatz vj
 -- bereinigter umsatz netto vj

  -- kundenanzahl bereinigt
 -- kundenanzahl bereinigt vj
 SELECT TRIM(SUBSTR(CAST(t16.dm__operand AS STRING), 1, 39))
   AS calmonth,
   t16.client_id,
   t16.client_desc,
   t16.currency_iso_cd,
   t16.country_iso_cd,
   IF(t16.a0_0 * 100 = 0, 0, SAFE_DIVIDE(t16.a0 - t16.a0_0, t16.a0_0 * 100)) AS ber_kund_in_proz,
   IF(t16.a0_2 * 100 = 0, 0, SAFE_DIVIDE(t16.a0_1 - t16.a0_2, t16.a0_2 * 100)) AS ber_umsatz_in_proz,
   t16.a0_1 AS turnover_lj_ber,
   t16.turnover_vj_ber,
   t16.a0_2 AS turnover_vj_ber_netto,
   t16.a0 AS customer_lj_ber,
   t16.a0_0 AS customer_vj_ber
  FROM (SELECT COALESCE(turnbe.cy_month, cust_be.cy_month, cust_ly_be.cy_month, turn_ly.cy_month) AS dm__operand,
     COALESCE(turnbe.currency_iso_cd, cust_be.currency_iso_cd, cust_ly_be.currency_iso_cd, turn_ly.currency_iso_cd) AS
     currency_iso_cd,
     COALESCE(turnbe.client_id, cust_be.client_id, cust_ly_be.client_id, turn_ly.client_id) AS client_id,
     MAX(CLIENT_LEAD.country_desc) AS client_desc,
     MAX(CLIENT_LEAD.country_iso_cd) AS country_iso_cd,
     MAX(cust_be.m1404) AS a0,
     MAX(cust_ly_be.m1404) AS a0_0,
     MAX(turnbe.m1401) AS a0_1,
     MAX(turn_ly.m1402) AS a0_2,
     MAX(cust_ly_be.m1401) AS turnover_vj_ber
    FROM TURNOVER_BER AS turnbe
     FULL JOIN CUSTOMER_BER AS cust_be ON turnbe.client_id = cust_be.client_id AND turnbe.currency_iso_cd = cust_be.currency_iso_cd
         AND turnbe.cy_month = cust_be.cy_month
     FULL JOIN UMSATZ_CUSTOMER_LY_BER AS cust_ly_be ON COALESCE(turnbe.client_id, cust_be.client_id) = cust_ly_be.client_id
         AND COALESCE(turnbe.currency_iso_cd, cust_be.currency_iso_cd) = cust_ly_be.currency_iso_cd AND COALESCE(turnbe
        .cy_month, cust_be.cy_month) = cust_ly_be.cy_month
     FULL JOIN TURNOVER_LY AS turn_ly ON COALESCE(turnbe.client_id, cust_be.client_id, cust_ly_be.client_id) = turn_ly.client_id
         AND COALESCE(turnbe.currency_iso_cd, cust_be.currency_iso_cd, cust_ly_be.currency_iso_cd) = turn_ly.currency_iso_cd
         AND COALESCE(turnbe.cy_month, cust_be.cy_month, cust_ly_be.cy_month) = turn_ly.cy_month
     INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead_2 AS CLIENT_LEAD ON COALESCE(turnbe.client_id, cust_be.client_id,
       cust_ly_be.client_id, turn_ly.client_id) = CLIENT_LEAD.client_id
    GROUP BY dm__operand,
     currency_iso_cd,
     client_id) AS t16);