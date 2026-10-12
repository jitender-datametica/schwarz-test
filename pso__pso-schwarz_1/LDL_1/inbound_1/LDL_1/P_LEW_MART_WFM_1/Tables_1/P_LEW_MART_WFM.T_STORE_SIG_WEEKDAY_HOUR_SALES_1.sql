/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.T_STORE_SIG_WEEKDAY_HOUR_SALES_1
#----------------------------------------------------------------------------
# History:        
#  1.0  03.09.2021    Martin Murtenthaler        VTWG-158
#  2.0  06.10.2021    Martin Murtenthaler        new datatype
#----------------------------------------------------------------------------
*/

CREATE TABLE p_lew_mart_wfm.t_store_sig_weekday_hour_sales_1 COMMENT='Verkäufe'
(
  country_cd        VARCHAR(20)  NOT NULL COMMENT 'ISO-Code Land_1',
  src_orig_store_nr NUMBER(38,0) NOT NULL COMMENT 'Filiale',
  uwg               NUMBER(38,0) NOT NULL COMMENT 'Unterwarengruppe',
  wochentag         NUMBER(38,0) NOT NULL COMMENT 'Wochentag',
  stunde            NUMBER(38,0) NOT NULL COMMENT 'Stunde',
  verkauf           NUMBER(38,2) NOT NULL COMMENT 'Verkaufsanteil bis zu einschließlich dieser Stunde',
  load_ts           TIMESTAMP    NOT NULL COMMENT 'Ladezeitpunkt'
);