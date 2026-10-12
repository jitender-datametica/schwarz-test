/*
#----------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_AGG_STORE_DAY_ITEM_CUST_CNT_1
#----------------------------------------------------------------------------
# History:
# 1.0 2022-03-18  Marcin Malec        Initial Version
#                                     SPEC0148143 - Anz. Kunden | Sortimentsebene
# 1.1 2025-04-03  Bharat Yeddulapalli  Added new column to bring customer count at Store - Day Level as part of AP0257238| SPEC0304265.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_store_day_item_wgi_cust_cnt_1 (client_id, loc_sid_store,
src_orig_store_nr, move_to_store_id, dwh_cal_dt, cy_month, busyear, item_grp_int_sid, itemgroup_int_id, aspect_id, wh_id
, wgi_cnt_customer, store_day_wgi_cnt_customer) AS SELECT DISTINCT S.client_id,
 S.loc_sid_store,
 O.orig_store_nr AS src_orig_store_nr,
 O.move_to_store_id,
 S.dwh_cal_dt,
 S.cy_month,
 C.busyear,
 S.item_grp_int_sid,
 S.itemgroup_int_id,
 O.aspect_id,
 O.wh_id,
 S.wgi_cnt_customer,
 S.store_day_cnt_customer AS store_day_wgi_cnt_customer
FROM ldl_p_lew_mart_lead.t_agg_store_day_item_cust_cnt_1 AS S
 INNER JOIN ldl_p_lew_mart_lead_ac.v_org_store_merge_1 AS O ON S.client_id = O.client_id AND S.loc_sid_store = O.store_id
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS C ON S.dwh_cal_dt = C.cal_dt;