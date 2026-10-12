/*
#-------------------------------------------------------------------------------
#  LIDL Stiftung & Co. KG - DWH / MIS
#-------------------------------------------------------------------------------
# Interface: Aggregate for WE data on day level
#-------------------------------------------------------------------------------
#
#-------------------------------------------------------------------------------
# Subversion Infostamp End
#----------------------------------------------------------------------------
# History:
# NR  | DATE       | 1st AND 2nd NAME | DESCRIPTION OF CHANGES
#
# 1.0  2024-04-17   Torsten Bachmann    Initial version, AP0162679, NRV base KPI
#
#----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_LEAD.T_AGG_WE_WH_DAY_ITEM_2 (
  CLIENT_ID NUMBER(38,0) NOT NULL,
  sup_SID NUMBER(38,0),
  LOC_SID_WH NUMBER(38,0),
  ITEM_SID NUMBER(38,0),
  DWH_CAL_DT DATE NOT NULL,
  ENTRY_DT DATE,
  RECEIPT_TYPE_ID NUMBER(38,0),
  RECEIPT_POS_MARGIN_REL_FG NUMBER(38,0),
  CURR_CD_FROM VARCHAR(20) COLLATE 'en-ci',
  RECEIVE_PIECE_WITH_LOGIC_QTY NUMBER(18,5),
  BUYING_VAL NUMBER(18,5),
  RETAIL_NET_VAL NUMBER(18,5),
  RETAIL_VAL NUMBER(18,5),
  RETAIL_NET_FA_VAL NUMBER(18,5),
  BUYING_FA_VAL NUMBER(18,5),
  RETAIL_NET_WITH_LOGIC_VAL NUMBER(18,5),
  RECEIVE_CASE_WITH_LOGIC_QTY NUMBER(18,5),
  VAL_BUYING_SUPPL_RCV NUMBER(18,5),
  DWH_LOAD_ID NUMBER(38,0)  NOT NULL,
  DWH_CREATED TIMESTAMP_NTZ(9)  NOT NULL
);

