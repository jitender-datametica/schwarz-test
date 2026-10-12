/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for _LEW_MART_LEAD.T_DISPO_POS_HIST_2
#----------------------------------------------------------------------------
# History:
#  1.0  20.09.2022    Bachmann, Torsten        Initial version for Liefertreue (Prototype)
#  1.1  27.09.2022    Bachmann, Torsten        Rename column
#  1.2  18.01.2023    Bachmann, Torsten        dwh_cal_dt added
#----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_LEAD.T_DISPO_POS_HIST_2 (
  CLIENT_ID NUMBER(38,0) NOT NULL,
  LOC_SID NUMBER(38,0) NOT NULL,
  ORDER_RECORD_ID VARCHAR(20) NOT NULL COLLATE 'en-ci',
  ITEM_SID NUMBER(38,0) NOT NULL,
  ORDER_POS_VERSION_NR NUMBER(38,0) NOT NULL,
  DWH_VALID_FROM DATE NOT NULL,
  DWH_VALID_TO DATE,
  DELETED_FG NUMBER(1,0),
  DELIVERY_DT DATE,
  ORDER_STATUS_CD NUMBER(38,0),
  PART_FG NUMBER(38,0) NOT NULL,
  ORDER_QTY_TYPE_CD NUMBER(38,0) NOT NULL,
  ORDER_QTY NUMBER(18,5),
  ORDER_DELIVERED_CASE_QTY NUMBER(18,5),
  CASE_FACTOR NUMBER(38,0),
  REAL_CASE_SIZE NUMBER(9,5),
  INIT_ORDER_QTY_TYPE_CD NUMBER(38,0),
  INIT_ORDER_QTY NUMBER(18,5),
  INIT_CASE_FACTOR NUMBER(38,0),
  DELTA_ORDER_CASE_QTY NUMBER(38,5),
  ORDER_POS_CREATED_TMSP TIMESTAMP_NTZ(9),
  ORDER_POS_UPDATED_TMSP TIMESTAMP_NTZ(9),
  DELIVERY_TMSP TIMESTAMP_NTZ(9),
  DWH_CAL_DT DATE,
  DWH_LOAD_ID NUMBER(38,0) NOT NULL,
  DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL,
  DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL
)
COMMENT = 'Historized version of T_REPLENISH_ORDER_WH_RECORD_POS_2 with addional columns'
;
