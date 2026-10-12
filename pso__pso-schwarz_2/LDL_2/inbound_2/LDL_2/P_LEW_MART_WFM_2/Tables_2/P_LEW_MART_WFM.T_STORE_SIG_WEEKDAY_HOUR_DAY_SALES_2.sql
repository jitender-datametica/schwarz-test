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

CREATE TABLE p_lew_mart_wfm.t_store_sig_weekday_hour_day_sales_2 COMMENT='Verkäufe zusätlich auf Tagesebene'
(
  client_id  NUMBER(38,0) NOT NULL COMMENT 'Landeskennung',
  loc_sid    NUMBER(38,0) NOT NULL COMMENT 'Filialkennung',
  uwg        NUMBER(38,0) NOT NULL COMMENT 'Unterwarengruppe',
  wochentag  NUMBER(38,0) NOT NULL COMMENT 'Wochentag',
  stunde     NUMBER(38,0) NOT NULL COMMENT 'Stunde',
  dwh_cal_dt DATE         NOT NULL COMMENT 'Datum',
  verkauf    NUMBER(38,5) NOT NULL COMMENT 'Verkauf in dieser Stunde'
);