/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_CLUP_TURNOVER_CUSTOMER_OPENDAYS_LY
#----------------------------------------------------------------------------
# History:
#  1.0  12.05.2023    Ulrich Ross               Init, User Story 476747
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_CS.V_BW_CLUP_TURNOVER_CUSTOMER_OPENDAYS_LY(
 calmonth
,client_id
,client_desc
,currency_iso_cd      
,country_iso_cd
,ber_kund_in_proz  
,ber_umsatz_in_proz 
,turnover_lj_ber        -- bereinigter umsatz lj (auf basis vj)
,turnover_vj_ber        -- bereinigter umsatz vj
,turnover_vj_ber_netto  -- bereinigter umsatz netto vj 
,customer_lj_ber        -- kundenanzahl bereinigt
,customer_vj_ber 
,sumdaycount
,sumdaycount_ytd
) 
AS(
  SELECT 
     tc.calmonth
    ,tc.client_id
    ,tc.client_desc
    ,tc.currency_iso_cd      
    ,tc.country_iso_cd
    ,tc.ber_kund_in_proz  
    ,tc.ber_umsatz_in_proz 
    ,tc.turnover_lj_ber        -- bereinigter umsatz lj (auf basis vj)
    ,tc.turnover_vj_ber        -- bereinigter umsatz vj
    ,tc.turnover_vj_ber_netto  -- bereinigter umsatz netto vj 
    ,tc.customer_lj_ber        -- kundenanzahl bereinigt
    ,tc.customer_vj_ber 
    ,ods.sumdaycount
    ,ods.sumdaycount_ytd
  FROM p_lew_mart_cs.v_bw_cleanedup_turnover_customer_ly AS tc
  FULL OUTER JOIN p_lew_mart_cs.v_bw_open_days_store_mth AS ods
    ON tc.calmonth = ods.calmonth
    AND tc.client_id = ods.client_id
);

