/*
#----------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.T_QV_AGG_WH_DAY_PRF_WGI_1
#----------------------------------------------------------------------------
# History:
#  1.0  2021-08-12    Tris Bayliff          Initial
#                                           20210812_2909_Stuckleistung_DDLQV2
#                                           https://jira.schwarz/browse/REP2-10132
#  1.1  2021-09-01    Tris Bayliff          Split revenue columns in to WGI and Store as they differ.
#                                           20210831_2923_Stuckleistung_DDLQV4
#                                           https://jira.schwarz/browse/REP2-10259
#  2.0  2021-09-16    Tris Bayliff          Copy to SnowFlake
#                                           20210831_2923_Stuckleistung_DDLQV4
#                                           https://jira.schwarz/browse/REP2-10259
#  2.1  2022-06-01    Jaroslaw Syrokosz     Add SALES_PIECES_EXTRAPOL, B-0011292A-AP0134217
#  2.2  2022-08-10    Jaroslaw Syrokosz     New Foodaction column for Net sales_1 value
#                                           B-0011300A-AP0141916
#  2.3  2022-11-15    Marcin Malec          AP0143580, Stueckleistung ph 2, Adding sales_pieces_total, sales_pieces_fa_total, sales_pieces_total_adj, sales_pieces_total_pep _cy / _py
#----------------------------------------------------------------------------
*/


CREATE TABLE P_LEW_MART_LEAD.T_QV_AGG_WH_DAY_PRF_WGI_1 CLUSTER BY (CLIENT_ID ,DAT_FORMDATE) (
      CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'Client identifier',
      COUNTRY_GROUP_ID NUMBER(38,0) COMMENT 'Country_1 group identifier',
      GL_REGION_ID NUMBER(38,0) COMMENT 'GL Region_1 identifier',
      WH_ID NUMBER(38,0) NOT NULL COMMENT 'Warehouse identifier',
      ASPECT_ID NUMBER(38,0) NOT NULL COMMENT 'Aspect identifier',
      CURRENCY_ISO_CD CHAR(3) COLLATE 'EN-CI' NOT NULL COMMENT 'ISO Currency code',
      CURR_TOT_ID NUMBER(38,0) COMMENT 'Currency tot identifier',
      DAT_FORMDATE DATE NOT NULL COMMENT 'Record date',
      ITEMGROUP_INT_ID NUMBER(38,0) NOT NULL COMMENT 'Item_1 group identifier',
      SALES_PIECES_CY NUMBER(18,5) COMMENT 'Sales_1 pieces: Current year',
      SALES_PIECES_TOTAL_CY NUMBER(18,5) COMMENT 'Sales_1 pieces total: Current year',
      SALES_PIECES_TOTAL_PEP_CY NUMBER(18,5) COMMENT 'Sales_1 pieces total plan pep: Current year',
      SALES_PIECES_FA_CY NUMBER(18,5) COMMENT 'Sales_1 pieces (foodaction): Current year',
      SALES_PIECES_FA_TOTAL_CY NUMBER(18,5) COMMENT 'Sales_1 pieces total (foodaction): Current year',
      SALES_PIECES_ADJ_CY NUMBER(18,5) COMMENT 'Adjusted sales_1 pieces: Current year',
      SALES_PIECES_TOTAL_ADJ_CY NUMBER(18,5) COMMENT 'Adjusted sales_1 pieces total: Current year',
      VAL_RTL_NET_WGI_UWG_CY NUMBER(18,5) COMMENT 'Net revenue (wgi level): Current year',
      VAL_RTL_NET_WGI_UWG_FA_CY NUMBER(18,5) COMMENT 'Net revenue (foodaction)(wgi level): Current year',
      VAL_RTL_NET_CY NUMBER(18,5) COMMENT 'Net revenue (store level): Current year',
      VAL_RTL_NET_FA_CY NUMBER(18,5) COMMENT 'Net revenue (foodaction)(store level): Current year',
      CNT_CUSTOMER_CY NUMBER(18,5) COMMENT 'Customer count: Current year',
      WORK_TIME_TOTAL_HR_CY NUMBER(18,5) COMMENT 'Total work time in hours at warehouse level: Current year',
      SALES_PIECES_EXTRAPOL_CY NUMBER(18,5) COMMENT 'Sales_1 pieces extrapol: Current year',
      SALES_PIECES_PY NUMBER(18,5) COMMENT 'Sales_1 pieces: Previous year',
      SALES_PIECES_TOTAL_PY NUMBER(18,5) COMMENT 'Sales_1 pieces total: Previous year',
      SALES_PIECES_TOTAL_PEP_PY NUMBER(18,5) COMMENT 'Sales_1 pieces total plan pep: Previous year',
      SALES_PIECES_FA_PY NUMBER(18,5) COMMENT 'Sales_1 pieces (foodaction): Previous year',
      SALES_PIECES_FA_TOTAL_PY NUMBER(18,5) COMMENT 'Sales_1 pieces total (foodaction): Previous year',
      SALES_PIECES_ADJ_PY NUMBER(18,5) COMMENT 'Adjusted sales_1 pieces: Previous year',
      SALES_PIECES_TOTAL_ADJ_PY NUMBER(18,5) COMMENT 'Adjusted sales_1 pieces total: Previous year',
      VAL_RTL_NET_WGI_UWG_PY NUMBER(18,5) COMMENT 'Net revenue (wgi level): Previous year',
      VAL_RTL_NET_WGI_UWG_FA_PY NUMBER(18,5) COMMENT 'Net revenue (foodaction)(wgi level): Previous year',
      VAL_RTL_NET_PY NUMBER(18,5) COMMENT 'Net revenue (store level): Previous year',
      VAL_RTL_NET_FA_PY NUMBER(18,5) COMMENT 'Net revenue (foodaction)(store level): Previous year',
      CNT_CUSTOMER_PY NUMBER(18,5) COMMENT 'Customer count: Previous year',
      WORK_TIME_TOTAL_HR_PY NUMBER(18,5) COMMENT 'Total work time in hours at warehouse level: Previous year',
      SALES_PIECES_EXTRAPOL_PY NUMBER(18,5) COMMENT 'Sales_1 pieces extrapol: Previous year',
      DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'DWH load identifier',
      DWH_CREATED TIMESTAMP_NTZ(6) NOT NULL COMMENT 'DWH record created timestamp',
      DWH_UPDATED TIMESTAMP_NTZ(6) NOT NULL COMMENT 'DWH record updated timestamp',
      UNIQUE ( CLIENT_ID ,WH_ID ,ASPECT_ID ,CURRENCY_ISO_CD ,DAT_FORMDATE ,ITEMGROUP_INT_ID )
) COMMENT = 'QuickView Stuckleistung Warehouse table'
;
