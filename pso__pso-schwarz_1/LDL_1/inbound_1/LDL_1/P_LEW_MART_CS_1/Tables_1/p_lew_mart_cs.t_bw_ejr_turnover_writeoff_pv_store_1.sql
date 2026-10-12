/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs.t_bw_ejr_turnover_writeoff_pv_store_1
#----------------------------------------------------------------------------
# History:
#   1.0            05.10.2022        Ulrich Ross              Init
#                                                             User Story 391252
#                                                             SAP BW Performance Issue - SF
#----------------------------------------------------------------------------
*/

CREATE TABLE p_lew_mart_cs.t_bw_ejr_turnover_writeoff_pv_store_1
(
store_id NUMBER(38) NOT NULL,
client_id NUMBER(38) NOT NULL,
wh_id NUMBER(38) ,
aspect_id NUMBER(38) NOT NULL,
dashboard_relevant_fg SMALLINT NOT NULL
);