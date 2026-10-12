--==============================================================
-- DBMS name:      Snowflake
-- Created on:     04.12.2021 11:01:08
--==============================================================


--==============================================================
-- Table: T_KEY_RESOURCE_ITEM_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_KEY_RESOURCE_ITEM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_KEY_RESOURCE_ITEM_2 (
   SRC_01_CD                           VARCHAR(100)    NOT NULL COMMENT 'Source system key 01',
   SRC_02_CD                           VARCHAR(100)    NOT NULL COMMENT 'Source system key 02',
   SRC_03_CD                           VARCHAR(100)    NOT NULL COMMENT 'Source system key 03',
   SRC_NAMESPACE_CD                    VARCHAR(100)    NOT NULL COMMENT 'Name space code for source system key',
   RESOURCE_ITEM_SID                   NUMBER          NOT NULL COMMENT 'Resource item_2 SID',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   CONSTRAINT PK_T_KEY_RESOURCE_ITEM PRIMARY KEY (SRC_01_CD, SRC_02_CD, SRC_03_CD, SRC_NAMESPACE_CD)
       enforced,
   CONSTRAINT AK_T_KEY_RESOURCE_ITEM UNIQUE (RESOURCE_ITEM_SID, SRC_NAMESPACE_CD)
       enforced
)COMMENT = 'Key table for resource items';