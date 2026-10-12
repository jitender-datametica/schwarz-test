CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_agg_store_day_item_itm_cnt_cust_1 (client_id, loc_sid_store,
src_orig_store_nr, move_to_store_id, dwh_cal_dt, cy_month, item_sid, src_orig_item_nr, item_grp_int_sid,
itemgroup_int_id, sub_item_grp_sid, subitemgroup_id, item_fam_grp_sid, item_familygroup_id, itm_cnt_customer,
wgi_cnt_customer, uwg_cnt_customer, fam_cnt_customer, store_day_cnt_customer) AS SELECT S.client_id,
 S.loc_sid_store,
 O.orig_store_nr AS src_orig_store_nr,
 O.move_to_store_id,
 S.dwh_cal_dt,
 S.cy_month,
 S.item_sid,
 S.src_orig_item_nr,
 S.item_grp_int_sid,
 S.itemgroup_int_id,
 S.sub_item_grp_sid,
 S.subitemgroup_id,
 S.item_fam_grp_sid,
 S.item_familygroup_id,
 S.itm_cnt_customer,
 S.wgi_cnt_customer,
 S.uwg_cnt_customer,
 S.fam_cnt_customer,
 S.store_day_cnt_customer
FROM ldl_p_lew_mart_lead.t_agg_store_day_item_cust_cnt_1 AS S
 INNER JOIN ldl_fe_mstr_toolbox_spiegel.v_org_store_merge_bges_1 AS O ON S.client_id = O.client_id AND S.loc_sid_store = O
   .store_id
WHERE S.dwh_cal_dt >= DATE_ADD(CURRENT_DATE, INTERVAL -400 DAY);