/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS_AC#.V_BW_OPEN_DAYS_STORE_MTH
#----------------------------------------------------------------------------
# History:
#  1.0  12.05.2023    Ulrich Ross               Init, User Story 476747
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_bw_open_days_store_mth (calmonth, client_id, sumdaycount, sumdaycount_ytd
) AS SELECT *
FROM ldl_p_lew_mart_cs.v_bw_open_days_store_mth;