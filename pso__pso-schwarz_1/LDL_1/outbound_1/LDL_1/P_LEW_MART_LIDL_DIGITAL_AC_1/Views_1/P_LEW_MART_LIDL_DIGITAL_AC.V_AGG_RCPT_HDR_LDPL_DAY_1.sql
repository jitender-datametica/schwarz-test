/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: 20180801_1778_LidlPlus_KPIs
#            1:1 DDL
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------





#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2018-08-27 LEAD Reporting team 2   Initial version
#                                         20180801_1778_LidlPlus_KPIs
#  1.1 2019-01-03 LEAD Reporting team 2   Add various flags used to identify sales_1 as per LEAD aggregates
#                                         20181203_1895_Update_Fixes_LidlPlus
#  1.2 2019-04-11 Tris Bayliff            Add position pro minute columns
#                                         20190405_2026_KPI_PPM_LidlPlus_Mgmt_Rep
#  1.3 2020-04-09 Barbara Seneta          Added column customer_segment_cd
#                                         20200408_2447_Customer_Segment_Facts
#  1.4 2020-05-06 Barbara Seneta          Added column wh_id, discount_val (it does not change granularity of the view)
#                                         20200408_2447_Customer_Segment_Facts
#  1.5 2020-11-25 Pawel Wieczork          20201117_2664_harmo_cal SD-1544
#                                         Drop columns and remove them from primary index
#                                                   value_sales_receipts_fg
#                                                   non_value_sales_receipts_fg
#                                                   return_transaction_fg
#                                                   sales_gross_val
#                                                   sales_net_val
#                                         Add column 
#                                                   harmo_cal_day_no
#                                                   adjust_growth_fg
#  1.6 2021-11-09 Pawel Wieczorek         SD-2618 Add loc_sid
#  1.7 2022-03-30 Pawel Wieczorek         AP0092849 disable column customer_segment_cd and set it as NULL, remove org_lvl_id, tm_lvl_id
#  1.8 2023-04-24 Pawel Wieczorek         AP0092849 Temporary restore old columns, to delete after promotion FE AP0092849
#  1.9 2023-06-26 Marcin Kikola           Adjustement to the list of columns in order to reflect separation of write off and discount val
#  2.0 2023-08-08 Marcin Kikola           Removal of not needed _ac columns
#  2.1 2023-12-07 Rafal Rudnik            AP0133752 Added column: gender_cd, age_range_cd
#  2.2 2024-08-07 Pawel Wieczorek         #659208 VGES fix added case for aspect_id
#  2.3 2024-06-25 Pawel Wieczorek         AP0225100 About me Added columns cy_month, cy_month_prev_1m, cy_month_prev_1y, cy_week, cy_week_prev_1w, cy_week_prev_1y
#  2.4 2024-08-29 Pawel Wieczorek         AP0225100 About me Adjust with q-master, household_type_id, child_age_range_group_id
#  2.5 2024-10-28 Pawel Wieczorek         feature/AP0225100_Attributes_About_Me Apply ascpect_id to disable in next feature
#----------------------------------------------------------------------------
*/



/* ==============================================================================
   Object DDL
   ============================================================================== */


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_agg_rcpt_hdr_ldpl_day_1 (aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), client_id
OPTIONS(description='Identifier for client'), dwh_cal_dt OPTIONS(description='Data date'), cy_month
OPTIONS(description='Calendar_1 Year+Month in form YYYYMM'), cy_month_prev_1m
OPTIONS(description='The calendar_1 month 1 month ago as a number in the form YYYYMM. Eg. 201901.    [Month Identifier]'),
cy_month_prev_1y
OPTIONS(description='The calendar_1 month 1 year ago as a number in the form YYYYMM. Eg. 201802.    [Month Identifier]'),
cy_week
OPTIONS(description='The week (containing the day) as a number in the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the calendar_1 year. Week 1 is the first week in the calendar_1 year containing at least 4 days.    [Week Identifier]'),
cy_week_prev_1w
OPTIONS(description='The week 1 week (= 7 days) ago as a number in the form YYYYWW. Eg. 202052.    [Week Identifier]'),
cy_week_prev_1y
OPTIONS(description='The week 1 year (= 364 days = 52 weeks) ago as a number in the form YYYYWW. Eg. 202001.    [Week Identifier]'),
harmo_cal_day_no OPTIONS(description='Harmonized day number'), loc_sid OPTIONS(description='Store ID'), move_to_store_id
OPTIONS(description='Move to store ID'), wh_id OPTIONS(description='Warehouse ID'), customer_sid
OPTIONS(description='Surrogate Key Customer'), lidlplus_cust_fg OPTIONS(description='Lidplus customer flag'),
adjust_growth_fg OPTIONS(description='Adjust growth flag - berenichte steigerung'), currency_iso_cd
OPTIONS(description='ISO code for the currency of the client.'), curr_tot_id
OPTIONS(description='Fixe Werte fur EUR=0, GBP=40 sonst Client_Id'), gender_cd
OPTIONS(description='The code for the gender'), age_range_cd OPTIONS(description='The code for the age range.'),
household_type_id OPTIONS(description='ID of the household type in which the customer lives.'), child_age_range_group_id
OPTIONS(description='Group of one or more age ranges in which the child is categorized depending on the age.'),
total_gross_val OPTIONS(description='Total gross value'), total_net_val OPTIONS(description='Total net value'),
number_of_receipts OPTIONS(description='Number of receipts'), trans_time_in_mins
OPTIONS(description='Duration of transaction in minutes. Decimal values are true decimals (ie, 30 secs is .5)'),
items_scanned_cnt OPTIONS(description='Number of items scanned'), pcwo_reason_id
OPTIONS(description='Unique ID of the write-off or Price change reason. Country_1-specific write-off reasons have ID>100.'),
pcwo_source_id OPTIONS(description='Price change or writeoff source, 0 - receiptheader, 1 price change, 2 - writeoff'),
coupon_reason_nr OPTIONS(description='Identifier of the booking reason in SCRM'), discount_val
OPTIONS(description='Discount value'), writeoff_val OPTIONS(description='Writeoff net value'), load_id
OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row create time'), dwh_updated
OPTIONS(description='Row update time')) OPTIONS(DESCRIPTION = `LIDLPLUS : RECEIPT HEADER AGGREGATED TO DAY LEVEL`) AS
SELECT CASE
  WHEN move_to_store_id = 0
  THEN 0
  ELSE aspect_id
  END AS aspect_id,
 client_id,
 dwh_cal_dt,
 cy_month,
 cy_month_prev_1m,
 cy_month_prev_1y,
 cy_week,
 cy_week_prev_1w,
 cy_week_prev_1y,
 harmo_cal_day_no,
 loc_sid,
 move_to_store_id,
 wh_id,
 customer_sid,
 lidlplus_cust_fg,
 adjust_growth_fg,
 currency_iso_cd,
 curr_tot_id,
 gender_cd,
 age_range_cd,
 household_type_id,
 child_age_range_group_id,
 total_gross_val,
 total_net_val,
 number_of_receipts,
 trans_time_in_mins,
 items_scanned_cnt,
 pcwo_reason_id,
 pcwo_source_id,
 coupon_reason_nr,
 discount_val,
 writeoff_val,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.v_agg_rcpt_hdr_ldpl_day_1 AS F;