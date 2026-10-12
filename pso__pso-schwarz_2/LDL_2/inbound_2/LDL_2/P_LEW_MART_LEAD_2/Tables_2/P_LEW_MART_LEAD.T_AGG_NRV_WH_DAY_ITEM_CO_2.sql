/*
#-------------------------------------------------------------------------------
#  LIDL Stiftung & Co. KG - DWH / MIS
#-------------------------------------------------------------------------------
# Interface: Base table for NRV Controlling-wise metrics NRV exkl. SV (Abrechnung) (in LW) and NRV Sondervergütung (Abrechnung) (in LW)
#-------------------------------------------------------------------------------
#
#-------------------------------------------------------------------------------
# Subversion Infostamp End
#----------------------------------------------------------------------------
# History:
# NR  | DATE       | 1st AND 2nd NAME | DESCRIPTION OF CHANGES
#
# 1.0  2024-04-17   Torsten Bachmann    Initial version, AP0162679, NRV base KPI
# 1.1  2024-05-21   Torsten Bachmann    We are using "ignore" Approach to calculate WE Kalk in MSTR, so NRV_PART columns are not needed anymore
#
#----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_LEAD.T_AGG_NRV_WH_DAY_ITEM_CO_2(
  CLIENT_ID NUMBER(38,0) NOT NULL,
  SUP_SID NUMBER(38,0),
  LOC_SID_WH NUMBER(38,0),
  ITEM_SID NUMBER(38,0),
  DWH_CAL_DT DATE NOT NULL,
  ENTRY_DT DATE,
  CURR_CD_FROM VARCHAR(20),
  PAYOUT_INVOICE_TYPE_CD VARCHAR(100),
  PAYOUT_INVOICE_BILLING_TYPE_CD VARCHAR(100),
  CY_MONTH NUMBER(38,0),
  BOOK_CY_MONTH NUMBER(38,0),
  /* CO Metrics */
  NRV_EXKL_SV_ABR NUMBER(38,5),
  NRV_SV_ENTRY_DAT NUMBER(38,5),
  DWH_LOAD_ID NUMBER(38,0)  NOT NULL,
  DWH_CREATED TIMESTAMP_NTZ(9)  NOT NULL
);