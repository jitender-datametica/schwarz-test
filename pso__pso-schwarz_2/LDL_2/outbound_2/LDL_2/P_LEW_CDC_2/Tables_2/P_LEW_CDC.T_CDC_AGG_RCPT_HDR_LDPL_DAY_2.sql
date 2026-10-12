/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_CDC.t_cdc_agg_rcpt_hdr_ldpl_day_2
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------





#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#  1.0  2020-07-17    Glukhov, Danila          20200716_2538_CDC_Tables_x_lew_cdc
#                                               Initial Deployment
#  1.1  2020-12-09    Pawel Wieczork          20201117_2664_harmo_cal SD-1544
#                                                   Drop columns and remove them from primary index
#                                                       value_sales_receipts_fg
#                                                       non_value_sales_receipts_fg
#                                                       return_transaction_fg
#----------------------------------------------------------------------------
*/



/*
#----------------------------------------------------------------------------
# Table: P_LEW_CDC.t_cdc_agg_rcpt_hdr_ldpl_day_2
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_cdc.t_cdc_agg_rcpt_hdr_ldpl_day_2 (
aspect_id BIGNUMERIC(38,0) NOT NULL,
client_id BIGNUMERIC(38,0) NOT NULL,
dwh_cal_dt DATE NOT NULL,
move_to_store_id BIGNUMERIC(38,0) NOT NULL,
customer_sid BIGNUMERIC(38,0) NOT NULL,
currency_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
log_operation STRING(1) COLLATE 'und:ci',
log_ts DATETIME
);