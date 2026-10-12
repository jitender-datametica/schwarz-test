/*
#----------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_AGG_STORE_DAY_ITEM_BUY_CUST_CNT
#----------------------------------------------------------------------------
# History:
# 1.0 2023-01-11  Marcin Malec        Initial Version
#                                     SPEC0148143 - Anz. Kunden | Sortimentsebene
# 1.1 2025-04-03  Bharat Yeddulapalli  Added new column to bring customer count at Store - Day Level as part of AP0257238, SPEC0304265.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_store_day_item_buy_cust_cnt (client_id, loc_sid_store,
src_orig_store_nr, move_to_store_id, dwh_cal_dt, cy_month, busyear, aspect_id, wh_id, buying_list_type_id_curr,
buy_list_cnt_customer, store_day_buy_list_cnt_customer) AS SELECT DISTINCT S.client_id,
 S.loc_sid_store,
 O.orig_store_nr AS src_orig_store_nr,
 O.move_to_store_id,
 S.dwh_cal_dt,
 S.cy_month,
 C.busyear,
 O.aspect_id,
 O.wh_id,
 S.buying_list_type_id_curr,
 S.buy_list_cnt_customer,
 S.store_day_cnt_customer AS store_day_buy_list_cnt_customer
FROM ldl_p_lew_mart_lead.t_agg_store_day_item_cust_cnt AS S
 INNER JOIN ldl_p_lew_mart_lead_ac.v_org_store_merge AS O ON S.client_id = O.client_id AND S.loc_sid_store = O.store_id
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS C ON S.dwh_cal_dt = C.cal_dt;