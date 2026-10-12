/*
#===============================================================================
# © LIDL Stiftung & Co. KG
#===============================================================================
# Interface : STATISTICS
#             \ddl\lew\lew_mart_lidl_digital\lew_mart_lidl_digital_ac_v_agg_client_rcpt_hdr_ldpl_day.sql
#              
#===============================================================================

#===============================================================================





#===============================================================================

#===============================================================================
# History
#  1.0 2020-11-23 Pawel Wieczorek   Initial version 20201120_2669_ldpl_daily_aggr SD-1555
#  1.1 2020-12-03 Pawel Wieczork    20201117_2664_harmo_cal SD-1544
#                                         Add column 
#                                                   harmo_cal_day_no
#                                                   adjust_growth_fg
#  1.2 2022-03-31 Pawel Wieczorek   AP0092849 AP0092849 disable column customer_segment_cd and set it as NULL
#  1.3 2023-04-20 Pawel Wieczorek   AP0092849 Temporary restore old columns, to delete after promotion FE AP0092849
#  1.4 2023-08-11 Pawel Wieczorek	AP0157806 booking reasons
#  1.5 2023-10-30 Pawel Wieczorek   AP0069622 Added columns gender_cd, age_range_cd
#  1.6 2024-08-07 Pawel Wieczorek   #659208 VGES fix added case for aspect_id
#===============================================================================
#
*/

/* ==============================================================================
   View DDL
   ============================================================================== */

CREATE OR REPLACE VIEW P_LEW_MART_LIDL_DIGITAL_AC.V_AGG_CLIENT_RCPT_HDR_LDPL_DAY_1
COMMENT = 'Lidlplus : Receipt header aggregated to day level'
(
 aspect_id             COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
,client_id             COMMENT 'Identifier for client'
,dwh_cal_dt            COMMENT 'Data date'
,move_to_store_id      COMMENT 'Store ID'
,wh_id                 COMMENT 'Warehouse ID'
,lidlplus_cust_fg      COMMENT 'Lidplus customer flag'
,harmo_cal_day_no      COMMENT 'Harmonized day number'
,adjust_growth_fg      COMMENT 'Adjust growth flag - berenichte steigerung'
,currency_iso_cd       COMMENT 'ISO code for the currency of the client.'
,curr_tot_id           COMMENT 'Fixe Werte fuer EUR=0, GBP=40 sonst Client_Id'
,pcwo_reason_id        COMMENT 'Unique ID of the write-off or Price change reason. Country_1-specific write-off reasons have ID>100.'
,coupon_reason_nr      COMMENT 'Identifier of the booking reason in SCRM'
,gender_cd             COMMENT 'The code for the geder'
,age_range_cd          COMMENT 'The code for the age range.'
,total_gross_val       COMMENT 'Total gross value'
,total_net_val         COMMENT 'Total net value'
,number_of_receipts    COMMENT 'Number of receipts'
,trans_time_in_mins    COMMENT 'Duration of transaction in minutes. Decimal values are true decimals (ie, 30 secs is .5)'
,items_scanned_cnt     COMMENT 'Number of items scanned'
,discount_val          COMMENT 'Discount value'
,writeoff_val          COMMENT 'Writeoff net value'
,load_id               COMMENT 'Load identifier'
,dwh_created           COMMENT 'Row created time'
,dwh_updated           COMMENT 'Row update time'
)
AS
SELECT
 CASE WHEN f.move_to_store_id = 0 THEN 0 ELSE f.aspect_id END AS aspect_id
,f.client_id
,f.dwh_cal_dt
,f.move_to_store_id
,f.wh_id
,f.lidlplus_cust_fg
,f.harmo_cal_day_no
,f.adjust_growth_fg
,f.currency_iso_cd
,f.curr_tot_id
,f.pcwo_reason_id
,f.coupon_reason_nr
,f.gender_cd 
,f.age_range_cd 
,f.total_gross_val
,f.total_net_val
,f.number_of_receipts
,f.trans_time_in_mins
,f.items_scanned_cnt
,f.discount_val
,f.writeoff_val 
,f.load_id
,f.dwh_created
,f.dwh_updated
FROM p_lew_mart_lidl_digital.v_agg_client_rcpt_hdr_ldpl_day_1 AS f 
;