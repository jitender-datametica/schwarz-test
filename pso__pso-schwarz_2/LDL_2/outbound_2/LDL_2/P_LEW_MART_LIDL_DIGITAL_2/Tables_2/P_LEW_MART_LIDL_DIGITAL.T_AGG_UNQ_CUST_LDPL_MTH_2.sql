/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: 20180801_1778_LidlPlus_KPIs
#            DDL for t_agg_unq_cust_ldpl_mth_2
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
#                                         20200408_2447_Customer_Segment_Facts
#  1.9 2020-11-24 Pawel Wieczork          20201117_2664_harmo_cal SD-1544
#                                         Add column
#                                                   harmo_cal_month_no
#                                                   adjust_growth_fg - add to key
#                                         Drop columns
#                                                   cm_tot_gros_val
#                                                   cm_tot_net_val
#                                                   cm_trans_time_in_mins
#                                                   cm_items_scanned_cnt
#                                                   pm_tot_gros_val
#                                                   pm_tot_net_val
#                                                   pm_trans_time_in_mins
#                                                   pm_items_scanned_cnt
#                                                   pym_tot_gros_val
#                                                   py_tot_net_val
#                                                   pym_trans_time_in_mins
#                                                   pym_items_scanned_cnt
#  2.0 2021-05-06 Pawel Wieczorek         [SF] Modify cluster the same way as it is in P_LEW_MART_LIDL_DIGITAL_AC_MATERIALIZED
#
#  2.1 2021-05-13 Pawel Wieczorek         [SF] change to TIMESTAMP_NTZ(9)
#  2.2 2021-06-24 Patrick Mittler         [SF] remove COLLATE to improve performance
#  2.3 2022-08-08 Pawel Wieczorek         AP0092849 changing names, removing defaults, setting WH_ID not null
#                                         We dont need segment_sid in the PK, case for customer_sid == -999999999 we have the default segment
#                                         For the Lidlplus customere_sid and move_to_store_id are unique, even for BE and LU
#----------------------------------------------------------------------------
*/




/* ==============================================================================
Table DDL
============================================================================== */


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_agg_unq_cust_ldpl_mth_2 (
aspect_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'),
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
cy_month BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Lidl+ : Month value (-1 means data is not at month level)'),
harmo_cal_month_no BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Harmonized month no  per country_2 - month since rollout'),
move_to_store_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Lidl Store Id'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID'),
customer_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key CUSTOMER'),
lidlplus_cust_fg STRING(1) NOT NULL OPTIONS(description='Lidl Plus Customer Flag'),
adjust_growth_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Adjust growth flag - berenigte steigerung'),
mth_rf_segment_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Recency-frequency segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_mth.mth_rf_segment_sid'),
mth_m_segment_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Monetary Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_mth.mth_m_segment_sid'),
busyear_qtr_rf_segment_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Recency-frequency segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_busyear_qtr.busyear_qtr_rf_segment_sid'),
busyear_qtr_m_segment_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Monetary Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_busyear_qtr.busyear_m_segment_sid'),
currency_iso_cd STRING(3) NOT NULL OPTIONS(description='iso code for the clients (countrys) currency'),
curr_tot_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Fixe Werte fur EUR=0, GBP=40 sonst Client_Id'),
cm_cust_act BIGNUMERIC(38,0) OPTIONS(description='Current Month Customer Active flag 1 for active 0 for not active'),
pm_cust_act BIGNUMERIC(38,0) OPTIONS(description='Previous Month Customer Active flag 1 for active 0 for not active'),
pym_cust_act BIGNUMERIC(38,0)
OPTIONS(description='Previous Year Month Customer Active flag 1 for active 0 for not active'),
cm_mth_str_open_fg BIGNUMERIC(38,0) OPTIONS(description='Store open flag : Current month'),
cm_rcpts_cnt BIGNUMERIC(38,0) OPTIONS(description='Receipts count : Current month'),
pm_mth_str_open_fg BIGNUMERIC(38,0) OPTIONS(description='Store open flag : Previous month'),
pm_rcpts_cnt BIGNUMERIC(38,0) OPTIONS(description='Receipts count : Previous month'),
pym_mth_str_open_fg BIGNUMERIC(38,0) OPTIONS(description='Store open flag : Previous year month'),
pym_rcpts_cnt BIGNUMERIC(38,0) OPTIONS(description='Receipts count : Previous year month'),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row create time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (aspect_id, client_id, cy_month, move_to_store_id, customer_sid, adjust_growth_fg, currency_iso_cd)
NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='Table for Unique customer every Month');