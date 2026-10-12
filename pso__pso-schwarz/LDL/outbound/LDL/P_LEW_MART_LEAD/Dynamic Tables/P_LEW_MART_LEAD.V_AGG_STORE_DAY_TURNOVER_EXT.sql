
CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_lead.v_agg_store_day_turnover_ext
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT SRC.client_id,
 SRC.src_orig_store_nr AS orig_store_nr,
 SRC.dat_formdate,
 SRC.currency_iso_cd,
 SRC.loc_sid_store AS store_id,
 SRC.cy_month,
 SRC.cnt_customer,
 SRC.cnt_customer_extrapol,
 SRC.val_rtl,
 SRC.val_rtl_net,
 SRC.val_rtl_extrapol,
 SRC.val_rtl_net_extrapol,
 SRC.val_rtl_kpges,
 SRC.val_rtl_net_kpges,
 SRC.val_rtl_wawi,
 SRC.val_rtl_net_wawi,
 SRC.val_rtl_txj,
 SRC.val_rtl_net_txj,
 SRC.val_rtl_ejr,
 SRC.val_rtl_net_ejr,
  CASE
  WHEN SRC.dat_formdate BETWEEN STORE.dat_opening_ovis AND (DATE_SUB(STORE.dat_closing_ovis, INTERVAL 1 DAY)) OR SRC.dat_formdate
      >= STORE.dat_opening_ovis AND STORE.dat_closing_ovis IS NULL
  THEN 1
  ELSE 0
  END AS open_store_fg,
  CASE
  WHEN SRC.dat_formdate >= STORE.dat_calc_start_py AND STORE.move_fg = 1 OR SRC.dat_formdate BETWEEN STORE.dat_calc_start_py
     AND STORE.dat_calc_end_py OR SRC.dat_formdate >= STORE.dat_calc_start_py AND STORE.dat_calc_end_py IS NULL
  THEN 1
  ELSE 0
  END AS bereinigt_fg,
  CASE
  WHEN CALWKBER.cal_dt >= STORE.dat_calc_start_py AND STORE.move_fg = 1 OR CALWKBER.cal_dt BETWEEN STORE.dat_calc_start_py
     AND STORE.dat_calc_end_py OR CALWKBER.cal_dt >= STORE.dat_calc_start_py AND STORE.dat_calc_end_py IS NULL
  THEN 1
  ELSE 0
  END AS bereinigt_vjw_fg,
  CASE
  WHEN CALMTHBER.cal_dt >= STORE.dat_calc_start_py AND STORE.move_fg = 1 OR CALMTHBER.cal_dt BETWEEN STORE.dat_calc_start_py
     AND STORE.dat_calc_end_py OR CALMTHBER.cal_dt >= STORE.dat_calc_start_py AND STORE.dat_calc_end_py IS NULL
  THEN 1
  ELSE 0
  END AS bereinigt_vjm_fg,
  CASE
  WHEN SRC.dat_formdate >= STORE.dat_calc_start_ppy AND STORE.move_fg = 1 OR SRC.dat_formdate BETWEEN STORE.dat_calc_start_ppy
     AND STORE.dat_calc_end_ppy OR SRC.dat_formdate >= STORE.dat_calc_start_ppy AND STORE.dat_calc_end_ppy IS NULL
  THEN 1
  ELSE 0
  END AS bereinigt_vvj_fg,
  CASE
  WHEN CALWKBER_VVJ.cal_dt >= STORE.dat_calc_start_ppy AND STORE.move_fg = 1 OR CALWKBER_VVJ.cal_dt BETWEEN STORE.dat_calc_start_ppy
     AND STORE.dat_calc_end_ppy OR CALWKBER_VVJ.cal_dt >= STORE.dat_calc_start_ppy AND STORE.dat_calc_end_ppy IS NULL
  THEN 1
  ELSE 0
  END AS bereinigt_vvjw_fg,
  CASE
  WHEN CALMTHBER_VVJ.cal_dt >= STORE.dat_calc_start_ppy AND STORE.move_fg = 1 OR CALMTHBER_VVJ.cal_dt BETWEEN STORE.dat_calc_start_ppy
     AND STORE.dat_calc_end_ppy OR CALMTHBER_VVJ.cal_dt >= STORE.dat_calc_start_ppy AND STORE.dat_calc_end_ppy IS NULL
  THEN 1
  ELSE 0
  END AS bereinigt_vvjm_fg,
  CASE
  WHEN SRC.dat_formdate >= STORE.dat_calc_start_pppy AND STORE.move_fg = 1 OR SRC.dat_formdate BETWEEN STORE.dat_calc_start_pppy
     AND STORE.dat_calc_end_pppy OR SRC.dat_formdate >= STORE.dat_calc_start_pppy AND STORE.dat_calc_end_pppy IS NULL
  THEN 1
  ELSE 0
  END AS bereinigt_vvvj_fg,
  CASE
  WHEN CALWKBER_VVVJ.cal_dt >= STORE.dat_calc_start_pppy AND STORE.move_fg = 1 OR CALWKBER_VVVJ.cal_dt BETWEEN STORE.dat_calc_start_pppy
     AND STORE.dat_calc_end_pppy OR CALWKBER_VVVJ.cal_dt >= STORE.dat_calc_start_pppy AND STORE.dat_calc_end_pppy
    IS NULL
  THEN 1
  ELSE 0
  END AS bereinigt_vvvjw_fg,
  CASE
  WHEN CALMTHBER_VVVJ.cal_dt >= STORE.dat_calc_start_pppy AND STORE.move_fg = 1 OR CALMTHBER_VVVJ.cal_dt BETWEEN STORE.dat_calc_start_pppy
     AND STORE.dat_calc_end_pppy OR CALMTHBER_VVVJ.cal_dt >= STORE.dat_calc_start_pppy AND STORE.dat_calc_end_pppy
    IS NULL
  THEN 1
  ELSE 0
  END AS bereinigt_vvvjm_fg
FROM ldl_p_lew_bil_ac.v_agg_store_day_turnover_ext AS SRC
 LEFT JOIN ldl_p_lew_bil_ac.v_cal_day_py_swday_business_year_adjusted_ber AS CALWKBER ON SRC.dat_formdate = CALWKBER.prev_cy_dat_calendar_swd_ber
  
 LEFT JOIN ldl_p_lew_bil_ac.v_cal_day_py_business_year_adjusted AS CALMTHBER ON SRC.dat_formdate = CALMTHBER.incl_cal_dt
    AND CALMTHBER.bus_year_diff = 1
 LEFT JOIN ldl_p_lew_bil_ac.v_cal_day_py_swday_business_year_adjusted_ber AS CALWKBER_VVJ ON SRC.dat_formdate =
  CALWKBER_VVJ.prev_prev_cy_dat_calendar_swd_ber
 LEFT JOIN ldl_p_lew_bil_ac.v_cal_day_py_business_year_adjusted AS CALMTHBER_VVJ ON SRC.dat_formdate = CALMTHBER_VVJ.incl_cal_dt
    AND CALMTHBER_VVJ.bus_year_diff = 2
 LEFT JOIN ldl_p_lew_bil_ac.v_cal_day_py_swday_business_year_adjusted_ber AS CALWKBER_VVVJ ON SRC.dat_formdate =
  CALWKBER_VVVJ.prev_prev_prev_cy_dat_calendar_swd_ber
 LEFT JOIN ldl_p_lew_bil_ac.v_cal_day_py_business_year_adjusted AS CALMTHBER_VVVJ ON SRC.dat_formdate = CALMTHBER_VVVJ.incl_cal_dt
    AND CALMTHBER_VVVJ.bus_year_diff = 3
 LEFT JOIN ldl_p_lew_mart_msi_ac.v_org_store_pre AS STORE ON SRC.client_id = STORE.client_id AND SRC.loc_sid_store =
   STORE.store_id;


