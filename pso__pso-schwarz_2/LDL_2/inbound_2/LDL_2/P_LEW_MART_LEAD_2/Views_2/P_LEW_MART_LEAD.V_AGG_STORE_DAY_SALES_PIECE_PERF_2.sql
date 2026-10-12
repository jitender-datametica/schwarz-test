create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LEAD.V_AGG_STORE_DAY_SALES_PIECE_PERF_2(
	CLIENT_ID,
	SRC_ORIG_STORE_NR,
	LOC_SID_STORE,
	DWH_CAL_DT,
	CURRENCY_ISO_CD,
	SALES_PIECES,
	SALES_PIECES_TOTAL,
	SALES_PIECES_EXTRAPOL,
	SALES_PIECES_FA,
	SALES_PIECES_FA_TOTAL,
	VAL_RTL_NET,
	VAL_RTL_NET_FA,
	AVG_SALES_PRICE,
	PIECE_RECEIPT,
	CNT_CUSTOMER,
	WORK_TIME_TOTAL_HR,
	PIECE_PERFORMANCE,
	TIME_WORKING_NETTO_FG,
	TRAINING_TIME_HR,
	SALES_PIECES_WO_MULTIPACK_FACTOR,
	SALES_PIECES_TOTAL_WO_MULTIPACK_FACTOR,
	WH_ID,
	MOVE_TO_STORE_ID,
	CY_MONTH,
	OPEN_STORE_FG COMMENT 'Open store flag',
	BEREINIGT_FG COMMENT 'Bereinigt flag',
	BEREINIGT_VJW_FG COMMENT 'Bereinigt VJ same week day flag',
	BEREINIGT_VJM_FG COMMENT 'Bereinigt VJ same calendar_2 day flag',
	BEREINIGT_VVJ_FG COMMENT 'Bereinigt VVJ flag',
	BEREINIGT_VVJW_FG COMMENT 'Bereinigt VVJ same week day flag',
	BEREINIGT_VVJM_FG COMMENT 'Bereinigt VVJ same calendar_2 day flag',
	BEREINIGT_VVVJ_FG COMMENT 'Bereinigt VVVJ flag',
	BEREINIGT_VVVJW_FG COMMENT 'Bereinigt VVVJ same week day flag',
	BEREINIGT_VVVJM_FG COMMENT 'Bereinigt VVVJ same calendar_2 day flag'
) as
SELECT
  sdpp.client_id
, sdpp.src_orig_store_nr
, sdpp.loc_sid_store
, sdpp.dwh_cal_dt
, sdpp.currency_iso_cd
, sdpp.sales_pieces
, sdpp.sales_pieces_total
, sdpp.sales_pieces_extrapol
, sdpp.sales_pieces_fa
, sdpp.sales_pieces_fa_total
, sdpp.val_rtl_net
, sdpp.val_rtl_net_fa
, sdpp.avg_sales_price
, sdpp.piece_receipt
, sdpp.cnt_customer
, sdpp.work_time_total_hr
, CASE WHEN sdpp.work_time_total_hr <> 0 AND sdpp.work_time_total_hr IS NOT NULL
       THEN sdpp.piece_performance 
       ELSE 0 
  END AS piece_performance
, sdpp.time_working_netto_fg
, sdpp.training_time_hr
, sdpp.sales_pieces_wo_multipack_factor
, sdpp.sales_pieces_total_wo_multipack_factor
, osm.wh_id
, osm.move_to_store_id
, cc.cy_month
, CASE WHEN
           (sdpp.dwh_cal_dt BETWEEN store.dat_opening_ovis AND store.dat_closing_ovis - 1)
           OR (sdpp.dwh_cal_dt >= store.dat_opening_ovis AND store.dat_closing_ovis IS NULL)
       THEN 1
       ELSE 0
  END AS open_store_fg
, CASE WHEN  
           ((sdpp.dwh_cal_dt >= store.dat_calc_start_py AND store.move_fg = 1) 
           OR sdpp.dwh_cal_dt BETWEEN store.dat_calc_start_py AND store.dat_calc_end_py)
           OR (sdpp.dwh_cal_dt >= store.dat_calc_start_py AND store.dat_calc_end_py IS NULL)
       THEN 1
       ELSE 0
  END AS bereinigt_fg
, CASE WHEN 
           ((calwkber.cal_dt >=  store.dat_calc_start_py AND store.move_fg = 1)
           OR calwkber.cal_dt BETWEEN store.dat_calc_start_py AND store.dat_calc_end_py)
           OR (calwkber.cal_dt >=  store.dat_calc_start_py
           AND store.dat_calc_end_py IS NULL)
       THEN 1
       ELSE 0
  END AS bereinigt_VJW_fg
, CASE WHEN  
           ((calmthber.cal_dt >= store.dat_calc_start_py AND store.move_fg = 1) 
           OR calmthber.cal_dt BETWEEN store.dat_calc_start_py AND store.dat_calc_end_py)
           OR (calmthber.cal_dt >= store.dat_calc_start_py AND store.dat_calc_end_py IS NULL) 
       THEN 1
       ELSE 0
  END AS bereinigt_VJM_fg

  , CASE WHEN  
           ((sdpp.dwh_cal_dt >= store.dat_calc_start_ppy AND store.move_fg = 1) 
           OR sdpp.dwh_cal_dt BETWEEN store.dat_calc_start_ppy AND store.dat_calc_end_ppy)
           OR (sdpp.dwh_cal_dt >= store.dat_calc_start_ppy AND store.dat_calc_end_ppy IS NULL)
       THEN 1
       ELSE 0
  END AS bereinigt_VVJ_fg
, CASE WHEN 
           ((calwkber_VVJ.cal_dt >=  store.dat_calc_start_ppy AND store.move_fg = 1)
           OR calwkber_VVJ.cal_dt BETWEEN store.dat_calc_start_ppy AND store.dat_calc_end_ppy)
           OR (calwkber_VVJ.cal_dt >=  store.dat_calc_start_ppy
           AND store.dat_calc_end_ppy IS NULL)
       THEN 1
       ELSE 0
  END AS bereinigt_VVJW_fg
, CASE WHEN  
           ((calmthber_VVJ.cal_dt >= store.dat_calc_start_ppy AND store.move_fg = 1) 
           OR calmthber_VVJ.cal_dt BETWEEN store.dat_calc_start_ppy AND store.dat_calc_end_ppy)
           OR (calmthber_VVJ.cal_dt >= store.dat_calc_start_ppy AND store.dat_calc_end_ppy IS NULL) 
       THEN 1
       ELSE 0
  END AS bereinigt_VVJM_fg

  , CASE WHEN  
           ((sdpp.dwh_cal_dt >= store.dat_calc_start_pppy AND store.move_fg = 1) 
           OR sdpp.dwh_cal_dt BETWEEN store.dat_calc_start_pppy AND store.dat_calc_end_pppy)
           OR (sdpp.dwh_cal_dt >= store.dat_calc_start_pppy AND store.dat_calc_end_pppy IS NULL)
       THEN 1
       ELSE 0
  END AS bereinigt_VVVJ_fg
, CASE WHEN 
           ((calwkber_VVVJ.cal_dt >=  store.dat_calc_start_pppy AND store.move_fg = 1)
           OR calwkber_VVVJ.cal_dt BETWEEN store.dat_calc_start_pppy AND store.dat_calc_end_pppy)
           OR (calwkber_VVVJ.cal_dt >=  store.dat_calc_start_pppy
           AND store.dat_calc_end_pppy IS NULL)
       THEN 1
       ELSE 0
  END AS bereinigt_VVVJW_fg
, CASE WHEN  
           ((calmthber_VVVJ.cal_dt >= store.dat_calc_start_pppy AND store.move_fg = 1) 
           OR calmthber_VVVJ.cal_dt BETWEEN store.dat_calc_start_pppy AND store.dat_calc_end_pppy)
           OR (calmthber_VVVJ.cal_dt >= store.dat_calc_start_pppy AND store.dat_calc_end_pppy IS NULL) 
       THEN 1
       ELSE 0
  END AS bereinigt_VVVJM_fg
FROM P_LEW_BIL_AC.V_AGG_STORE_DAY_PIECE_PERF_2 AS sdpp
INNER JOIN P_LEW_MART_LEAD_AC.V_ORG_STORE_MERGE_2 AS osm
ON sdpp.client_id = osm.client_id
AND sdpp.loc_sid_store = osm.store_id
LEFT OUTER JOIN P_LEW_CORE_AC.V_CAL_CALENDARDAY_2 AS cc
ON sdpp.dwh_cal_dt = cc.cal_dt

LEFT OUTER JOIN P_LEW_BIL_AC.v_cal_day_py_swday_business_year_adjusted_ber_2 AS calwkber
ON calwkber.prev_cy_dat_calendar_swd_ber = sdpp.dwh_cal_dt

LEFT OUTER JOIN P_LEW_BIL_AC.v_cal_day_py_business_year_adjusted_2 AS calmthber
ON calmthber.incl_cal_dt = sdpp.dwh_cal_dt
AND calmthber.bus_year_diff = 1

LEFT OUTER JOIN P_LEW_BIL_AC.v_cal_day_py_swday_business_year_adjusted_ber_2 AS calwkber_VVJ
ON calwkber_VVJ.prev_prev_cy_dat_calendar_swd_ber = sdpp.dwh_cal_dt

LEFT OUTER JOIN P_LEW_BIL_AC.v_cal_day_py_business_year_adjusted_2 AS calmthber_VVJ
ON calmthber_VVJ.incl_cal_dt = sdpp.dwh_cal_dt
AND calmthber_VVJ.bus_year_diff = 2

LEFT OUTER JOIN P_LEW_BIL_AC.v_cal_day_py_swday_business_year_adjusted_ber_2 AS calwkber_VVVJ
ON calwkber_VVVJ.prev_prev_prev_cy_dat_calendar_swd_ber = sdpp.dwh_cal_dt

LEFT OUTER JOIN P_LEW_BIL_AC.v_cal_day_py_business_year_adjusted_2 AS calmthber_VVVJ
ON calmthber_VVVJ.incl_cal_dt = sdpp.dwh_cal_dt
AND calmthber_VVVJ.bus_year_diff = 3

LEFT OUTER JOIN p_lew_mart_msi_ac.v_org_store_pre_2 AS store
ON  sdpp.client_id = store.client_id
AND sdpp.loc_sid_store = store.store_id

WHERE osm.aspect_id = 2
;
