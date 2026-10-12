/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS_AC#.V_BW_CLEANEDUP_TURNOVER_YBL_2
#----------------------------------------------------------------------------
# History:
#  1.0  12.05.2023    Ulrich Ross               Init, User Story 476747
#----------------------------------------------------------------------------
*/


-- umsatz lj bereinigt (auf basis des vvj)
 -- umsatz lj bereinigt (auf basis des vvj)
 -- umsatz vvj bereinigt

-- umsatz vvj bereinigt
 CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_bw_cleanedup_turnover_ybl_2 (calmonth, client_id,
client_desc, currency_iso_cd, country_iso_cd, turnover_lj_ber, turnover_vvj_ber) AS SELECT *
FROM ldl_p_lew_mart_cs.v_bw_cleanedup_turnover_ybl_2;