/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs.t_bw_ejr_turnover_writeoff_pv_salesnetval
#----------------------------------------------------------------------------
# History:
#   1.0            05.10.2022        Ulrich Ross              Init
#                                                             User Story 391252
#                                                             SAP BW Performance Issue - SF
#----------------------------------------------------------------------------
*/

CREATE TABLE p_lew_mart_cs.t_bw_ejr_turnover_writeoff_pv_salesnetval
(
client_id NUMBER(38) NOT NULL,
item_id DECIMAL(18,0) NOT NULL,
dat_formdate DATE NOT NULL,
currency_iso_cd VARCHAR(3) NOT NULL,
M1401 NUMBER(18,5) NOT NULL
);