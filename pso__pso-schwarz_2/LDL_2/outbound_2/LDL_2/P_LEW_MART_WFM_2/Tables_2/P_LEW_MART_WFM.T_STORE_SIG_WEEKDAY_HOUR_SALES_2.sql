/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.T_STORE_SIG_WEEKDAY_HOUR_SALES_2
#----------------------------------------------------------------------------
# History:        
#  1.0  03.09.2021    Martin Murtenthaler        VTWG-158
#  2.0  06.10.2021    Martin Murtenthaler        new datatype
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_wfm.t_store_sig_weekday_hour_sales_2 (
country_cd STRING(20) NOT NULL OPTIONS(description='ISO-Code Land_2'),
src_orig_store_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Filiale'),
uwg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Unterwarengruppe'),
wochentag BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Wochentag'),
stunde BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Stunde'),
verkauf BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Verkaufsanteil bis zu einschließlich dieser Stunde'),
load_ts DATETIME NOT NULL OPTIONS(description='Ladezeitpunkt')
) OPTIONS(description='Verkäufe');