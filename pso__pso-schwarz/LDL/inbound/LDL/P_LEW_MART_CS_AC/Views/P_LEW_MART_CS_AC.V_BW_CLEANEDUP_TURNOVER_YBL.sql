/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS_AC#.V_BW_CLEANEDUP_TURNOVER_YBL
#----------------------------------------------------------------------------
# History:
#  1.0  12.05.2023    Ulrich Ross               Init, User Story 476747
#----------------------------------------------------------------------------
*/



CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.V_BW_CLEANEDUP_TURNOVER_YBL
(
  calmonth
  ,client_id  
  ,client_desc  
  ,currency_iso_cd   
  ,country_iso_cd
  ,turnover_lj_ber    -- umsatz lj bereinigt (auf basis des vvj)  
  ,turnover_vvj_ber   -- umsatz vvj bereinigt   
 )
AS
  SELECT
    calmonth
   ,client_id  
   ,client_desc  
   ,currency_iso_cd   
   ,country_iso_cd
   ,turnover_lj_ber    -- umsatz lj bereinigt (auf basis des vvj)  
   ,turnover_vvj_ber   -- umsatz vvj bereinigt   
  FROM p_lew_mart_cs.v_bw_cleanedup_turnover_ybl
;