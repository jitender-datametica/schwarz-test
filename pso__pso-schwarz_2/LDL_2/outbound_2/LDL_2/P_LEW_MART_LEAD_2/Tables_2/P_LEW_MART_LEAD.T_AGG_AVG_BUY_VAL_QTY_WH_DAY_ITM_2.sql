/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# History:
# NR  | DATE       | 1st AND 2nd NAME | DESCRIPTION OF CHANGES
#
# 1.1   18-09-2023   Aleksander Bialek   Initial Version (materialized table for EK prices needed for final table/views for Kalkulation basis Abverkauf)
#                                       
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_agg_avg_buy_val_qty_wh_day_itm_2 (
client_id BIGNUMERIC(38,0),
loc_sid_wh BIGNUMERIC(38,0),
wh_id BIGNUMERIC(38,0),
orig_item_nr BIGNUMERIC(38,0),
dat_valid_from DATE,
dwh_cal_dt DATE,
ek_prc_nominator_val BIGNUMERIC(38,5),
ek_prc_denominator_qty BIGNUMERIC(38,8),
ek_price_val BIGNUMERIC(38,11)
);