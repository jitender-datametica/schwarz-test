/*
#-----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: 20180801_1778_LidlPlus_KPIs
#            DDL for t_agg_rcpt_hdr_ldpl_day
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------





#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2020-11-23 Pawel Wieczorek   Initial version 20201120_2669_ldpl_daily_aggr SD-1555
#  1.1 2020-12-03 Pawel Wieczork          20201117_2664_harmo_cal SD-1544
#                                         Add column 
#                                                   harmo_cal_day_no
#                                                   adjust_growth_fg
#  1.2 2021-05-06 Pawel Wieczorek         [SF] Remove cluster the same way as it is in P_LEW_MART_LIDL_DIGITAL_AC_MATERIALIZED
#  1.3 2021-06-24 Patrick Mittler         Remove Collate to improve the performance
#  1.4 2022-03-31 Pawel Wieczorek         AP0092849 Remove column customer_segment_cd
#  1.5 2022-04-08 Pawel Wieczorek         AP0092849 fix keywords to UPPERCASE
#  1.6 2023-08-11 Pawel Wieczorek		  AP0157806 booking reasons
#  1.7 2023-10-30 Pawel Wieczorek         AP0069622 Added columns gender_cd, age_range_cd
#  1.8 2024-06-24 Pawel Wieczorek         AP0197960_Distinct_Reg_User Restore structure from the prod, it was dependency in P_LEW_MART_CS.V_BW_LP_OHNE_COUPON
#----------------------------------------------------------------------------
*/




/* ==============================================================================
   Table DDL
   ============================================================================== */


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_agg_client_rcpt_hdr_ldpl_day (
aspect_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'),
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier for client'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Data date'),
move_to_store_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Store ID'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID'),
lidlplus_cust_fg STRING(1) NOT NULL OPTIONS(description='Lidplus customer flag'),
harmo_cal_day_no BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Harmonized day number'),
adjust_growth_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Adjust growth flag - berenigte steigerung'),
currency_iso_cd STRING(3) NOT NULL OPTIONS(description='ISO code for the currency of the client.'),
curr_tot_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Fixe Werte fuer EUR=0, GBP=40 sonst Client_Id'),
total_gross_val NUMERIC(18,5) NOT NULL OPTIONS(description='Total gross value'),
total_net_val NUMERIC(18,5) NOT NULL OPTIONS(description='Total net value'),
number_of_receipts BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Number of receipts'),
trans_time_in_mins NUMERIC(18,5) NOT NULL
OPTIONS(description='Duration of transaction in minutes. Decimal values are true decimals (ie, 30 secs is .5)'),
items_scanned_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Number of items scanned'),
discount_val NUMERIC(18,5) OPTIONS(description='Discount value'),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row create time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
pcwo_reason_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Unique ID of the write-off or Price change reason. Country-specific write-off reasons have ID>100.'),
coupon_reason_nr BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Identifier of the booking reason in SCRM'),
writeoff_val NUMERIC(18,5) DEFAULT 0 OPTIONS(description='Writeoff net value'),
gender_cd STRING(5) DEFAULT 'na' NOT NULL OPTIONS(description='the code for the geder'),
age_range_cd STRING(10) DEFAULT 'na' NOT NULL OPTIONS(description='the code for the age range.'),
PRIMARY KEY (aspect_id, client_id, dwh_cal_dt, move_to_store_id, lidlplus_cust_fg, currency_iso_cd) NOT ENFORCED
) OPTIONS(description='Lidlplus : Receipt header aggregated to day level');