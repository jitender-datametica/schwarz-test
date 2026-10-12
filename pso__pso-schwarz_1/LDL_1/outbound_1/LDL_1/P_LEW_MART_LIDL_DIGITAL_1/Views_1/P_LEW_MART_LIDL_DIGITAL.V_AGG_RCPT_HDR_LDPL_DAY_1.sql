/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: 20180801_1778_LidlPlus_KPIs
#            DDL for v_agg_rcpt_hdr_ldpl_day_1
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------





#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.1 2019-05-17 Tris Bayliff            Initial version
#                                         20190405_2026_KPI_PPM_LidlPlus_Mgmt_Rep
#  1.2 2020-04-09 Barbara Seneta          Added column customer_segment_cd
#                                         20200408_2447_Customer_Segment_Facts
#  1.3 2020-05-06 Barbara Seneta          Added column wh_id, discount_val (it does not change granularity of the view)
#                                         Removed columns new_reg_cnt, dereg_cnt as they are not needed/not used/.
#                                         20200408_2447_Customer_Segment_Facts
#  1.4 2020-11-17 Pawel Wieczork          20201117_2664_harmo_cal SD-1544
#                                         Drop columns and remove them from primary index
#                                                   value_sales_receipts_fg
#                                                   non_value_sales_receipts_fg
#                                                   return_transaction_fg
#                                                   sales_gross_val
#                                                   sales_net_val
#                                         Add column 
#                                                   harmo_cal_day_no
#                                                   adjust_growth_fg
#  1.5 2021-11-08 Pawel Wieczorek         SD-2618 Add column loc_sid
#  1.6 2022-04-04 Pawel Wieczorek         AP0092849 Remove column customer_segment_cd from table t_agg_rcpt_hdr_ldpl_day_1, remove org_lvl_id, tm_lvl_id
#  1.7 2023-06-26 Marcin Kikola			      Adjustement to the list of columns in order to reflect separation of write off and discount val
#  1.8 2023-12-04 Rafal Rudnik            AP0069622 Adding CROSS JOIN t_cust_demogr_1 and fileds: gender_cd, age_range_cd
#  1.9 2024-06-25 Pawel Wieczorek         AP0225100 About me Added columns cy_month, cy_month_prev_1m, cy_month_prev_1y, cy_week, cy_week_prev_1w, cy_week_prev_1y
#  2.0 2024-08-29 Pawel Wieczorek         AP0225100 About me household_type_id, child_age_range_group_id
#----------------------------------------------------------------------------
*/

/* ==============================================================================
   View DDL
   ============================================================================== */


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_agg_rcpt_hdr_ldpl_day_1 (aspect_id
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
adjust_growth_fg OPTIONS(description='Adjust growth flag - berenigte steigerung'), currency_iso_cd
OPTIONS(description='ISO code for the currency of the client.'), curr_tot_id
OPTIONS(description='Fixe Werte fur EUR=0, GBP=40 sonst Client_Id'), total_gross_val
OPTIONS(description='Total gross value'), total_net_val OPTIONS(description='Total net value'), number_of_receipts
OPTIONS(description='Number of receipts'), trans_time_in_mins
OPTIONS(description='Duration of transaction in minutes. Decimal values are true decimals (ie, 30 secs is .5)'),
items_scanned_cnt OPTIONS(description='Number of items scanned'), pcwo_reason_id
OPTIONS(description='Unique ID of the write-off or Price change reason. Country_1-specific write-off reasons have ID>100.'),
pcwo_source_id OPTIONS(description='Price change or writeoff source, 0 - receiptheader, 1 price change, 2 - writeoff'),
coupon_reason_nr OPTIONS(description='Identifier of the booking reason in SCRM'), gender_cd
OPTIONS(description='The code for the gender'), age_range_cd OPTIONS(description='The code for the age range.'),
household_type_id OPTIONS(description='ID of the household type in which the customer lives.'), child_age_range_group_id
OPTIONS(description='Group of one or more age ranges in which the child is categorized depending on the age.'),
discount_val OPTIONS(description='Discount value'), writeoff_val OPTIONS(description='Writeoff net value'), load_id
OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row create time'), dwh_updated
OPTIONS(description='Row update time')) OPTIONS(DESCRIPTION = `LIDLPLUS : RECEIPT HEADER AGGREGATED TO DAY LEVEL`) AS
SELECT RH.aspect_id,
 RH.client_id,
 RH.dwh_cal_dt,
 RH.cy_month,
 RH.cy_month_prev_1m,
 RH.cy_month_prev_1y,
 RH.cy_week,
 RH.cy_week_prev_1w,
 RH.cy_week_prev_1y,
 RH.harmo_cal_day_no,
 RH.loc_sid,
 RH.move_to_store_id,
 RH.wh_id,
 RH.customer_sid,
 RH.lidlplus_cust_fg,
 RH.adjust_growth_fg,
 RH.currency_iso_cd,
 RH.curr_tot_id,
 RH.total_gross_val,
 RH.total_net_val,
 RH.number_of_receipts,
 RH.trans_time_in_mins,
 RH.items_scanned_cnt,
 RH.pcwo_reason_id,
 RH.pcwo_source_id,
 RH.coupon_reason_nr,
 COLLATE(COALESCE(D.gender_cd, 'N/A'), '') AS gender_cd,
 COLLATE(COALESCE(D.age_range_cd, 'N/A'), '') AS age_range_cd,
 COALESCE(D.household_type_id, 0) AS household_type_id,
 COALESCE(D.child_age_range_group_id, 0) AS child_age_range_group_id,
 RH.discount_val,
 RH.writeoff_val,
 RH.load_id,
 RH.dwh_created,
 RH.dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_agg_rcpt_hdr_ldpl_day_1 AS RH
 LEFT JOIN ldl_p_lew_mart_lidl_digital.t_cust_demogr_1 AS D ON RH.customer_sid = D.customer_sid AND RH.lidlplus_cust_fg =
   'Y';