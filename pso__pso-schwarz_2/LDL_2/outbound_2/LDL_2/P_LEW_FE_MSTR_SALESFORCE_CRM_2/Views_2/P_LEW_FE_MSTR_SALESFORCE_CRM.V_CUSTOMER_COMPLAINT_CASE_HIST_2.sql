CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_salesforce_crm.v_customer_complaint_case_hist_2 (client_id, cust_complaint_sid,
src_client_id, item_sid, src_orig_item_nr, src_item_nr, src_item_name, src_item_descr, src_item_long_descr, src_item_ian
, src_item_gtin, src_item_gtin_descr, src_item_sap_nr, item_grp_sid, src_item_group_nr, src_item_group_name,
item_fam_grp_sid, src_item_family_nr, src_item_family_name, cust_complaint_srv_center_cd, cust_complaint_srv_area_cd,
orig_cust_complaint_srv_area_cd, cust_complaint_contact_type_cd, cust_complaint_status_cd,
cust_complaint_sales_channel_cd, cust_complaint_origin_cd, cust_complaint_origin_group_name, brand_sid, src_brand_name,
sup_sid, src_sup_nr, src_sup_name, store_loc_sid, src_store_name, wh_loc_sid, src_wh_name, src_wh_acct_name,
src_wh_descr, cust_complaint_cat_sid, cust_complaint_cat_nr, cust_complaint_low_lvl_cat_name, cust_complaint_reason,
cust_complaint_short_descr, cust_complaint_descr, lot_nr, purchase_dt, best_before_dt, case_close_dt, is_critical_fg,
is_illness_injury_fg, is_main_case_fg, is_sub_case_fg, is_parent_case_fg, is_child_case_fg, dwh_valid_from, deleted_fg,
dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT K1.client_id,
 K1.cust_complaint_sid,
 K1.src_client_id,
 K1.item_sid,
 L1.src_orig_item_nr,
 K1.src_item_nr,
 K1.src_item_name,
 K1.src_item_descr,
 K1.src_item_long_descr,
 K1.src_item_ian,
 K1.src_item_gtin,
 K1.src_item_gtin_descr,
 K1.src_item_sap_nr,
 K1.item_grp_sid,
 K1.src_item_group_nr,
 K1.src_item_group_name,
 K1.item_fam_grp_sid,
 K1.src_item_family_nr,
 K1.src_item_family_name,
 K1.cust_complaint_srv_center_cd,
 K1.cust_complaint_srv_area_cd,
 K1.orig_cust_complaint_srv_area_cd,
 K1.cust_complaint_contact_type_cd,
 K1.cust_complaint_status_cd,
 K1.cust_complaint_sales_channel_cd,
 K1.cust_complaint_origin_cd,
 K1.cust_complaint_origin_group_name,
 K1.brand_sid,
 K1.src_brand_name,
 K1.sup_sid,
 K1.src_sup_nr,
 K1.src_sup_name,
 K1.store_loc_sid,
 K1.src_store_name,
 K1.wh_loc_sid,
 K1.src_wh_name,
 K1.src_wh_acct_name,
 K1.src_wh_descr,
 K1.cust_complaint_cat_sid,
 K1.cust_complaint_cat_nr,
 K1.cust_complaint_low_lvl_cat_name,
 K1.cust_complaint_reason,
 K1.cust_complaint_short_descr,
 K1.cust_complaint_descr,
 K1.lot_nr,
 K1.purchase_dt,
 K1.best_before_dt,
 K1.case_close_dt,
 K1.is_critical_fg,
 K1.is_illness_injury_fg,
 K1.is_main_case_fg,
 K1.is_sub_case_fg,
 K1.is_parent_case_fg,
 K1.is_child_case_fg,
 K1.dwh_valid_from,
 K1.deleted_fg,
 K1.dwh_valid_to,
 K1.dwh_load_id,
 K1.dwh_created,
 K1.dwh_updated
FROM ldl_p_lew_core_ac.v_customer_complaint_case_hist_2 AS K1
 LEFT JOIN ldl_p_lew_core_ac.v_item_2 AS L1 ON K1.item_sid = L1.item_sid
WHERE K1.cust_complaint_sid IN (SELECT A1.cust_complaint_sid
    FROM ldl_p_lew_core_ac.v_customer_complaint_case_hist_2 AS A1
     INNER JOIN ldl_p_lew_core_ac.v_customer_complaint_case_2 AS B1 ON A1.cust_complaint_sid = B1.cust_complaint_sid
    WHERE CURRENT_DATE BETWEEN A1.dwh_valid_from AND A1.dwh_valid_to
     AND B1.case_open_dt >= DATE '2020-05-08'
     AND B1.src_name = 'BSI'
     AND A1.is_critical_fg = 1
     AND (A1.cust_complaint_cat_nr LIKE '2.%' OR A1.cust_complaint_cat_nr LIKE '3.%' OR A1.cust_complaint_cat_nr LIKE
          '4.%' OR A1.cust_complaint_cat_nr LIKE '9.%' OR A1.cust_complaint_cat_nr LIKE '10.%')
    UNION DISTINCT
    SELECT A1.cust_complaint_sid
    FROM ldl_p_lew_core_ac.v_customer_complaint_case_hist_2 AS A1
     INNER JOIN ldl_p_lew_core_ac.v_customer_complaint_case_2 AS B1 ON A1.cust_complaint_sid = B1.cust_complaint_sid
    WHERE CURRENT_DATE BETWEEN A1.dwh_valid_from AND A1.dwh_valid_to
     AND B1.case_open_dt >= DATE '2020-05-08'
     AND B1.src_name = 'Salesforce'
     AND A1.is_critical_fg = 1
     AND A1.is_main_case_fg = 1
     AND (A1.cust_complaint_cat_nr LIKE '2.%' OR A1.cust_complaint_cat_nr LIKE '3.%'));