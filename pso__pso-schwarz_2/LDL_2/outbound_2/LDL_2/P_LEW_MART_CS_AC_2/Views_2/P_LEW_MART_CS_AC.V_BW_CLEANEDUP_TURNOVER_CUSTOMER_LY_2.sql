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


-- bereinigter umsatz lj (auf basis vj)
 -- kundenanzahl bereinigt
 -- bereinigter umsatz netto vj

-- kundenanzahl bereinigt
 -- kundenanzahl bereinigt vj
 -- bereinigter umsatz netto vj
 -- bereinigter umsatz vj

-- kundenanzahl bereinigt vj
 -- bereinigter umsatz vj
 -- bereinigter umsatz lj (auf basis vj)

CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_bw_cleanedup_turnover_customer_ly_2 (calmonth, client_id, client_desc,
currency_iso_cd, country_iso_cd, ber_kund_in_proz, ber_umsatz_in_proz, turnover_lj_ber, turnover_vj_ber,
turnover_vj_ber_netto, customer_lj_ber, customer_vj_ber) AS SELECT *
FROM ldl_p_lew_mart_cs.v_bw_cleanedup_turnover_customer_ly_2;