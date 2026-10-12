/*
#-----------------------------------------------------------------------------
# Description:
# This view provides SortimentModularitat context into V_AGG_STORE_DAY_SALES_PIECE_PERF_ITEM_1 view.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     11.06.2025		Malgorzata Cyganska             Initial Version.

#
#-----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_lead.V_AGG_STORE_DAY_SALES_PIECE_PERF_ITEM_SOMO_1(
	CLIENT_ID,
	SRC_ORIG_STORE_NR,
	LOC_SID_STORE,
	DWH_CAL_DT,
	CURRENCY_ISO_CD,
	ITEM_ID,
	ORIG_ITEM_NR,
	CONTAINER_ID,
	CONTAINER_HIST_ID,
	SALES_PIECES,
	SALES_PIECES_TOTAL,
	SALES_PIECES_FA,
	SALES_PIECES_FA_TOTAL,
	VAL_RTL_NET_EJR,
	AVERAGE_PRICE,
	PIECE_RECEIPT,
	CNT_CUSTOMER,
	TIME_WORKING_NETTO_FG,
	WH_ID,
	MOVE_TO_STORE_ID,
	CY_MONTH,
	OPEN_STORE_FG COMMENT 'Open store flag',
	BEREINIGT_FG COMMENT 'Bereinigt flag',
	BEREINIGT_VJW_FG COMMENT 'Bereinigt VJ same week day flag',
	BEREINIGT_VJM_FG COMMENT 'Bereinigt VJ same calendar_1 day flag',
	BEREINIGT_VVJ_FG COMMENT 'Bereinigt VVJ flag',
	BEREINIGT_VVJW_FG COMMENT 'Bereinigt VVJ same week day flag',
	BEREINIGT_VVJM_FG COMMENT 'Bereinigt VVJ same calendar_1 day flag',
	BEREINIGT_VVVJ_FG COMMENT 'Bereinigt VVVJ flag',
	BEREINIGT_VVVJW_FG COMMENT 'Bereinigt VVVJ same week day flag',
	BEREINIGT_VVVJM_FG COMMENT 'Bereinigt VVVJ same calendar_1 day flag'
) AS
SELECT
  sdpp.client_id
, sdpp.src_orig_store_nr
, sdpp.loc_sid_store
, sdpp.dwh_cal_dt
, sdpp.currency_iso_cd
, ITmp.item_sid_map  AS item_id
, i.orig_item_nr AS orig_item_nr
, sm.container_id  AS container_id
, sm_hist.container_id AS container_hist_id
, sdpp.sales_pieces
, sdpp.sales_pieces_total
, sdpp.sales_pieces_fa
, sdpp.sales_pieces_fa_total
, sdpp.val_rtl_net_ejr
, sdpp.average_price
, sdpp.piece_receipt
, sdpp.cnt_customer
, sdpp.time_working_netto_fg
, o.wh_id
, o.move_to_store_id
, c.cy_month

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

FROM P_LEW_BIL_AC.V_AGG_STORE_DAY_PIECE_PERF_ITEM_1 AS sdpp

INNER JOIN p_lew_core_ac.v_item_map_key_1 AS ITmp
 ON  ITmp.client_id = sdpp.client_id
 AND ITmp.item_sid  = sdpp.item_sid

INNER JOIN P_LEW_MART_LEAD_AC.V_ITM_ITEM_1 AS i 
 ON  ITmp.client_id = i.client_id
 AND ITmp.item_sid_map = i.item_id

INNER JOIN P_LEW_MART_LEAD_AC.V_ORG_STORE_MERGE_1 AS o
 ON sdpp.client_id = o.client_id
 AND sdpp.loc_sid_store = o.store_id
 
INNER JOIN P_LEW_CORE_AC.V_CAL_CALENDARDAY_1 AS c
 ON sdpp.dwh_cal_dt = c.cal_dt
 
LEFT OUTER JOIN P_LEW_BIL_AC.v_cal_day_py_swday_business_year_adjusted_ber_1 AS calwkber
ON calwkber.prev_cy_dat_calendar_swd_ber = sdpp.dwh_cal_dt

LEFT OUTER JOIN P_LEW_BIL_AC.v_cal_day_py_business_year_adjusted_1 AS calmthber
ON calmthber.incl_cal_dt = sdpp.dwh_cal_dt
AND calmthber.bus_year_diff = 1

LEFT OUTER JOIN P_LEW_BIL_AC.v_cal_day_py_swday_business_year_adjusted_ber_1 AS calwkber_VVJ
ON calwkber_VVJ.prev_prev_cy_dat_calendar_swd_ber = sdpp.dwh_cal_dt

LEFT OUTER JOIN P_LEW_BIL_AC.v_cal_day_py_business_year_adjusted_1 AS calmthber_VVJ
ON calmthber_VVJ.incl_cal_dt = sdpp.dwh_cal_dt
AND calmthber_VVJ.bus_year_diff = 2

LEFT OUTER JOIN P_LEW_BIL_AC.v_cal_day_py_swday_business_year_adjusted_ber_1 AS calwkber_VVVJ
ON calwkber_VVVJ.prev_prev_prev_cy_dat_calendar_swd_ber = sdpp.dwh_cal_dt

LEFT OUTER JOIN P_LEW_BIL_AC.v_cal_day_py_business_year_adjusted_1 AS calmthber_VVVJ
ON calmthber_VVVJ.incl_cal_dt = sdpp.dwh_cal_dt
AND calmthber_VVVJ.bus_year_diff = 3

LEFT OUTER JOIN p_lew_mart_msi_ac.v_org_store_pre_1 AS store
ON  sdpp.client_id = store.client_id
AND sdpp.loc_sid_store = store.store_id

LEFT OUTER JOIN p_lew_BIL_ac.v_sm_map_item_container_str_1 sm_1
ON sdpp.client_id = sm.client_id
AND sdpp.item_sid = sm.item_sid
AND o.move_to_store_id = sm.move_to_store_id
AND CURRENT_DATE BETWEEN sm.dat_rec_start AND sm.dat_rec_end

LEFT OUTER JOIN p_lew_bil_ac.v_sm_map_item_container_str_1 sm_hist
ON sdpp.client_id = sm_hist.client_id
AND sdpp.item_sid = sm_hist.item_sid
AND o.move_to_store_id = sm_hist.move_to_store_id
AND sdpp.dwh_cal_dt BETWEEN sm_hist.dat_rec_start AND sm_hist.dat_rec_end

WHERE o.aspect_id = 2
;