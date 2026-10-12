CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_sfo_ejr_day_join_1 AS
SELECT ejr.client_id,
 ejr.store_id,
 ejr.dat_calendar,
 ejr.currency_iso_cd,
 sfo.qty_total_sfo_asis,
 sfo.qty_t_sfo_wrtoff_zero_asis,
 sfo.val_rtl_rl_sfo_asis,
 sfo.val_rtl_rl_net_sfo_asis,
 sfo.val_wrtoff_zero_asis,
 sfo.val_wrtoff_zero_net_asis,
 ejr.val_retail_asis,
 ejr.val_retail_net_asis,
 ejr.cnt_customer_asis,
 ejr.val_retail_asis_py_sw,
 ejr.val_retail_net_asis_py_sw,
 ejr.cnt_customer_asis_py_sw,
 ejr.val_retail_asis_py_sd,
 ejr.val_retail_net_asis_py_sd,
 ejr.cnt_customer_asis_py_sd,
 ejr.val_retail_asis_adj,
 ejr.val_retail_net_asis_adj,
 ejr.cnt_customer_asis_adj,
 ejr.cnt_store_open_rev
FROM (SELECT SFO.client_id,
   SFO.st_loc_sid AS store_id,
   SFO.dat_formdate,
   CRY.currency_iso_cd AS currency_iso_cd_asis,
   SUM(SFO.qty_total_sfo) AS qty_total_sfo_asis,
   SUM(SFO.qty_total_sfo_wrtoff_zero) AS qty_t_sfo_wrtoff_zero_asis,
   SUM(SFO.val_rtl_rl_sfo / CRY.rate_currency_exchange) AS val_rtl_rl_sfo_asis,
   SUM(SFO.val_wrtoff_zero / CRY.rate_currency_exchange) AS val_wrtoff_zero_asis,
   SUM(SFO.val_rtl_rl_net_sfo / CRY.rate_currency_exchange) AS val_rtl_rl_net_sfo_asis,
   SUM(SFO.val_wrtoff_zero_net / CRY.rate_currency_exchange) AS val_wrtoff_zero_net_asis
  FROM ldl_p_lew_core_ac.v_wawi_agg_store_day_sfo_1 AS SFO
   INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS CRY ON SFO.client_id = CRY.client_id AND CURRENT_DATE
     BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
   INNER JOIN (SELECT CALDAY.dat_calendar,
     CALDAY.cy_week
    FROM ldl_p_lew_mart_msi.v_cal_calendarday_1 AS CALDAY
     INNER JOIN ldl_p_lew_mart_msi.v_cal_busyear_1 AS BYR ON CALDAY.byr = BYR.byr
    WHERE BYR.cy_by_sequence BETWEEN - 3 AND 0) AS a13 ON SFO.dat_formdate = a13.dat_calendar AND SFO.sfotype_id IN (137
      , 147)
  GROUP BY SFO.client_id,
   store_id,
   SFO.dat_formdate,
   currency_iso_cd_asis) AS sfo
 RIGHT JOIN (SELECT A12.client_id,
   A12.store_id,
   a13.dat_calendar,
   CRY0.currency_iso_cd,
    UMS.sales_gross_val / CRY0.rate_currency_exchange AS val_retail_asis,
   UMS.cnt_customer AS cnt_customer_asis,
   CAL.prev_cy_dat_calendar_samewday,
   CAL.prev_cy_dat_calendar,
    CASE
    WHEN a13.dat_calendar <= COALESCE(CAL.prev_cy_dat_calendar_samewday, COALESCE(DATE_SUB(CAL.dat_calendar, INTERVAL
         364 DAY), DATE '9999-12-31')) OR A14.move_fg = 1
    THEN UMS.sales_gross_val / CRY0.rate_currency_exchange
    ELSE NULL
    END AS val_retail_asis_py_sw,
    CASE
    WHEN a13.dat_calendar <= COALESCE(CAL.prev_cy_dat_calendar_samewday, COALESCE(DATE_SUB(CAL.dat_calendar, INTERVAL
         364 DAY), DATE '9999-12-31')) OR A14.move_fg = 1
    THEN UMS.cnt_customer
    ELSE NULL
    END AS cnt_customer_asis_py_sw,
    CASE
    WHEN a13.dat_calendar <= COALESCE(CAL.prev_cy_dat_calendar, COALESCE(IF(CAL.dat_calendar = LAST_DAY(CAL.dat_calendar
           ), LAST_DAY(DATE_ADD(CAL.dat_calendar, INTERVAL - 12 MONTH)), DATE_ADD(CAL.dat_calendar, INTERVAL - 12 MONTH)
         ), DATE '9999-12-31')) OR A14.move_fg = 1
    THEN UMS.sales_gross_val / CRY0.rate_currency_exchange
    ELSE NULL
    END AS val_retail_asis_py_sd,
    CASE
    WHEN a13.dat_calendar <= COALESCE(CAL.prev_cy_dat_calendar, COALESCE(IF(CAL.dat_calendar = LAST_DAY(CAL.dat_calendar
           ), LAST_DAY(DATE_ADD(CAL.dat_calendar, INTERVAL - 12 MONTH)), DATE_ADD(CAL.dat_calendar, INTERVAL - 12 MONTH)
         ), DATE '9999-12-31')) OR A14.move_fg = 1
    THEN UMS.cnt_customer
    ELSE NULL
    END AS cnt_customer_asis_py_sd,
    CASE
    WHEN a13.dat_calendar <= A12.dat_closing_ovis OR A12.dat_closing_ovis IS NULL
    THEN UMS.sales_gross_val / CRY0.rate_currency_exchange
    ELSE NULL
    END AS val_retail_asis_adj,
    CASE
    WHEN a13.dat_calendar <= A12.dat_closing_ovis OR A12.dat_closing_ovis IS NULL
    THEN UMS.cnt_customer
    ELSE NULL
    END AS cnt_customer_asis_adj,
    CASE
    WHEN (a13.dat_calendar >= A12.dat_opening_ovis AND a13.dat_calendar <= A12.dat_closing_ovis OR a13.dat_calendar >=
         A12.dat_opening_ovis AND A12.dat_closing_ovis IS NULL) AND UMS.sales_gross_val > 0.0
    THEN 1
    ELSE 0
    END AS cnt_store_open_rev,
    UMS.sales_net_val / CRY0.rate_currency_exchange AS val_retail_net_asis,
    CASE
    WHEN a13.dat_calendar <= A12.dat_closing_ovis OR A12.dat_closing_ovis IS NULL
    THEN UMS.sales_net_val / CRY0.rate_currency_exchange
    ELSE NULL
    END AS val_retail_net_asis_adj,
    CASE
    WHEN a13.dat_calendar <= COALESCE(CAL.prev_cy_dat_calendar, COALESCE(IF(CAL.dat_calendar = LAST_DAY(CAL.dat_calendar
           ), LAST_DAY(DATE_ADD(CAL.dat_calendar, INTERVAL - 12 MONTH)), DATE_ADD(CAL.dat_calendar, INTERVAL - 12 MONTH)
         ), DATE '9999-12-31')) OR A14.move_fg = 1
    THEN UMS.sales_net_val / CRY0.rate_currency_exchange
    ELSE NULL
    END AS val_retail_net_asis_py_sd,
    CASE
    WHEN a13.dat_calendar <= COALESCE(CAL.prev_cy_dat_calendar_samewday, COALESCE(DATE_SUB(CAL.dat_calendar, INTERVAL
         364 DAY), DATE '9999-12-31')) OR A14.move_fg = 1
    THEN UMS.sales_net_val / CRY0.rate_currency_exchange
    ELSE NULL
    END AS val_retail_net_asis_py_sw
  FROM ldl_p_lew_mart_msi.v_org_store_1 AS A12
   LEFT JOIN ldl_p_lew_mart_msi.v_cal_calendarday_1 AS CAL ON A12.dat_calc_end_py = CAL.dat_calendar
   INNER JOIN ldl_p_lew_mart_msi.v_org_all_store_reloc_1 AS A14 ON A12.store_id = A14.store_id AND A12.client_id = A14.client_id
     
   INNER JOIN (SELECT CALDAY0.dat_calendar,
     CALDAY0.cy_week
    FROM ldl_p_lew_mart_msi.v_cal_calendarday_1 AS CALDAY0
     INNER JOIN ldl_p_lew_mart_msi.v_cal_busyear_1 AS BYR0 ON CALDAY0.byr = BYR0.byr
    WHERE BYR0.cy_by_sequence BETWEEN - 3 AND 0
     AND CALDAY0.cy_day_sequence <= - 0) AS a13 ON TRUE
   INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS CRY0 ON A12.client_id = CRY0.client_id AND
     CURRENT_DATE BETWEEN CRY0.dat_rec_start AND CRY0.dat_rec_end
   LEFT JOIN ldl_p_lew_bil_ac.v_agg_pos_txj_wawi_store_day_1 AS UMS ON A12.client_id = UMS.client_id AND A12.store_id =
      UMS.loc_sid AND a13.dat_calendar = UMS.dwh_cal_dt) AS ejr ON sfo.client_id = ejr.client_id AND sfo.store_id = ejr
     .store_id AND sfo.dat_formdate = ejr.dat_calendar AND sfo.currency_iso_cd_asis = ejr.currency_iso_cd;
