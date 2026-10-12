/*
#----------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_AGG_STORE_DAY_ITEM_CUST_CNT
#----------------------------------------------------------------------------
# History:
# 1.0 2022-03-18  Marcin Malec        Initial Version
#                                     SPEC0148143 - Anz. Kunden | Sortimentsebene
# 1.1 2025-04-03  Bharat Yeddulapalli  Added new column to bring customer count at Store - Day Level as part of AP0257238|SPEC0304265.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_store_day_item_cust_cnt (client_id, loc_sid_store, src_orig_store_nr,
move_to_store_id, dwh_cal_dt, cy_month, busyear, item_sid, src_orig_item_nr, item_grp_int_sid, itemgroup_int_id,
sub_item_grp_sid, subitemgroup_id, item_fam_grp_sid, item_familygroup_id, aspect_id, wh_id, buying_list_type_id_curr,
buying_list_type_id_hist, listing_type_id_hist, wgi_cnt_customer, uwg_cnt_customer, fam_cnt_customer, itm_cnt_customer,
buy_list_cnt_customer, buy_list_hist_cnt_customer, list_type_hist_cnt_customer, store_day_item_cnt_customer) AS SELECT S
 .client_id,
 S.loc_sid_store,
 O.orig_store_nr AS src_orig_store_nr,
 O.move_to_store_id,
 S.dwh_cal_dt,
 S.cy_month,
 C.busyear,
 S.item_sid,
 S.src_orig_item_nr,
 S.item_grp_int_sid,
 S.itemgroup_int_id,
 S.sub_item_grp_sid,
 S.subitemgroup_id,
 S.item_fam_grp_sid,
 S.item_familygroup_id,
 O.aspect_id,
 O.wh_id,
 S.buying_list_type_id_curr,
 S.buying_list_type_id_hist,
 S.listing_type_id_hist,
 S.wgi_cnt_customer,
 S.uwg_cnt_customer,
 S.fam_cnt_customer,
 S.itm_cnt_customer,
 S.buy_list_cnt_customer,
 S.buy_list_hist_cnt_customer,
 S.list_type_hist_cnt_customer,
 S.store_day_cnt_customer AS store_day_item_cnt_customer
FROM ldl_p_lew_mart_lead.t_agg_store_day_item_cust_cnt AS S
 INNER JOIN ldl_p_lew_mart_lead_ac.v_org_store_merge AS O ON S.client_id = O.client_id AND S.loc_sid_store = O.store_id
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS C ON S.dwh_cal_dt = C.cal_dt;