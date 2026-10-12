/*
#-----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: 20180801_1778_LidlPlus_KPIs
#            DDL for t_agg_rcpt_hdr_ldpl_day_1
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
#  1.1 2019-01-03 LEAD Reporting team 2   Add various flags used to identify sales_1 as per LEAD aggregates
#                                         20181203_1895_Update_Fixes_LidlPlus
#  1.2 2019-04-11 Tris Bayliff            Add position pro minute columns
#                                         20190405_2026_KPI_PPM_LidlPlus_Mgmt_Rep
#  1.3 2020-04-09 Barbara Seneta          Added column customer_segment_cd
#                                         20200408_2447_Customer_Segment_Facts
#  1.4 2020-05-06 Barbara Seneta          Added column wh_id, discount_val (it does not change granularity of the table)
#                                         20200408_2447_Customer_Segment_Facts
#  1.5 2020-05-07 Barbara Seneta          Changed Primary Index - from Unique  Non Unique Primary Index
#                                         20200408_2447_Customer_Segment_Facts
#  1.6 2020-05-22 Barbara Seneta          Changed data type of customer_segment_cd - from STRING to INTEGER
#                                         20200408_2447_Customer_Segment_Facts
#
#  1.7 2020-05-26 Barbara Seneta          Changed data type of customer_segment_cd - from INTEGER to INTEGER 
#                                         Added compression (MVC) on customer_segment_cd and on lidlplus_cust_fg
#                                         20200408_2447_Customer_Segment_Facts
#
#  1.8 2020-05-27 Barbara Seneta          Compression (MVC) moved from main DDL to ALTER statements
#                                         Changed lidlplus_cust_fg to LATIN
#                                         20200408_2447_Customer_Segment_Facts
#  1.9 2020-11-25 Pawel Wieczork          20201117_2664_harmo_cal SD-1544
#                                         Drop columns and remove them from primary index
#                                                   value_sales_receipts_fg
#                                                   non_value_sales_receipts_fg
#                                                   return_transaction_fg
#                                                   sales_gross_val
#                                                   sales_net_val
#                                         Add column 
#                                                   harmo_cal_day_no
#                                                   adjust_growth_fg
#  2.0 2021-05-06 Pawel Wieczorek         [SF] add cluster the same way as it is in P_LEW_MART_LIDL_DIGITAL_AC_MATERIALIZED
#
#  2.1 2021-05-13 Pawel Wieczorek         [SF] change to TIMESTAMP_NTZ(9)
#  2.2 2021-06-24 Patrick Mittler         [SF] remove COLLATE to improve performance
#  2.3 2021-11-08 Pawel Wieczorek         SD-2618 Remove move_to_store_id from PI and add loc_sid instead of it, add not null to NOT NULL
#  2.4 2021-11-15 Pawel Wieczorek         SD-2618 Add loc_sid at the end, remove default values 
#  2.5 2022-03-30 Pawel Wieczorek         AP0092849 Remove column customer_segment_cd from table t_agg_rcpt_hdr_ldpl_day_1
#  2.6 2023-06-21 Marcin Kikola           Adjustement to the list of columns in order to reflect separation of write off and discount val
#  2.7 2023-08-08 Marcin Kikola           Fix of default value for discount and writeoff
#  2.8 2024-06-25 Pawel Wieczorek         feature/AP0225100_Attributes_About_Me - refresh structure from the prod, 
#                                         added columns cy_month, cy_month_prev_1m, cy_month_prev_1y, cy_week, cy_week_prev_1w, cy_week_prev_1y
#----------------------------------------------------------------------------
*/



/* ==============================================================================
   Table DDL
   ============================================================================== */


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_agg_rcpt_hdr_ldpl_day_1 (
aspect_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'),
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier for client'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Data date'),
harmo_cal_day_no BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Harmonized day number'),
loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Store ID'),
move_to_store_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Store ID'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID'),
customer_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key CUSTOMER'),
lidlplus_cust_fg STRING(1) NOT NULL OPTIONS(description='Lidplus customer flag'),
adjust_growth_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Adjust growth flag - berenichte steigerung'),
currency_iso_cd STRING(3) NOT NULL OPTIONS(description='ISO code for the currency of the client.'),
curr_tot_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Fixe Werte fuer EUR=0, GBP=40 sonst Client_Id'),
total_gross_val NUMERIC(18,5) NOT NULL OPTIONS(description='Total gross value'),
total_net_val NUMERIC(18,5) NOT NULL OPTIONS(description='Total net value'),
number_of_receipts BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Number of receipts'),
trans_time_in_mins NUMERIC(18,5) NOT NULL
OPTIONS(description='Duration of transaction in minutes. Decimal values are true decimals (ie. 30 secs is .5)'),
items_scanned_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Number of items scanned'),
discount_val NUMERIC(18,5) OPTIONS(description='Discount value'),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row create time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
pcwo_reason_id BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Unique ID of the write-off or Price change reason. Country_1-specific write-off reasons have ID>100.'),
pcwo_source_id BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Price change or writeoff source, 0 - receiptheader, 1 price change, 2 - writeoff'),
coupon_reason_nr BIGNUMERIC(38,0) DEFAULT 0 OPTIONS(description='Identifier of the booking reason in SCRM'),
writeoff_val NUMERIC(18,5) DEFAULT 0 OPTIONS(description='Writeoff net value'),
cy_month BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Calendar_1 Year+Month in form YYYYMM'),
cy_month_prev_1m BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='The calendar_1 month 1 month ago as a number in the form YYYYMM. Eg. 201901.    [Month Identifier]'),
cy_month_prev_1y BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='The calendar_1 month 1 year ago as a number in the form YYYYMM. Eg. 201802.    [Month Identifier]'),
cy_week BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='The week (containing the day) as a number in the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the calendar_1 year. Week 1 is the first week in the calendar_1 year containing at least 4 days.    [Week Identifier]'),
cy_week_prev_1w BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='The week 1 week (= 7 days) ago as a number in the form YYYYWW. Eg. 202052.    [Week Identifier]'),
cy_week_prev_1y BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='The week 1 year (= 364 days = 52 weeks) ago as a number in the form YYYYWW. Eg. 202001.    [Week Identifier]'),
PRIMARY KEY (aspect_id, client_id, dwh_cal_dt, loc_sid, customer_sid, currency_iso_cd) NOT ENFORCED
) CLUSTER BY client_id, dwh_cal_dt
OPTIONS(description='Lidlplus : Receipt header aggregated to day level');