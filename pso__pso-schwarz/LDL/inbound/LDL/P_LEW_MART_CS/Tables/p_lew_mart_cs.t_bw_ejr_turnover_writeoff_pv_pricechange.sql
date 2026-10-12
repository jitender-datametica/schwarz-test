/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs.t_bw_ejr_turnover_writeoff_pv_pricechange
#----------------------------------------------------------------------------
# History:
#   1.0            05.10.2022        Ulrich Ross              Init
#                                                             User Story 391252
#                                                             SAP BW Performance Issue - SF
#----------------------------------------------------------------------------
*/

CREATE TABLE p_lew_mart_cs.t_bw_ejr_turnover_writeoff_pv_pricechange
(
client_id NUMBER(38) NOT NULL,
loc_sid_store NUMBER(38) NOT NULL,
item_sid NUMBER(38) NOT NULL,
currency_iso_cd VARCHAR(3) NOT NULL,
dwh_cal_dt DATE NOT NULL,
val_price_change NUMBER(18,5)
);