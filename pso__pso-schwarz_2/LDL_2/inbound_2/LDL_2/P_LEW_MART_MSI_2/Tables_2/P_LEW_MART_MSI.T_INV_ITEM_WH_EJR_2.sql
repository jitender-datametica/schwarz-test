/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for t_inv_item_wh_ejr_2
#----------------------------------------------------------------------------
# History:
#  1.0  2021-07-06    Tris Bayliff          Initial
#                                           20210701_2876_Rohertragsletter_perf_ddl2
#                                           https://jira.schwarz/browse/REP2-9836
#  2.0  2021-08-02    Tris Bayliff          Switch to LEW_MART_MSI database
#                                           20210730_2897_Rohertragsletter_perf_ddl3
#                                           https://jira.schwarz/browse/REP2-10035
#  3.0  2021-09-29    Tris Bayliff          Change for SnowFlake
#                                           20210730_2897_Rohertragsletter_perf_ddl3
#                                           https://jira.schwarz/browse/REP2-10035
#
#----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_MSI.T_INV_ITEM_WH_EJR_2 CLUSTER BY (CLIENT_ID) (
      CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'Client identifier',
      WH_ID NUMBER(38,0) NOT NULL COMMENT 'Warehouse identifier',
      INV_ID NUMBER(38,0) NOT NULL COMMENT 'Inventory identifier',
      INV_START_DATE DATE COMMENT 'Inventory start date',
      INV_END_DATE DATE COMMENT 'Inventory end date',
      ITEM_ID NUMBER(38,0) NOT NULL COMMENT 'Item_2 identifier',
      VAL_RTL_EJR_ASIS NUMBER(18,5) COMMENT 'Sales_2 value',
      VAL_RTL_NET_EJR_ASIS NUMBER(18,5) COMMENT 'Net sales_2 value',
      VAL_RETURN_EJR_ASIS NUMBER(18,5) COMMENT 'Returns value',
      VAL_RETURN_NET_EJR_ASIS NUMBER(18,5) COMMENT 'Net returns value',
      CURRENCY_ISO_CD CHAR(3) COLLATE 'EN-CI' NOT NULL COMMENT 'Currency ISO Code',
      DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Record load Identifier',
      DWH_INSERTED TIMESTAMP_NTZ(6) NOT NULL COMMENT 'Record inserted timestamp',
      DWH_UPDATED TIMESTAMP_NTZ(6) NOT NULL COMMENT 'Record updated timestamp'
) COMMENT = 'Warehouse Item_2 Inventory'
;
