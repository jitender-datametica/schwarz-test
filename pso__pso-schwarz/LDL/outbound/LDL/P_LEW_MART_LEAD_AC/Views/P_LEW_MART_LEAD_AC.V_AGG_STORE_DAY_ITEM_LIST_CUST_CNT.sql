/*
#----------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_AGG_STORE_DAY_ITEM_LIST_CUST_CNT
#----------------------------------------------------------------------------
# History:
# 1.0 2023-01-11  Marcin Malec        Initial Version
#                                     SPEC0148143 - Anz. Kunden | Sortimentsebene
# 1.1 2025-04-03  Bharat Yeddulapalli  Added new column to bring customer count at Store - Day Level as part of AP0257238| SPEC0304265.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_store_day_item_list_cust_cnt (client_id, loc_sid_store,
src_orig_store_nr, move_to_store_id, dwh_cal_dt, cy_month, busyear, aspect_id, wh_id, listing_type_id_hist,
list_type_hist_cnt_customer, store_day_item_list_cnt_customer) AS SELECT DISTINCT *
FROM ldl_p_lew_mart_lead.v_agg_store_day_item_list_cust_cnt;