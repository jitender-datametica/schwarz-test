    /*
#----------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.T_QV_AGG_STORE_DAY_WGI_MISS_ITM
#----------------------------------------------------------------------------
# History:
#  1.0  2023-06-20 Marcin Malec          Initial; User Story 481680: [BE] - Fehlartikel Filiale | Quick View
#
#----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_LEAD.T_QV_AGG_STORE_DAY_WGI_MISS_ITM CLUSTER BY (CLIENT_ID ,DAT_FORMDATE) (
      CLIENT_ID NUMBER(18,0) NOT NULL COMMENT 'Client identifier',
      ACCOUNT_MANAGER_ID NUMBER(18,0) COMMENT 'Account manager identifier',
      SALES_MANAGER_ID NUMBER(18,0) COMMENT 'Sales manager identifier',
      MOVE_TO_STORE_ID NUMBER(18,0) NOT NULL COMMENT 'Store identifier',
      WH_ID NUMBER(18,0) NOT NULL COMMENT 'Warehouse identifier',
      WH_ID_EXP NUMBER(18,0) COMMENT '',
      ASPECT_ID NUMBER(18,0) NOT NULL COMMENT 'Aspect identifier',
      CURRENCY_ISO_CD CHAR(3) COLLATE 'EN-CI' NOT NULL COMMENT '',
      CURR_TOT_ID NUMBER(18,0) COMMENT 'Currency tot identifier',
      DAT_FORMDATE DATE NOT NULL COMMENT 'Record date',
      ITEMGROUP_INT_ID NUMBER(18,0) NOT NULL COMMENT '',
      MISS_ITEM_CNT_CY NUMBER(18,0) COMMENT 'Missing item count: Current year',
      MISS_ITEM_CNT_FA_CY NUMBER(18,0) COMMENT 'Missing item count (foodaction): Current year',
      MISS_ITEM_CNT_PY NUMBER(18,0) COMMENT 'Missing item count: Previous year',
      MISS_ITEM_CNT_FA_PY NUMBER(18,0) COMMENT 'Missing item count (foodaction): Previous year',
      STORE_DAY_CNT_CY NUMBER(18,0) COMMENT 'Store Day count: Current year',
      STORE_DAY_CNT_FA_CY NUMBER(18,0) COMMENT 'Store Day count (foodaction): Current year',
      STORE_DAY_CNT_PY NUMBER(18,0) COMMENT 'Store Day count: Previous year',
      STORE_DAY_CNT_FA_PY NUMBER(18,0) COMMENT 'Store Day count (foodaction): Previous year',
      MISS_ITEM_FG_CY NUMBER COMMENT 'Missing item flag: Current year (if there was any missing item)',
      MISS_ITEM_FG_FA_CY NUMBER COMMENT 'Missing item flag: Current year (foodaction) (if there was any missing item)',
      MISS_ITEM_FG_PY NUMBER COMMENT 'Missing item flag: Previous year (if there was any missing item)',
      MISS_ITEM_FG_FA_PY NUMBER COMMENT 'Missing item flag: Previous year (foodaction) (if there was any missing item)',
      SKIPPED_FG_CY NUMBER COMMENT '0 - Not skipped, 1 - Skipped.  Skipped = miss_item_cnt > p_value (or 300) from P_LEW_MART_LEAD.T_REF_PARAMETER_VT with p_id = 1',
      SKIPPED_FG_FA_CY NUMBER COMMENT '0 - Not skipped, 1 - Skipped.  Skipped = miss_item_cnt > p_value (or 300) from P_LEW_MART_LEAD.T_REF_PARAMETER_VT with p_id = 1',
      SKIPPED_FG_PY NUMBER COMMENT '0 - Not skipped, 1 - Skipped.  Skipped = miss_item_cnt > p_value (or 300) from P_LEW_MART_LEAD.T_REF_PARAMETER_VT with p_id = 1',
      SKIPPED_FG_FA_PY NUMBER COMMENT '0 - Not skipped, 1 - Skipped.  Skipped = miss_item_cnt > p_value (or 300) from P_LEW_MART_LEAD.T_REF_PARAMETER_VT with p_id = 1',
      DWH_LOAD_ID NUMBER(18,0) NOT NULL COMMENT 'DWH load identifier',
      DWH_CREATED TIMESTAMP_NTZ(6) NOT NULL COMMENT 'DWH record created timestamp',
      DWH_UPDATED TIMESTAMP_NTZ(6) NOT NULL COMMENT 'DWH record updated timestamp',
      UNIQUE ( CLIENT_ID ,MOVE_TO_STORE_ID ,WH_ID ,ASPECT_ID ,CURRENCY_ISO_CD ,DAT_FORMDATE ,ITEMGROUP_INT_ID )
) COMMENT = 'QuickView Fehlartikel Store table'
;