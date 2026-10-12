--==============================================================
-- DBMS name:      Snowflake
-- Created on:     18.11.2021 15:26:08
--==============================================================


--==============================================================
-- Table: T_KEY_UNIT_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_KEY_UNIT_2
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_KEY_UNIT_2 (
   SRC_01_CD                           VARCHAR(100)    NOT NULL COMMENT 'Source system key 01',
   SRC_NAMESPACE_CD                    VARCHAR(100)    NOT NULL COMMENT 'Name space code for source system key',
   UNIT_ID                   NUMBER          NOT NULL COMMENT 'Unit_2 ID',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   CONSTRAINT PK_T_KEY_RESOURCE_ITEM PRIMARY KEY (SRC_01_CD, SRC_NAMESPACE_CD)
       enforced,
   CONSTRAINT AK_T_KEY_RESOURCE_ITEM UNIQUE (UNIT_ID, SRC_NAMESPACE_CD)
       enforced
)COMMENT = 'Key table for units';
