/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for _LEW_MART_LEAD.T_DISPO_POS_ACT_2
#----------------------------------------------------------------------------
# History:
#  1.0  20.09.2022    Bachmann, Torsten        Initial version for Liefertreue (Prototype)
#  1.1  27.09.2022    Bachmann, Torsten        Add some columns
#  1.2  06.03.2023    Bachmann, Torsten        added reason_cd from T_REPLENISH_ORDER_WH_RECORD_POS_CHANGELOG_2
#----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_LEAD.T_DISPO_POS_ACT_2 (
  CLIENT_ID NUMBER(38,0) NOT NULL,
  LOC_SID NUMBER(38,0) NOT NULL,
  SUP_SID NUMBER(38,0),
  ORDER_RECORD_ID VARCHAR(20) NOT NULL COLLATE 'en-ci',
  ITEM_SID NUMBER(38,0) NOT NULL,
  ORDER_POS_VERSION_NR NUMBER(38,0) NOT NULL,
  DWH_VALID_FROM DATE NOT NULL,
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
  ORDER_STATUS_CD_OVERRIDE NUMBER(38,0)     COMMENT 'Override status_cd = 9, in case there are receiving or it is not the last cancelled line',
  INIT_DELIVERY_DT DATE                     COMMENT 'initial delivery date, retrieved from replenish_order_wh_record (Head)',
  MIN_RCV_DT DATE                           COMMENT 'MIN receiveing date in case there are more than one receivings booked on the same order',
  MAX_RCV_DT DATE                           COMMENT 'MAX receiveing date in case there are more than one receivings booked on the same order',
  QTY_CASE_RCV_ONTIME NUMBER(18,4)          COMMENT 'qty which was delivered/recieved on planned delivery_dt',
  QTY_CASE_RCV_AHEAD_SCHEDULE NUMBER(18,4)  COMMENT 'qty which was delivered/recieved before planned delivery_dt',
  QTY_CASE_RCV_DELAY_1_DAY NUMBER(18,4)     COMMENT 'qty which was delivered/recieved one day after delivery_dt',
  QTY_CASE_RCV_DELAY_2_DAYS NUMBER(18,4)    COMMENT 'qty which was delivered/recieved two days after delivery_dt',
  QTY_CASE_RCV_DELAY_3_DAYS NUMBER(18,4)    COMMENT 'qty which was delivered/recieved three days after delivery_dt',
  QTY_CASE_RCV_DELAY_GE_4_DAYS NUMBER(18,4) COMMENT 'qty which was delivered/recieved more than 3 days after delivery_dt',
  CNT_DAYS_DELAYED NUMBER(38)               COMMENT 'Number of days delayed, in case there are more than one receivings booked on the same order, we use MAX(rcv_dt)',
  CNT_RCV NUMBER(38),
  MAPPING_POS_NR NUMBER(38,0),
  ORIG_RECEIPT_ID_RCV VARCHAR(100) COLLATE 'en-ci',
  ORDER_POS_CREATED_TMSP TIMESTAMP_NTZ(9),
  ORDER_POS_UPDATED_TMSP TIMESTAMP_NTZ(9),
  DELIVERY_TMSP TIMESTAMP_NTZ(9),
  ALL_REASON_CD VARCHAR(300),
  FIRST_REASON_CD NUMBER(38,0),
  LAST_REASON_CD NUMBER(38,0),
  DWH_LOAD_ID NUMBER(38,0) NOT NULL,
  DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL,
  DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL
)
COMMENT = 'Actual Dispo data with receiving data, limited for last 3 years'
;
