CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_store_day_ber_ppym AS
-- aktueller Kalendertag
 -- dazugehöriger Kalendertag des Vormonats
 -- dazugehörige Kalendertag im Vorvorjahr
 SELECT
 EJR_TXJ.client_id,
 EJR_TXJ.loc_sid AS store_id,
 CUR.curr_cd_from AS currency_iso_cd,
 cal_month_ber.dat_calendar_amd AS dat_formdate,
 CAST(EJR_TXJ.sales_gross_val / CUR.exchange_rate AS NUMERIC) AS val_retail_asis_ber,
  EJR_TXJ.sales_net_val / CUR.exchange_rate AS val_retail_net_asis_ber,
 EJR_TXJ.cnt_customer AS cnt_customer_asis_ber
FROM ldl_p_lew_bil_ac.v_agg_pos_txj_wawi_store_day AS EJR_TXJ
 INNER JOIN ldl_p_lew_mart_msi.v_report_fixed_exchange_rate AS CUR ON EJR_TXJ.client_id = CUR.client_id AND CURRENT_DATE
   BETWEEN CUR.active_from_dt AND CUR.active_to_dt
 INNER JOIN (SELECT DD.cal_dt AS dat_calendar_amd,
   PD.cal_dt AS dat_calendar_pmd,
    CASE
    WHEN PPY.cal_dt IS NULL AND PD.cal_dt IS NULL
    THEN IF(DD.cal_dt = LAST_DAY(DD.cal_dt), LAST_DAY(DATE_ADD(DD.cal_dt, INTERVAL - 24 MONTH)), DATE_ADD(DD.cal_dt,
      INTERVAL - 24 MONTH))
    ELSE PPY.cal_dt
    END AS dat_calendar_ppy
  FROM ldl_p_lew_core_ac.v_cal_month AS MM
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS DD ON MM.cy_month = DD.cy_month
   LEFT JOIN ldl_p_lew_core_ac.v_cal_calendarday AS PD ON MM.cy_month_prev_1m = PD.cy_month AND DD.cal_dt = IF(PD.cal_dt
        = LAST_DAY(PD.cal_dt), LAST_DAY(DATE_ADD(PD.cal_dt, INTERVAL 1 MONTH)), DATE_ADD(PD.cal_dt, INTERVAL 1 MONTH))
   LEFT JOIN ldl_p_lew_core_ac.v_cal_calendarday AS PPY ON MM.cy_month = PPY.cy_month + 200 AND DD.cal_dt = IF(PPY.cal_dt
         = LAST_DAY(PPY.cal_dt), LAST_DAY(DATE_ADD(PPY.cal_dt, INTERVAL 24 MONTH)), DATE_ADD(PPY.cal_dt, INTERVAL 24
        MONTH)) AND PD.cal_dt = IF(PPY.cal_dt = LAST_DAY(PPY.cal_dt), LAST_DAY(DATE_ADD(PPY.cal_dt, INTERVAL 23 MONTH))
      , DATE_ADD(PPY.cal_dt, INTERVAL 23 MONTH))
  WHERE DD.cal_dt >= DATE '2005-01-01') AS cal_month_ber ON EJR_TXJ.dwh_cal_dt = cal_month_ber.dat_calendar_ppy
 INNER JOIN ldl_p_lew_core_ac.v_wawi_org_all_store_reloc_act AS OASR ON EJR_TXJ.client_id = OASR.client_id AND EJR_TXJ.loc_sid
    = OASR.st_loc_sid
 INNER JOIN ldl_p_lew_core_ac.v_wawi_org_store_act AS OS ON EJR_TXJ.client_id = OS.client_id AND EJR_TXJ.loc_sid = OS.st_loc_sid
   
WHERE (cal_month_ber.dat_calendar_amd BETWEEN OS.dat_calc_start_ppy AND (IF(OS.dat_calc_end_py = LAST_DAY(OS.dat_calc_end_py
         ), LAST_DAY(DATE_ADD(OS.dat_calc_end_py, INTERVAL 12 MONTH)), DATE_ADD(OS.dat_calc_end_py, INTERVAL 12 MONTH))
      ) OR cal_month_ber.dat_calendar_amd >= OS.dat_calc_start_ppy AND OASR.move_fg = 1 OR cal_month_ber.dat_calendar_amd
      >= OS.dat_calc_start_ppy AND OS.dat_calc_end_py IS NULL)
 AND OS.test_store_fg = 0
 AND CURRENT_DATE >= OS.dat_opening;