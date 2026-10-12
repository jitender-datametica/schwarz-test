/*
#-----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: 20180801_1778_LidlPlus_KPIs
#            DDL for t_agg_rcpt_hdr_ldpl_mth_1
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------





#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2018-08-19 LEAD Reporting team 2   Initial version
#                                         20180801_1778_LidlPlus_KPIs
#  1.1 2019-01-03 LEAD Reporting team 2   Add store open flags
#                                         20181203_1895_Update_Fixes_LidlPlus
#  1.2 2019-04-12 Tris Bayliff            Add data mover columns
#                                         20190405_2026_KPI_PPM_LidlPlus_Mgmt_Rep
#  1.3 2020-04-09 Barbara Seneta          Added column customer_segment_cd
#                                         20200408_2447_Customer_Segment_Fact
#  1.4 2020-05-06 Barbara Seneta          Added column wh_id (it does not change granularity of the table)
#                                         20200408_2447_Customer_Segment_Facts
#  1.5 2020-05-07 Barbara Seneta          Changed Primary Index - from Unique    Non Unique Primary Index
#                                         20200408_2447_Customer_Segment_Facts
#  1.6 2020-05-22 Barbara Seneta          Changed data type of customer_segment_cd - from STRING  to INTEGER
#                                         20200408_2447_Customer_Segment_Facts
#
#  1.7 2020-05-26 Barbara Seneta          Changed data type of customer_segment_cd - from INTEGER to INTEGER 
#                                         Added compression (MVC) on customer_segment_cd and on lidlplus_cust_fg
#                                         20200408_2447_Customer_Segment_Facts
#
#  1.8 2020-05-27 Barbara Seneta          Compression (MVC) moved from main DDL to ALTER statements
#                                         20200408_2447_Customer_Segment_Facts
#  1.9 2020-11-24 Pawel Wieczork          20201117_2664_harmo_cal SD-1544
#                                         Add column 
#                                                   harmo_cal_month_no
#                                                   adjust_growth_fg 
#                                         Add to PI
#                                                   adjust_growth_fg
#  2.0 2021-05-06 Pawel Wieczorek         [SF] Remove cluster the same way as it is in P_LEW_MART_LIDL_DIGITAL_AC_MATERIALIZED
#
#  2.1 2021-05-13 Pawel Wieczorek         [SF] change to TIMESTAMP_NTZ(9)
#  2.2 2021-06-24 Patrick Mittler         [SF] remove COLLATE to improve performance
#  2.3 2022-04-22 Marcin Kikola           Adding new sutomer segments columns
#  2.4 2022-08-05 Pawel Wieczorek         AP0092849 changing names and adding business year quarter. removing defaults, setting WH_ID not null
#  2.5 2023-06-21 Marcin Kikola           Adjustement to the list of columns in order to reflect separation of write off and discount val
#  2.6 2-23-08-08 Rafal Rudnik            removing column PCWO_SOURCE_ID
#  2.7 2023-10-30 Pawel Wieczorek         AP0069622 Added columns gender_cd, age_range_cd
#  2.8 2024-08-08 Pawel Wieczorek         Put ddl from prod because of pipeline issues
#  2.9 2024-08-28 Pawel Wieczorek         feature/AP0225100_Attributes_About_Me Added columns: household_type_id, child_age_range_group_id  
#----------------------------------------------------------------------------
*/



/* ==============================================================================
   Table DDL
   ============================================================================== */


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_agg_rcpt_hdr_ldpl_mth_1 (
aspect_id INTEGER NOT NULL OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'),
client_id INTEGER NOT NULL OPTIONS(description='Identifier for client'),
move_to_store_id INTEGER NOT NULL OPTIONS(description='Store ID'),
wh_id INTEGER NOT NULL OPTIONS(description='Warehouse ID'),
lidlplus_cust_fg STRING(1) NOT NULL OPTIONS(description='Lidplus customer flag'),
adjust_growth_fg INTEGER NOT NULL OPTIONS(description='Adjust growth flag - berenigte steigerung'),
mth_rf_segment_sid INTEGER NOT NULL
OPTIONS(description='Recency-frequency segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_mth.mth_rf_segment_sid'),
mth_m_segment_sid INTEGER NOT NULL
OPTIONS(description='Monetary Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_mth.mth_m_segment_sid'),
busyear_qtr_rf_segment_sid INTEGER NOT NULL
OPTIONS(description='Recency-frequency segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_busyear_qtr.busyear_qtr_rf_segment_sid'),
busyear_qtr_m_segment_sid INTEGER NOT NULL
OPTIONS(description='Monetary Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_busyear_qtr.busyear_m_segment_sid'),
cy_month INTEGER NOT NULL OPTIONS(description='Month number'),
harmo_cal_month_no INTEGER NOT NULL OPTIONS(description='Harmonized month no  per country_1 - month since rollout'),
currency_iso_cd STRING(3) NOT NULL OPTIONS(description='ISO code for the currency of the client.'),
curr_tot_id INTEGER NOT NULL OPTIONS(description='Fixe Werte fuer EUR=0, GBP=40 sonst Client_Id'),
cm_mth_str_open_fg INTEGER OPTIONS(description='Store open flag : Current month'),
cm_tot_gros_val NUMERIC(29,5) OPTIONS(description='Total gross value : Current month'),
cm_tot_net_val NUMERIC(29,5) OPTIONS(description='Total net value : Current month'),
cm_rcpts_cnt INTEGER OPTIONS(description='Receipts count : Current month'),
cm_tot_rcpt_cnt_mth NUMERIC(29,5) OPTIONS(description='Receipts count'),
cm_trans_time_in_mins NUMERIC(29,5) OPTIONS(description='Transaction time measured in minutes : Current month'),
cm_items_scanned_cnt INTEGER OPTIONS(description='Number of items scanned : Current month'),
cm_discount_val NUMERIC(29,5) OPTIONS(description='Discount value : Current month'),
pm_mth_str_open_fg INTEGER OPTIONS(description='Store open flag : Previous month'),
pm_tot_gros_val NUMERIC(29,5) OPTIONS(description='Total gross value : Previous month'),
pm_tot_net_val NUMERIC(29,5) OPTIONS(description='Total net value : Previous month'),
pm_rcpts_cnt INTEGER OPTIONS(description='Receipts count : Previous month'),
pm_tot_rcpt_cnt_mth NUMERIC(29,5) OPTIONS(description='Receipts count'),
pm_trans_time_in_mins NUMERIC(29,5) OPTIONS(description='Transaction time measured in minutes : Previous month'),
pm_items_scanned_cnt INTEGER OPTIONS(description='Number of items scanned : Previous month'),
pm_discount_val NUMERIC(29,5) OPTIONS(description='Discount value : Previous month'),
pym_mth_str_open_fg INTEGER OPTIONS(description='Store open flag : Previous year month'),
pym_tot_gros_val NUMERIC(29,5) OPTIONS(description='Total gross value : Previous year month'),
pym_tot_net_val NUMERIC(29,5) OPTIONS(description='Total net value : Previous year month'),
pym_rcpts_cnt INTEGER OPTIONS(description='Receipts count : Previous year month'),
pym_tot_rcpt_cnt_mth NUMERIC(29,5) OPTIONS(description='Receipts count'),
pym_trans_time_in_mins NUMERIC(29,5) OPTIONS(description='Transaction time measured in minutes : Previous year month'),
pym_items_scanned_cnt INTEGER OPTIONS(description='Number of items scanned : Previous year month'),
pym_discount_val NUMERIC(29,5) OPTIONS(description='Discount value : Previous year month'),
load_id INTEGER NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row create time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
pcwo_reason_id INTEGER DEFAULT 0
OPTIONS(description='Unique ID of the write-off or Price change reason. Country_1-specific write-off reasons have ID>100.'),
coupon_reason_nr INTEGER DEFAULT 0 OPTIONS(description='Identifier of the booking reason in SCRM'),
cm_writeoff_val NUMERIC(29,5) DEFAULT 0 OPTIONS(description='Writeoff net value: Current month'),
pm_writeoff_val NUMERIC(29,5) DEFAULT 0 OPTIONS(description='Writeoff net value: Previous month'),
pym_writeoff_val NUMERIC(29,5) DEFAULT 0 OPTIONS(description='Writeoff net value: Current month'),
gender_cd STRING(5) DEFAULT 'na' NOT NULL OPTIONS(description='the code for the geder'),
age_range_cd STRING(10) DEFAULT 'na' NOT NULL OPTIONS(description='the code for the age range.'),
household_type_id INTEGER DEFAULT 0 OPTIONS(description='ID of the household type in which the customer lives.'),
child_age_range_group_id INTEGER DEFAULT 0
OPTIONS(description='Group of one or more age ranges in which the child is categorized depending on the age.'),
PRIMARY KEY (aspect_id, client_id, move_to_store_id, lidlplus_cust_fg, cy_month, currency_iso_cd, adjust_growth_fg,
 mth_rf_segment_sid, mth_m_segment_sid, busyear_qtr_rf_segment_sid, busyear_qtr_m_segment_sid) NOT ENFORCED
) OPTIONS(description='Lidlplus : Receipt header aggregated to month level');