/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------
# Interface: 20180801_1778_LidlPlus_KPIs
#            DDL for t_agg_rcpt_hdr_ldpl_wk_1
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
#                                         20200408_2447_Customer_Segment_Facts
#  1.4 2020-05-06 Barbara Seneta          Added column wh_id (it does not change granularity of the table)
#                                         20200408_2447_Customer_Segment_Facts
#  1.5 2020-05-07 Barbara Seneta          Changed Primary Index - from Unique 
#                                         20200408_2447_Customer_Segment_Facts
#  1.6 2020-05-22 Barbara Seneta          Changed data type of customer_segment_cd - from STRING to INTEGER
#                                         20200408_2447_Customer_Segment_Facts
#
#  1.7 2020-05-26 Barbara Seneta          Changed data type of customer_segment_cd - from INTEGER to INTEGER 
#                                         Added compression (MVC) on customer_segment_cd and on lidlplus_cust_fg
#                                         20200408_2447_Customer_Segment_Facts
#
#  1.8 2020-05-27 Barbara Seneta          Compression (MVC) moved from main DDL to ALTER statements
#                                         Changed lidlplus_cust_fg, currency_iso_cd to LATIN
#                                         20200408_2447_Customer_Segment_Facts
#  1.9 2020-11-24 Pawel Wieczork          20201117_2664_harmo_cal SD-1544
#                                         Add column 
#                                                   harmo_cal_week_no
#                                                   adjust_growth_fg
#  2.0 2021-05-06 Pawel Wieczorek         [SF] Remove cluster the same way as it is in P_LEW_MART_LIDL_DIGITAL_AC_MATERIALIZED
#
#  2.1 2021-05-13 Pawel Wieczorek         [SF] change to TIMESTAMP_NTZ(9)
#  2.2 2021-06-24 Patrick Mittler         [SF] remove COLLATE to improve performance
#  2.3 2022-04-11 Pawel Wieczorek         AP0092849 removal column customer_segment_cd and of org_lvl_id, tm_lvl_id
#                                         Adding new columns wk_rf_segment_sid, wk_m_segment_sid 
#                                         Removing default values
#  2.4 2022-08-08 Pawel Wieczorek         AP0092849 changing names, removing defaults, setting WH_ID not null
#  2.5 2023-06-21 Marcin Kikola           Adjustement to the list of columns in order to reflect separation of write off and discount val
#  2.7 2023-10-30 Pawel Wieczorek         AP0069622 Added columns gender_cd, age_range_cd
#  2.8 2024-08-08 Pawel Wieczorek         Put ddl from prod because of pipeline issues
#----------------------------------------------------------------------------
*/



/* ==============================================================================
   Table DDL
   ============================================================================== */


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_agg_rcpt_hdr_ldpl_wk_1 (
aspect_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'),
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier for client'),
move_to_store_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Store ID'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID'),
lidlplus_cust_fg STRING(1) NOT NULL OPTIONS(description='Lidplus customer flag'),
adjust_growth_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Adjust growth flag - berenichte steigerung'),
wk_rf_segment_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Recency-frequency segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_wk.wk_rf_segment_sid'),
wk_m_segment_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Monetary segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_wk.wk_m_segment_sid'),
cy_week BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Week number'),
harmo_cal_week_no BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Harmonized week no per country_1 - week since rollout'),
currency_iso_cd STRING(3) NOT NULL OPTIONS(description='ISO code for the currency of the client.'),
curr_tot_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Fixe Werte fuer EUR=0, GBP=40 sonst Client_Id'),
cw_wk_str_open_fg BIGNUMERIC(38,0) OPTIONS(description='Store open flag : Current week'),
cw_tot_gros_val NUMERIC(18,5) OPTIONS(description='Total gross value : Current week'),
cw_tot_net_val NUMERIC(18,5) OPTIONS(description='Total net value : Current week'),
cw_rcpts_cnt BIGNUMERIC(38,0) OPTIONS(description='Receipts count : Current week'),
cw_tot_rcpt_cnt_wk NUMERIC(18,5) OPTIONS(description='Total receipts count : Current week'),
cw_trans_time_in_mins NUMERIC(18,5) OPTIONS(description='Transaction time measured in minutes : Current week'),
cw_items_scanned_cnt BIGNUMERIC(38,0) OPTIONS(description='Number of items scanned : Current week'),
cw_discount_val NUMERIC(18,5) OPTIONS(description='Discount value : Current week'),
pw_wk_str_open_fg BIGNUMERIC(38,0) OPTIONS(description='Store open flag : Previous week'),
pw_tot_gros_val NUMERIC(18,5) OPTIONS(description='Total gross value : Previous week'),
pw_tot_net_val NUMERIC(18,5) OPTIONS(description='Total net value : Previous week'),
pw_rcpts_cnt BIGNUMERIC(38,0) OPTIONS(description='Receipts count : Previous week'),
pw_tot_rcpt_cnt_wk NUMERIC(18,5) OPTIONS(description='Total receipts count : Previous week'),
pw_trans_time_in_mins NUMERIC(18,5) OPTIONS(description='Transaction time measured in minutes : Previous week'),
pw_items_scanned_cnt BIGNUMERIC(38,0) OPTIONS(description='Number of items scanned : Previous week'),
pw_discount_val NUMERIC(18,5) OPTIONS(description='Discount value : Previous week'),
pyw_wk_str_open_fg BIGNUMERIC(38,0) OPTIONS(description='Store open flag : Previous year week'),
pyw_tot_gros_val NUMERIC(18,5) OPTIONS(description='Total gross value : Previous year week'),
pyw_tot_net_val NUMERIC(18,5) OPTIONS(description='Total net value : Previous year week week'),
pyw_rcpts_cnt BIGNUMERIC(38,0) OPTIONS(description='Receipts count : Previous year week'),
pyw_tot_rcpt_cnt_wk NUMERIC(18,5) OPTIONS(description='Total receipts count : Previous year week'),
pyw_trans_time_in_mins NUMERIC(18,5) OPTIONS(description='Transaction time measured in minutes : Previous year week'),
pyw_items_scanned_cnt BIGNUMERIC(38,0) OPTIONS(description='Number of items scanned : Previous year week'),
pyw_discount_val NUMERIC(18,5) OPTIONS(description='Discount value : Previous year week'),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row create time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
pcwo_reason_id BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Unique ID of the write-off or Price change reason. Country_1-specific write-off reasons have ID>100.'),
coupon_reason_nr BIGNUMERIC(38,0) DEFAULT 0 OPTIONS(description='Identifier of the booking reason in SCRM'),
cw_writeoff_val NUMERIC(18,5) DEFAULT 0 OPTIONS(description='Writeoff net value: Current week'),
pw_writeoff_val NUMERIC(18,5) DEFAULT 0 OPTIONS(description='Writeoff net value: Previous week'),
pyw_writeoff_val NUMERIC(18,5) DEFAULT 0 OPTIONS(description='Writeoff net value: Previous week'),
gender_cd STRING(5) DEFAULT 'na' NOT NULL OPTIONS(description='the code for the geder'),
age_range_cd STRING(10) DEFAULT 'na' NOT NULL OPTIONS(description='the code for the age range.'),
PRIMARY KEY (aspect_id, client_id, move_to_store_id, lidlplus_cust_fg, cy_week, adjust_growth_fg, currency_iso_cd,
 wk_rf_segment_sid, wk_m_segment_sid, gender_cd, age_range_cd) NOT ENFORCED
) OPTIONS(description='Lidlplus : Receipt header aggregated to week level');