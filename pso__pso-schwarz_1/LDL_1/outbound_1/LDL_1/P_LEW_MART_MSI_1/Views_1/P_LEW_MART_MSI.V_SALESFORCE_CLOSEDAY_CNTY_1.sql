/*
 #----------------------------------------------------------------------------
 # @ LIDL Stiftung & Co. KG - DWH / MIS
 #----------------------------------------------------------------------------
 # Interface: DDL for P_LEW_MART_MSI.V_SALESFORCE_CLOSEDAY_CNTY_1
 #----------------------------------------------------------------------------
 # History:
 #  1.0  19.12.2022    Wandtke,Andrzej           AP0140749 CC-Dossier - Initial Version, View based on close date
 #  1.1  11.01.2023    Wandtke,Andrzej           AP0140749_corr_views_2 - Add column srv_center_grp
 #----------------------------------------------------------------------------
 */


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_salesforce_closeday_cnty_1 AS SELECT SDC.client_id,
 SDC.cc2,
 SDC.cc3,
 SDC.cust_complaint_sid,
 SDC.src_cust_complaint_nr,
 SDC.case_open_dt,
 SDC.src_name,
 SDC.src_client_id,
 SDC.item_sid,
 SDC.src_item_nr,
 SDC.src_item_name,
 SDC.src_item_descr,
 SDC.src_item_long_descr,
 SDC.src_item_ian,
 SDC.src_item_gtin,
 SDC.src_item_gtin_descr,
 SDC.src_item_sap_nr,
 SDC.item_grp_sid,
 SDC.src_item_group_nr,
 SDC.src_item_group_name,
 SDC.item_fam_grp_sid,
 SDC.src_item_family_nr,
 SDC.src_item_family_name,
 SDC.cust_complaint_srv_center_cd,
 SDC.cust_complaint_contact_type_cd,
 SDC.cust_complaint_status_cd,
 SDC.cust_complaint_sales_channel_cd,
 SDC.cust_complaint_origin_cd,
 SDC.brand_sid,
 SDC.src_brand_name,
 SDC.sup_sid,
 SDC.src_sup_nr,
 SDC.src_sup_name,
 SDC.store_loc_sid,
 SDC.src_store_name,
 SDC.wh_loc_sid,
 SDC.src_wh_name,
 SDC.src_wh_acct_name,
 SDC.src_wh_descr,
 SDC.cust_complaint_cat_sid,
 SDC.cust_complaint_cat_nr,
 SDC.cust_complaint_low_lvl_cat_name,
 SDC.cust_complaint_reason,
 SDC.cust_complaint_short_descr,
 SDC.lot_nr,
 SDC.purchase_dt,
 SDC.best_before_dt,
 SDC.case_close_dt,
 SDC.is_critical_fg,
 SDC.is_illness_injury_fg,
 SDC.is_main_case_fg,
 SDC.is_sub_case_fg,
 SDC.is_parent_case_fg,
 SDC.is_child_case_fg,
 SDC.is_merge_case_fg,
 SDC.src_cust_complaint_cat_nr,
 SDC.cust_complaint_cat_name,
 SDC.cust_complaint_sales_channel_desc,
 SDC.cust_complaint_status_desc,
 SDC.cust_complaint_origin_desc,
 SDC.number_of_communications,
 CAL.dat_calendar,
 CAL.cy_month,
 CAL.cy AS byr,
 SDC.srv_center_grp
FROM ldl_p_lew_mart_msi_ac.v_salesforce_day_cnty_1 AS SDC
 LEFT JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday_1 AS CAL ON SDC.case_close_dt = CAL.dat_calendar;