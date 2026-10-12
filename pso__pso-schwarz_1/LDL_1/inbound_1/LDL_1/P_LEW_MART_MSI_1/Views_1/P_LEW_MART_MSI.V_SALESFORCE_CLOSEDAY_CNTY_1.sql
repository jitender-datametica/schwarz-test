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

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_SALESFORCE_CLOSEDAY_CNTY_1 AS
SELECT
   sdc.client_id
  ,sdc.cc2
  ,sdc.cc3
  ,sdc.cust_complaint_sid
  ,sdc.src_cust_complaint_nr
  ,sdc.case_open_dt
  ,sdc.src_name
  ,sdc.src_client_id
  ,sdc.item_sid
  ,sdc.src_item_nr
  ,sdc.src_item_name
  ,sdc.src_item_descr
  ,sdc.src_item_long_descr
  ,sdc.src_item_ian
  ,sdc.src_item_gtin
  ,sdc.src_item_gtin_descr
  ,sdc.src_item_sap_nr
  ,sdc.item_grp_sid
  ,sdc.src_item_group_nr
  ,sdc.src_item_group_name
  ,sdc.item_fam_grp_sid
  ,sdc.src_item_family_nr
  ,sdc.src_item_family_name
  ,sdc.cust_complaint_srv_center_cd
  ,sdc.cust_complaint_contact_type_cd
  ,sdc.cust_complaint_status_cd
  ,sdc.cust_complaint_sales_channel_cd
  ,sdc.cust_complaint_origin_cd
  ,sdc.brand_sid
  ,sdc.src_brand_name
  ,sdc.sup_sid
  ,sdc.src_sup_nr
  ,sdc.src_sup_name
  ,sdc.store_loc_sid
  ,sdc.src_store_name
  ,sdc.wh_loc_sid
  ,sdc.src_wh_name
  ,sdc.src_wh_acct_name
  ,sdc.src_wh_descr
  ,sdc.cust_complaint_cat_sid
  ,sdc.cust_complaint_cat_nr
  ,sdc.cust_complaint_low_lvl_cat_name
  ,sdc.cust_complaint_reason
  ,sdc.cust_complaint_short_descr
  ,sdc.lot_nr
  ,sdc.purchase_dt
  ,sdc.best_before_dt
  ,sdc.case_close_dt
  ,sdc.is_critical_fg
  ,sdc.is_illness_injury_fg
  ,sdc.is_main_case_fg
  ,sdc.is_sub_case_fg
  ,sdc.is_parent_case_fg
  ,sdc.is_child_case_fg
  ,sdc.is_merge_case_fg
  ,sdc.src_cust_complaint_cat_nr
  ,sdc.cust_complaint_cat_name
  ,sdc.cust_complaint_sales_channel_desc
  ,sdc.cust_complaint_status_desc
  ,sdc.cust_complaint_origin_desc
  ,sdc.number_of_communications
  ,cal.dat_calendar
  ,cal.cy_month
  ,cal.cy AS byr
  ,sdc.srv_center_grp
FROM P_LEW_MART_MSI_AC.V_SALESFORCE_DAY_CNTY_1 sdc
  LEFT JOIN P_LEW_MART_MSI_AC.V_CAL_CALENDARDAY_1 cal
  ON case_close_dt = cal.dat_calendar;
  