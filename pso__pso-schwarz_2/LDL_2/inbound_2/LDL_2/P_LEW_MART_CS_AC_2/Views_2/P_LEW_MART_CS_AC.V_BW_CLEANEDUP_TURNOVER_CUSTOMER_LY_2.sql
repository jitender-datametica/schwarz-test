/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS_AC#.V_BW_CLEANEDUP_TURNOVER_CUSTOMER_LY_2
#----------------------------------------------------------------------------
# History:
#  1.0  12.05.2023    Ulrich Ross               Init, User Story 476747
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.V_BW_CLEANEDUP_TURNOVER_CUSTOMER_LY_2
(
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
  ,customer_vj_ber        -- kundenanzahl bereinigt vj 
 )
AS
  SELECT
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
    ,customer_vj_ber        -- kundenanzahl bereinigt vj   
  FROM p_lew_mart_cs.v_bw_cleanedup_turnover_customer_ly_2
;