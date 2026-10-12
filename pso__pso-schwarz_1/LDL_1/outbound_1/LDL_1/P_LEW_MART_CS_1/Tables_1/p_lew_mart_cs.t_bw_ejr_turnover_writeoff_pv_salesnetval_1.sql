/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs.t_bw_ejr_turnover_writeoff_pv_salesnetval_1
#----------------------------------------------------------------------------
# History:
#   1.0            05.10.2022        Ulrich Ross              Init
#                                                             User Story 391252
#                                                             SAP BW Performance Issue - SF
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cs.t_bw_ejr_turnover_writeoff_pv_salesnetval_1 (
client_id BIGNUMERIC(38) NOT NULL,
item_id INTEGER NOT NULL,
dat_formdate DATE NOT NULL,
currency_iso_cd STRING(3) NOT NULL,
m1401 NUMERIC(18,5) NOT NULL
);