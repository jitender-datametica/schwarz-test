/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM_AC.V_STORE_SIG_WEEKDAY_HOUR_SALES_DELTA
#----------------------------------------------------------------------------
# History:
#  1.0  03.09.2021    Martin Murtenthaler        VTWG-158
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm_ac.v_store_sig_weekday_hour_sales_delta (country_cd
OPTIONS(description='ISO-Code Land'), src_orig_store_nr OPTIONS(description='Filiale'), uwg
OPTIONS(description='Unterwarengruppe'), wochentag OPTIONS(description='Wochentag'), stunde
OPTIONS(description='Stunde'), verkauf OPTIONS(description='Verkaufsanteil bis zu dieser Stunde'))
OPTIONS(DESCRIPTION = `VERKÄUFE DELTA`) AS SELECT *
FROM ldl_p_lew_mart_wfm.v_store_sig_weekday_hour_sales_delta;