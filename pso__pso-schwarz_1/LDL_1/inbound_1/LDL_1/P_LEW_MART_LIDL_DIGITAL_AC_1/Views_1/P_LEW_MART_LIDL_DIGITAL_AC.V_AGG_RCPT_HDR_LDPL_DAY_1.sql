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


CREATE OR REPLACE VIEW P_LEW_MART_LIDL_DIGITAL_AC.v_agg_rcpt_hdr_ldpl_day_1
(
  aspect_id                 COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, client_id                 COMMENT 'Identifier for client'
, dwh_cal_dt                COMMENT 'Data date'
, cy_month                  COMMENT 'Calendar_1 Year+Month in form YYYYMM'
, cy_month_prev_1m          COMMENT 'The calendar_1 month 1 month ago as a number in the form YYYYMM. Eg. 201901.    [Month Identifier]'
, cy_month_prev_1y          COMMENT 'The calendar_1 month 1 year ago as a number in the form YYYYMM. Eg. 201802.    [Month Identifier]'
, cy_week                   COMMENT 'The week (containing the day) as a number in the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the calendar_1 year. Week 1 is the first week in the calendar_1 year containing at least 4 days.    [Week Identifier]'
, cy_week_prev_1w           COMMENT 'The week 1 week (= 7 days) ago as a number in the form YYYYWW. Eg. 202052.    [Week Identifier]'
, cy_week_prev_1y           COMMENT 'The week 1 year (= 364 days = 52 weeks) ago as a number in the form YYYYWW. Eg. 202001.    [Week Identifier]'
, harmo_cal_day_no          COMMENT 'Harmonized day number'
, loc_sid                   COMMENT 'Store ID'
, move_to_store_id          COMMENT 'Move to store ID'
, wh_id                     COMMENT 'Warehouse ID'
, customer_sid              COMMENT 'Surrogate Key Customer'
, lidlplus_cust_fg          COMMENT 'Lidplus customer flag'
, adjust_growth_fg          COMMENT 'Adjust growth flag - berenichte steigerung'
, currency_iso_cd           COMMENT 'ISO code for the currency of the client.'
, curr_tot_id               COMMENT 'Fixe Werte fur EUR=0, GBP=40 sonst Client_Id'
, gender_cd                 COMMENT 'The code for the gender'
, age_range_cd              COMMENT 'The code for the age range.'
, household_type_id         COMMENT 'ID of the household type in which the customer lives.'
, child_age_range_group_id  COMMENT 'Group of one or more age ranges in which the child is categorized depending on the age.'
, total_gross_val           COMMENT 'Total gross value'
, total_net_val             COMMENT 'Total net value'
, number_of_receipts        COMMENT 'Number of receipts'
, trans_time_in_mins        COMMENT 'Duration of transaction in minutes. Decimal values are true decimals (ie, 30 secs is .5)'
, items_scanned_cnt         COMMENT 'Number of items scanned'
, pcwo_reason_id            COMMENT 'Unique ID of the write-off or Price change reason. Country_1-specific write-off reasons have ID>100.'
, pcwo_source_id            COMMENT 'Price change or writeoff source, 0 - receiptheader, 1 price change, 2 - writeoff'
, coupon_reason_nr          COMMENT 'Identifier of the booking reason in SCRM'
, discount_val              COMMENT 'Discount value'
, writeoff_val              COMMENT 'Writeoff net value'
, load_id                   COMMENT 'Load identifier'
, dwh_created               COMMENT 'Row create time'
, dwh_updated               COMMENT 'Row update time'
)
COMMENT = 'Lidlplus : Receipt header aggregated to day level'
AS 
SELECT
  CASE WHEN f.move_to_store_id = 0 THEN 0 ELSE f.aspect_id END AS aspect_id
, f.client_id
, f.dwh_cal_dt
, f.cy_month
, f.cy_month_prev_1m
, f.cy_month_prev_1y
, f.cy_week
, f.cy_week_prev_1w
, f.cy_week_prev_1y
, f.harmo_cal_day_no
, f.loc_sid
, f.move_to_store_id
, f.wh_id
, f.customer_sid
, f.lidlplus_cust_fg
, f.adjust_growth_fg
, f.currency_iso_cd
, f.curr_tot_id
, f.gender_cd
, f.age_range_cd
, f.household_type_id
, f.child_age_range_group_id
, f.total_gross_val
, f.total_net_val
, f.number_of_receipts
, f.trans_time_in_mins
, f.items_scanned_cnt
, f.pcwo_reason_id 
, f.pcwo_source_id 
, f.coupon_reason_nr
, f.discount_val
, f.writeoff_val
, f.load_id
, f.dwh_created
, f.dwh_updated 
FROM P_LEW_MART_LIDL_DIGITAL.v_agg_rcpt_hdr_ldpl_day_1 AS f
;

