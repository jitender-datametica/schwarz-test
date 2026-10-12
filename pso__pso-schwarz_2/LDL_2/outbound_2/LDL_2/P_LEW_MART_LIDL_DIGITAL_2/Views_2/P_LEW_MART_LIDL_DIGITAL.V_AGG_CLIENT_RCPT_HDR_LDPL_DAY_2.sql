/*
#===============================================================================
# © LIDL Stiftung & Co. KG
#===============================================================================
# Interface : STATISTICS
#             \ddl\lew\lew_mart_lidl_digital\lew_mart_lidl_digital_v_agg_client_rcpt_hdr_ldpl_day.sql
#              
#===============================================================================

#===============================================================================





#===============================================================================

#===============================================================================
# History
#  1.0 2020-11-23 Pawel Wieczorek   Initial version 20201120_2669_ldpl_daily_aggr SD-1555
#  1.1 2020-12-03 Pawel Wieczorek   20201117_2664_harmo_cal SD-1544
#                                         Add column 
#                                                   harmo_cal_day_no
#                                                   adjust_growth_fg
#  1.2 2023-08-11 Pawel Wieczorek		AP0157806 booking reasons
#  1.3 2023-10-30 Pawel Wieczorek         AP0069622 Added columns gender_cd, age_range_cd
#===============================================================================
#
*/

/* ==============================================================================
   View DDL
   ============================================================================== */


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_agg_client_rcpt_hdr_ldpl_day_2 (aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), client_id
OPTIONS(description='Identifier for client'), dwh_cal_dt OPTIONS(description='Data date'), move_to_store_id
OPTIONS(description='Move to store ID'), wh_id OPTIONS(description='Warehouse ID'), lidlplus_cust_fg
OPTIONS(description='Lidplus customer flag'), harmo_cal_day_no OPTIONS(description='Harmonized day number'),
adjust_growth_fg OPTIONS(description='Adjust growth flag - berenigte steigerung'), currency_iso_cd
OPTIONS(description='ISO code for the currency of the client.'), curr_tot_id
OPTIONS(description='Fixe Werte fuer EUR=0, GBP=40 sonst Client_Id'), pcwo_reason_id
OPTIONS(description='Unique ID of the write-off or Price change reason. Country_2-specific write-off reasons have ID>100.'),
coupon_reason_nr OPTIONS(description='Identifier of the booking reason in SCRM'), gender_cd
OPTIONS(description='The code for the geder'), age_range_cd OPTIONS(description='The code for the age range.'),
total_gross_val OPTIONS(description='Total gross value'), total_net_val OPTIONS(description='Total net value'),
number_of_receipts OPTIONS(description='Number of receipts'), trans_time_in_mins
OPTIONS(description='Duration of transaction in minutes. Decimal values are true decimals (ie, 30 secs is .5)'),
items_scanned_cnt OPTIONS(description='Number of items scanned'), discount_val OPTIONS(description='Discount value'),
writeoff_val OPTIONS(description='Writeoff net value'), load_id OPTIONS(description='Load identifier'), dwh_created
OPTIONS(description='Row created time'), dwh_updated OPTIONS(description='Row update time'))
OPTIONS(DESCRIPTION = `LIDLPLUS : RECEIPT HEADER AGGREGATED TO DAY LEVEL`) AS SELECT aspect_id,
 client_id,
 dwh_cal_dt,
 move_to_store_id,
 wh_id,
 lidlplus_cust_fg,
 harmo_cal_day_no,
 adjust_growth_fg,
 currency_iso_cd,
 curr_tot_id,
 pcwo_reason_id,
 coupon_reason_nr,
 gender_cd,
 age_range_cd,
 total_gross_val,
 total_net_val,
 number_of_receipts,
 trans_time_in_mins,
 items_scanned_cnt,
 discount_val,
 writeoff_val,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_agg_client_rcpt_hdr_ldpl_day_2 AS F;