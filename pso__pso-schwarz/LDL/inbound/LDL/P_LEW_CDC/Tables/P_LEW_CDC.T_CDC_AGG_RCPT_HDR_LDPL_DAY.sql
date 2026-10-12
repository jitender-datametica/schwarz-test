/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_CDC.t_cdc_agg_rcpt_hdr_ldpl_day
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
# Table: P_LEW_CDC.t_cdc_agg_rcpt_hdr_ldpl_day
#----------------------------------------------------------------------------
*/

create TABLE P_LEW_CDC.T_CDC_AGG_RCPT_HDR_LDPL_DAY (
    ASPECT_ID NUMBER(38,0) NOT NULL,
    CLIENT_ID NUMBER(38,0) NOT NULL,
    DWH_CAL_DT DATE NOT NULL,
    MOVE_TO_STORE_ID NUMBER(38,0) NOT NULL,
    CUSTOMER_SID NUMBER(38,0) NOT NULL,
    CURRENCY_ISO_CD VARCHAR(3) NOT NULL COLLATE 'en-ci',
    LOG_OPERATION VARCHAR(1) COLLATE 'en-ci',
    LOG_TS TIMESTAMP_NTZ(6)
)
;
