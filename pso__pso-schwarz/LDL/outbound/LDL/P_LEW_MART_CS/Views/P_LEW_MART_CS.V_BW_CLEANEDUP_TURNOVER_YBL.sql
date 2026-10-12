/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_CLEANEDUP_TURNOVER_YBL
#----------------------------------------------------------------------------
# History:
#  1.0  12.05.2023    Ulrich Ross               Init, User Story 476747
#----------------------------------------------------------------------------
*/


-- umsatz vvj bereinigt
 -- umsatz lj bereinigt (auf basis des vvj)

CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_bw_cleanedup_turnover_ybl AS WITH TURNOVER_CY AS (SELECT CURR.currency_iso_cd
   ,
   CAL.cy_month,
   CURR.client_id,
   SUM(TURNOVER.val_rtl_net) AS m1402
  FROM ldl_p_lew_mart_msi_ac.v_agg_store_day_turnover_ext AS TURNOVER
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_currency AS CURR ON TURNOVER.client_id = CURR.client_id AND TURNOVER.currency_iso_cd
      = CURR.currency_iso_cd
   INNER JOIN ldl_p_lew_mart_msi_ac.v_org_store_merge AS STORE ON TURNOVER.client_id = STORE.client_id AND TURNOVER.store_id
      = STORE.store_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday AS CAL ON TURNOVER.dat_formdate = CAL.dat_calendar
   INNER JOIN ldl_p_lew_mart_msi_ac.v_org_store_pre AS STORE_PRE ON TURNOVER.client_id = STORE_PRE.client_id AND
     TURNOVER.store_id = STORE_PRE.store_id
  WHERE (TURNOVER.dat_formdate >= STORE.dat_calc_start_ppy AND STORE.move_fg = 1 OR TURNOVER.dat_formdate BETWEEN STORE
       .dat_calc_start_ppy AND STORE.dat_calc_end_py OR TURNOVER.dat_formdate >= STORE.dat_calc_start_ppy AND STORE_PRE
      .dat_calc_end_ppy IS NULL)
   AND STORE.aspect_id = 1
   AND CAL.cy_month BETWEEN ROUND(CAST(FORMAT_DATE('%Y%m', DATE_ADD(CURRENT_DATE, INTERVAL - 6 YEAR)) AS BIGNUMERIC), 0
     ) AND (ROUND(CAST(FORMAT_DATE('%Y%m', CURRENT_DATE) AS BIGNUMERIC), 0))
   AND STORE.dashboard_relevant_fg = 1
  GROUP BY CURR.currency_iso_cd,
   CAL.cy_month,
   CURR.client_id), TURNOVER_YBL AS (SELECT CURR0.currency_iso_cd,
   CAL_MONTH_BER.cy_month,
   CURR0.client_id,
   SUM(TURNOVER0.val_rtl_net) AS m1402
  FROM ldl_p_lew_mart_msi_ac.v_agg_store_day_turnover_ext AS TURNOVER0
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_month_ber AS CAL_MONTH_BER ON TURNOVER0.dat_formdate = CAL_MONTH_BER.dat_calendar_ppy
    
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_currency AS CURR0 ON TURNOVER0.client_id = CURR0.client_id AND TURNOVER0.currency_iso_cd
      = CURR0.currency_iso_cd
   INNER JOIN ldl_p_lew_mart_msi_ac.v_org_store_merge AS STORE0 ON TURNOVER0.client_id = STORE0.client_id AND TURNOVER0
     .store_id = STORE0.store_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday AS CAL0 ON CAL_MONTH_BER.dat_calendar_amd = CAL0.dat_calendar
   INNER JOIN ldl_p_lew_mart_msi_ac.v_org_store_pre AS STORE_PRE0 ON TURNOVER0.client_id = STORE_PRE0.client_id AND
     TURNOVER0.store_id = STORE_PRE0.store_id
  WHERE (CAL_MONTH_BER.dat_calendar_amd >= STORE0.dat_calc_start_ppy AND STORE0.move_fg = 1 OR CAL_MONTH_BER.dat_calendar_amd
       BETWEEN STORE0.dat_calc_start_ppy AND STORE0.dat_calc_end_py OR CAL_MONTH_BER.dat_calendar_amd >= STORE0.dat_calc_start_ppy
        AND STORE_PRE0.dat_calc_end_ppy IS NULL)
   AND CAL0.cy_day_sequence <= 0
   AND STORE0.aspect_id = 1
   AND CAL_MONTH_BER.cy_month BETWEEN ROUND(CAST(FORMAT_DATE('%Y%m', DATE_ADD(CURRENT_DATE, INTERVAL - 6 YEAR)) AS BIGNUMERIC)
     , 0) AND (ROUND(CAST(FORMAT_DATE('%Y%m', CURRENT_DATE) AS BIGNUMERIC), 0))
   AND STORE0.dashboard_relevant_fg = 1
  GROUP BY CURR0.currency_iso_cd,
   CAL_MONTH_BER.cy_month,
   CURR0.client_id) (-- umsatz lj bereinigt (auf basis des vvj)
 -- umsatz vvj bereinigt
 SELECT TRIM(SUBSTR(CAST(t8.dm__operand AS STRING)
     , 1, 39)) AS calmonth,
   t8.client_id,
   t8.client_desc,
   t8.currency_iso_cd,
   t8.country_iso_cd,
   t8.turnover_lj_ber,
   t8.turnover_vvj_ber
  FROM (SELECT COALESCE(turnover_cy.cy_month, turnover_ybl.cy_month) AS dm__operand,
     COALESCE(turnover_cy.currency_iso_cd, turnover_ybl.currency_iso_cd) AS currency_iso_cd,
     COALESCE(turnover_cy.client_id, turnover_ybl.client_id) AS client_id,
     MAX(CLIENT.country_desc) AS client_desc,
     MAX(CLIENT.country_iso_cd) AS country_iso_cd,
     MAX(turnover_cy.m1402) AS turnover_lj_ber,
     MAX(turnover_ybl.m1402) AS turnover_vvj_ber
    FROM TURNOVER_CY AS turnover_cy
     FULL JOIN TURNOVER_YBL AS turnover_ybl ON turnover_cy.client_id = turnover_ybl.client_id AND turnover_cy.currency_iso_cd
         = turnover_ybl.currency_iso_cd AND turnover_cy.cy_month = turnover_ybl.cy_month
     INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead AS CLIENT ON COALESCE(turnover_cy.client_id, turnover_ybl.client_id
       ) = CLIENT.client_id
    GROUP BY dm__operand,
     currency_iso_cd,
     client_id) AS t8);