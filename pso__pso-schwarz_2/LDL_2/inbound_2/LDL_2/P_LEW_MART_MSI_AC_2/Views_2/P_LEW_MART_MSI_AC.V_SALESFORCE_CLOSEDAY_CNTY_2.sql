/*
 #----------------------------------------------------------------------------
 # @ LIDL Stiftung & Co. KG - DWH / MIS
 #----------------------------------------------------------------------------
 # Interface: DDL for P_LEW_MART_MSI_AC.V_SALESFORCE_CLOSEDAY_CNTY_2
 #----------------------------------------------------------------------------
 # History:
 #  1.0  19.12.2022    Wandtke,Andrzej           AP0140749 CC-Dossier - Initial Version, View based on close date
 #  1.1  11.01.2023    Wandtke,Andrzej           AP0140749_corr_views_2 - Add column srv_center_grp
 #----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_SALESFORCE_CLOSEDAY_CNTY_2 AS
SELECT
   client_id
  ,cc2
  ,cc3
  ,cust_complaint_sid
  ,src_cust_complaint_nr
  ,case_open_dt
  ,src_name
  ,src_client_id
  ,item_sid
  ,src_item_nr
  ,src_item_name
  ,src_item_descr
  ,src_item_long_descr
  ,src_item_ian
  ,src_item_gtin
  ,src_item_gtin_descr
  ,src_item_sap_nr
  ,item_grp_sid
  ,src_item_group_nr
  ,src_item_group_name
  ,item_fam_grp_sid
  ,src_item_family_nr
  ,src_item_family_name
  ,cust_complaint_srv_center_cd
  ,cust_complaint_contact_type_cd
  ,cust_complaint_status_cd
  ,cust_complaint_sales_channel_cd
  ,cust_complaint_origin_cd
  ,brand_sid
  ,src_brand_name
  ,sup_sid
  ,src_sup_nr
  ,src_sup_name
  ,store_loc_sid
  ,src_store_name
  ,wh_loc_sid
  ,src_wh_name
  ,src_wh_acct_name
  ,src_wh_descr
  ,cust_complaint_cat_sid
  ,cust_complaint_cat_nr
  ,cust_complaint_low_lvl_cat_name
  ,cust_complaint_reason
  ,cust_complaint_short_descr
  ,lot_nr
  ,purchase_dt
  ,best_before_dt
  ,case_close_dt
  ,is_critical_fg
  ,is_illness_injury_fg
  ,is_main_case_fg
  ,is_sub_case_fg
  ,is_parent_case_fg
  ,is_child_case_fg
  ,is_merge_case_fg
  ,src_cust_complaint_cat_nr
  ,cust_complaint_cat_name
  ,cust_complaint_sales_channel_desc
  ,cust_complaint_status_desc
  ,cust_complaint_origin_desc
  ,number_of_communications
  ,dat_calendar
  ,cy_month
  ,byr
  ,srv_center_grp
FROM P_LEW_MART_MSI.V_SALESFORCE_CLOSEDAY_CNTY_2;
