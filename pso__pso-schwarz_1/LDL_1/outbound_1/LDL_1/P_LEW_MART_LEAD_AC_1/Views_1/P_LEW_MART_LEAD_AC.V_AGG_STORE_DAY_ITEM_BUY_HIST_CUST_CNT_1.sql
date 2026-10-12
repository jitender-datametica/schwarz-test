/*
#----------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_AGG_STORE_DAY_ITEM_BUY_HIST_CUST_CNT_1
#----------------------------------------------------------------------------
# History:
# 1.0 2023-01-11  Marcin Malec        Initial Version
#                                     SPEC0148143 - Anz. Kunden | Sortimentsebene
# 1.1 2025-04-03  Bharat Yeddulapalli  Added new column to bring customer count at Store - Day Level as part of AP0257238| SPEC0304265.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_store_day_item_buy_hist_cust_cnt_1 (client_id, loc_sid_store,
src_orig_store_nr, move_to_store_id, dwh_cal_dt, cy_month, busyear, aspect_id, wh_id, buying_list_type_id_hist,
buy_list_hist_cnt_customer, store_day_buy_list_hist_cnt_customer) AS SELECT *
FROM ldl_p_lew_mart_lead.v_agg_store_day_item_buy_hist_cust_cnt_1;