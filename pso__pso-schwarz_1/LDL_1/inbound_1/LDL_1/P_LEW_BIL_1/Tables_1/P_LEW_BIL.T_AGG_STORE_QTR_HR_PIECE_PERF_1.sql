/*
#----------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL.T_AGG_STORE_QTR_HR_PIECE_PERF_1
#----------------------------------------------------------------------------
# History:
#  1.0  2023-09-18    Ulrich Ross           Initial
#                                           User Story 516205

#----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_BIL.T_AGG_STORE_QTR_HR_PIECE_PERF_1 CLUSTER BY (CLIENT_ID ,DWH_CAL_DT) (
      CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'Client identifier',
      SRC_ORIG_STORE_NR NUMBER(38,0) NOT NULL COMMENT 'Store identifier',
      LOC_SID_STORE NUMBER(38,0) NOT NULL COMMENT 'Store identifier',
      DWH_CAL_DT DATE NOT NULL COMMENT 'Record date',
      QTR_HR NUMBER(38,0) COMMENT 'Quarter hour ID',
      CURRENCY_ISO_CD CHAR(3) COLLATE 'EN-CI' NOT NULL COMMENT 'Currency code',
      SALES_PIECES NUMBER(18,5) COMMENT 'Sales_1 pieces with dependency to Net time worked flag',
      SALES_PIECES_TOTAL NUMBER(18,5) COMMENT 'Sales_1 pieces',
      SALES_PIECES_EXTRAPOL NUMBER(18,5) COMMENT 'Sales_1 pieces extrapolated',
      SALES_PIECES_FA NUMBER(18,5) COMMENT 'Sales_1 pieces (foodaction)  with dependency to Net time worked flag',
      SALES_PIECES_FA_TOTAL NUMBER(18,5) COMMENT 'Sales_1 pieces total (foodaction)',
      VAL_RTL_NET NUMBER(18,5) COMMENT 'Sales_1 net val with dependency to Net time worked flag',
      VAL_RTL_NET_FA NUMBER(18,5) COMMENT 'Net sales_1 value (foodaction)',
      AVG_SALES_PRICE NUMBER(18,5) COMMENT 'Average price with dependency to Net time worked flag',
      PIECE_RECEIPT NUMBER(18,5) COMMENT 'Piece receipt with dependency to Net time worked flag',
      CNT_CUSTOMER NUMBER(18,5) COMMENT 'Customer count with dependency to Net time worked flag',
      WORK_TIME_TOTAL_HR NUMBER(18,5) COMMENT 'Work time total hour',
      PIECE_PERFORMANCE NUMBER(18,5) COMMENT 'Piece performance with dependency to Net time worked flag',
      TIME_WORKING_NETTO_FG NUMBER(38,0) NOT NULL COMMENT 'Net time worked flag',
      TRAINING_TIME_HR NUMBER(18,5) COMMENT 'Hours spent training',
      DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'DWH load identifier',
      DWH_CREATED TIMESTAMP_NTZ(6) NOT NULL COMMENT 'Timestamp record created'
) COMMENT = 'Store day piece performance'
;