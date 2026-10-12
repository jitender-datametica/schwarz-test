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

CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.V_BW_OPEN_DAYS_STORE_MTH
(
   calmonth  
  ,client_id
  ,sumdaycount
  ,sumdaycount_ytd
 )
AS
  SELECT
     calmonth  
    ,client_id
    ,sumdaycount
    ,sumdaycount_ytd
  FROM p_lew_mart_cs.v_bw_open_days_store_mth
;