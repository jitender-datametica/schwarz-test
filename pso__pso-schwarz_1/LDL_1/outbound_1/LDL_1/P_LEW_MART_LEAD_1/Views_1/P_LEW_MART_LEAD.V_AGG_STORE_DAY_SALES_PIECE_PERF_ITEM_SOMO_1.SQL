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


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_store_day_sales_piece_perf_item_somo_1 (client_id, src_orig_store_nr,
loc_sid_store, dwh_cal_dt, currency_iso_cd, item_id, orig_item_nr, container_id, container_hist_id, sales_pieces,
sales_pieces_total, sales_pieces_fa, sales_pieces_fa_total, val_rtl_net_ejr, average_price, piece_receipt, cnt_customer
, time_working_netto_fg, wh_id, move_to_store_id, cy_month, open_store_fg OPTIONS(description='Open store flag'),
bereinigt_fg OPTIONS(description='Bereinigt flag'), bereinigt_vjw_fg
OPTIONS(description='Bereinigt VJ same week day flag'), bereinigt_vjm_fg
OPTIONS(description='Bereinigt VJ same calendar_1 day flag'), bereinigt_vvj_fg OPTIONS(description='Bereinigt VVJ flag'),
bereinigt_vvjw_fg OPTIONS(description='Bereinigt VVJ same week day flag'), bereinigt_vvjm_fg
OPTIONS(description='Bereinigt VVJ same calendar_1 day flag'), bereinigt_vvvj_fg
OPTIONS(description='Bereinigt VVVJ flag'), bereinigt_vvvjw_fg OPTIONS(description='Bereinigt VVVJ same week day flag'),
bereinigt_vvvjm_fg OPTIONS(description='Bereinigt VVVJ same calendar_1 day flag')) AS SELECT SDPP.client_id,
 SDPP.src_orig_store_nr,
 SDPP.loc_sid_store,
 SDPP.dwh_cal_dt,
 SDPP.currency_iso_cd,
 ITMP.item_sid_map AS item_id,
 I.orig_item_nr,
 SM.container_id,
 SM_HIST.container_id AS container_hist_id,
 SDPP.sales_pieces,
 SDPP.sales_pieces_total,
 SDPP.sales_pieces_fa,
 SDPP.sales_pieces_fa_total,
 SDPP.val_rtl_net_ejr,
 SDPP.average_price,
 SDPP.piece_receipt,
 SDPP.cnt_customer,
 SDPP.time_working_netto_fg,
 O.wh_id,
 O.move_to_store_id,
 C.cy_month,
  CASE
  WHEN SDPP.dwh_cal_dt BETWEEN STORE.dat_opening_ovis AND (DATE_SUB(STORE.dat_closing_ovis, INTERVAL 1 DAY)) OR SDPP.dwh_cal_dt
      >= STORE.dat_opening_ovis AND STORE.dat_closing_ovis IS NULL
  THEN 1
  ELSE 0
  END AS open_store_fg,
  CASE
  WHEN SDPP.dwh_cal_dt >= STORE.dat_calc_start_py AND STORE.move_fg = 1 OR SDPP.dwh_cal_dt BETWEEN STORE.dat_calc_start_py
     AND STORE.dat_calc_end_py OR SDPP.dwh_cal_dt >= STORE.dat_calc_start_py AND STORE.dat_calc_end_py IS NULL
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
  WHEN SDPP.dwh_cal_dt >= STORE.dat_calc_start_ppy AND STORE.move_fg = 1 OR SDPP.dwh_cal_dt BETWEEN STORE.dat_calc_start_ppy
     AND STORE.dat_calc_end_ppy OR SDPP.dwh_cal_dt >= STORE.dat_calc_start_ppy AND STORE.dat_calc_end_ppy IS NULL
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
  WHEN SDPP.dwh_cal_dt >= STORE.dat_calc_start_pppy AND STORE.move_fg = 1 OR SDPP.dwh_cal_dt BETWEEN STORE.dat_calc_start_pppy
     AND STORE.dat_calc_end_pppy OR SDPP.dwh_cal_dt >= STORE.dat_calc_start_pppy AND STORE.dat_calc_end_pppy IS NULL
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
FROM ldl_p_lew_bil_ac.v_agg_store_day_piece_perf_item_1 AS SDPP
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_1 AS ITMP ON SDPP.client_id = ITMP.client_id AND SDPP.item_sid = ITMP.item_sid
   
 INNER JOIN ldl_p_lew_mart_lead_ac.v_itm_item_1 AS I ON ITMP.client_id = I.client_id AND ITMP.item_sid_map = I.item_id
 INNER JOIN ldl_p_lew_mart_lead_ac.v_org_store_merge_1 AS O ON SDPP.client_id = O.client_id AND SDPP.loc_sid_store = O.store_id
   
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS C ON SDPP.dwh_cal_dt = C.cal_dt
 LEFT JOIN ldl_p_lew_bil_ac.v_cal_day_py_swday_business_year_adjusted_ber_1 AS CALWKBER ON SDPP.dwh_cal_dt = CALWKBER.prev_cy_dat_calendar_swd_ber
  
 LEFT JOIN ldl_p_lew_bil_ac.v_cal_day_py_business_year_adjusted_1 AS CALMTHBER ON SDPP.dwh_cal_dt = CALMTHBER.incl_cal_dt
  AND CALMTHBER.bus_year_diff = 1
 LEFT JOIN ldl_p_lew_bil_ac.v_cal_day_py_swday_business_year_adjusted_ber_1 AS CALWKBER_VVJ ON SDPP.dwh_cal_dt =
  CALWKBER_VVJ.prev_prev_cy_dat_calendar_swd_ber
 LEFT JOIN ldl_p_lew_bil_ac.v_cal_day_py_business_year_adjusted_1 AS CALMTHBER_VVJ ON SDPP.dwh_cal_dt = CALMTHBER_VVJ.incl_cal_dt
    AND CALMTHBER_VVJ.bus_year_diff = 2
 LEFT JOIN ldl_p_lew_bil_ac.v_cal_day_py_swday_business_year_adjusted_ber_1 AS CALWKBER_VVVJ ON SDPP.dwh_cal_dt =
  CALWKBER_VVVJ.prev_prev_prev_cy_dat_calendar_swd_ber
 LEFT JOIN ldl_p_lew_bil_ac.v_cal_day_py_business_year_adjusted_1 AS CALMTHBER_VVVJ ON SDPP.dwh_cal_dt = CALMTHBER_VVVJ.incl_cal_dt
    AND CALMTHBER_VVVJ.bus_year_diff = 3
 LEFT JOIN ldl_p_lew_mart_msi_ac.v_org_store_pre_1 AS STORE ON SDPP.client_id = STORE.client_id AND SDPP.loc_sid_store =
   STORE.store_id
 LEFT JOIN ldl_p_lew_bil_ac.v_sm_map_item_container_str_1 AS SM_1 ON SDPP.client_id = SM.client_id AND SDPP.item_sid = SM.item_sid
      AND O.move_to_store_id = SM.move_to_store_id AND CURRENT_DATE BETWEEN SM.dat_rec_start AND SM.dat_rec_end
 LEFT JOIN ldl_p_lew_bil_ac.v_sm_map_item_container_str_1 AS SM_HIST ON SDPP.client_id = SM_HIST.client_id AND SDPP.item_sid
      = SM_HIST.item_sid AND O.move_to_store_id = SM_HIST.move_to_store_id AND SDPP.dwh_cal_dt BETWEEN SM_HIST.dat_rec_start
   AND SM_HIST.dat_rec_end
WHERE O.aspect_id = 2;