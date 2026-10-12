/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.T_STORE_SIG_WEEKDAY_HOUR_SALES_LOG
#----------------------------------------------------------------------------
# History:
#  1.0  03.09.2021    Martin Murtenthaler        VTWG-158
#----------------------------------------------------------------------------
*/

CREATE TABLE p_lew_mart_wfm.t_store_sig_weekday_hour_sales_log COMMENT='Logtabelle Verkäufe'
(
  load_ts TIMESTAMP NOT NULL COMMENT 'Ladezeitpunkt'
);