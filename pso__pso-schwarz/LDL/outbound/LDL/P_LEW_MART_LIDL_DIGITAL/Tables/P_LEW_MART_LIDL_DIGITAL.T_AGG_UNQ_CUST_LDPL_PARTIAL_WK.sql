/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: 20180801_1778_LidlPlus_KPIs
#            DDL for t_agg_unq_cust_ldpl_partial_wk
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------





#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2020-04-14 Barbara Seneta          Initial version
#                                         20200408_2447_Customer_Segment_Fact
#  1.1 2020-05-06 Barbara Seneta          Added column wh_id (it does not change granularity of the table)
#                                         20200408_2447_Customer_Segment_Facts
#  1.2 2020-05-15 Barbara Seneta          Renamed Primary Index
#                                         20200408_2447_Customer_Segment_Fact
#  1.3 2020-05-22 Barbara Seneta          Changed data type of customer_segment_cd - from STRING to INTEGER
#                                         20200408_2447_Customer_Segment_Facts
#
#  1.4 2020-05-26 Barbara Seneta          Changed data type of customer_segment_cd - from INTEGER to INTEGER 
#                                         Added compression (MVC) on customer_segment_cd and on lidlplus_cust_fg
#                                         20200408_2447_Customer_Segment_Facts
#
#  1.5 2020-05-27 Barbara Seneta          Compression (MVC) moved from main DDL to ALTER statements
#                                         20200408_2447_Customer_Segment_Facts
#  1.6 2020-11-24 Pawel Wieczork          20201117_2664_harmo_cal SD-1544
#                                         Drop columns
#                                               cwpart_tot_gros_val
#                                               cwpart_tot_net_val
#                                               cwpart_trans_time_in_mins
#                                               cwpart_items_scanned_cnt
#                                               pywpart_tot_gros_val
#                                               pywpart_tot_net_val
#                                               pywpart_trans_time_in_mins
#                                               pywpart_items_scanned_cnt
#  1.7 2021-05-06 Pawel Wieczorek         [SF] Remove cluster the same way as it is in P_LEW_MART_LIDL_DIGITAL_AC_MATERIALIZED
#  1.8 2021-06-24 Patrick Mittler         [SF] remove COLLATE to improve performance
*/




/* ==============================================================================
   Table DDL
   ============================================================================== */


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_agg_unq_cust_ldpl_partial_wk (
aspect_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'),
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
cy_week BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Current Year Week'),
cy_week_part BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Part of the week, in non transit week: value 1, in transit week: in the first part of week - value 1, in the second part of week - value 2 '),
cy_week_partial_week_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Partial week unique id: cy_week || cy_week_part '),
cy_partial_week_name STRING(27) OPTIONS(description='Partial week name '),
move_to_store_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Lidl Store Id'),
wh_id BIGNUMERIC(38,0) OPTIONS(description='Warehouse ID'),
customer_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key CUSTOMER'),
lidlplus_cust_fg STRING(1) NOT NULL OPTIONS(description='Lidl Plus Customer Flag'),
currency_iso_cd STRING(3) NOT NULL OPTIONS(description='iso code for the clients (countrys) currency'),
curr_tot_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Fixe Werte fur EUR=0, GBP=40 sonst Client_Id'),
cwpart_cust_act BIGNUMERIC(38,0)
OPTIONS(description='Current Partial Week Customer Active flag 1 for active 0 for not active'),
pywpart_cust_act BIGNUMERIC(38,0)
OPTIONS(description='Previous Year Partial Week Customer Active flag 1 for active 0 for not active'),
cwpart_wk_str_open_fg BIGNUMERIC(38,0) OPTIONS(description='Store open flag : Current Partial week'),
cwpart_rcpts_cnt BIGNUMERIC(38,0) OPTIONS(description='Receipts count : Current Partial week'),
pywpart_wk_str_open_fg BIGNUMERIC(38,0) OPTIONS(description='Store open flag : Previous year partial week'),
pywpart_rcpts_cnt BIGNUMERIC(38,0) OPTIONS(description='Receipts count : Previous year partial week'),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row create time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (aspect_id, client_id, cy_week, move_to_store_id, customer_sid, currency_iso_cd) NOT ENFORCED
) OPTIONS(description='Table for Unique customer on Partial Week level');