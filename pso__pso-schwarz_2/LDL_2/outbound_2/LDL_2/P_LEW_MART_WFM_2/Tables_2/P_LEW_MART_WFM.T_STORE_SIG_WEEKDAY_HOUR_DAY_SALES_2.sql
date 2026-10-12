/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.T_STORE_SIG_WEEKDAY_HOUR_DAY_SALES_2
#----------------------------------------------------------------------------
# History:
#  1.0  03.09.2021    Martin Murtenthaler        VTWG-158
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_wfm.t_store_sig_weekday_hour_day_sales_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Landeskennung'),
loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Filialkennung'),
uwg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Unterwarengruppe'),
wochentag BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Wochentag'),
stunde BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Stunde'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Datum'),
verkauf BIGNUMERIC(38,5) NOT NULL OPTIONS(description='Verkauf in dieser Stunde')
) OPTIONS(description='Verkäufe zusätlich auf Tagesebene');