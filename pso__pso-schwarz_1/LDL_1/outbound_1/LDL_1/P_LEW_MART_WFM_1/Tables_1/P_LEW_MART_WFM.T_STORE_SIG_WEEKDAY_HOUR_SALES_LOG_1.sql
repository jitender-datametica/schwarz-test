/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.T_STORE_SIG_WEEKDAY_HOUR_SALES_LOG_1
#----------------------------------------------------------------------------
# History:
#  1.0  03.09.2021    Martin Murtenthaler        VTWG-158
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_wfm.t_store_sig_weekday_hour_sales_log_1 (
load_ts DATETIME NOT NULL OPTIONS(description='Ladezeitpunkt')
) OPTIONS(description='Logtabelle Verkäufe');