--==============================================================
-- DBMS name:      Snowflake
-- Created on:     17.03.2021 15:26:08
--==============================================================


--==============================================================
-- Table: T_DIM_ALERTS_TYPE
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_ALERTS_TYPE
   generated from Powerdesigner on Mittwoch, 17. März 2021 15:26:13
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_ALERTS_TYPE (
   ALERTS_TYPE_ID                      NUMBER          NOT NULL COMMENT 'Unique identifier for the alarm type (0 = unknown 1 = system created alarm; 2 = manually created alarm)',
   ALERTS_TYPE_DESC                    VARCHAR()       NOT NULL COMMENT 'A textual default description for the alarm type in German',
   ALERTS_TYPE_DESC_DE                 VARCHAR()       NOT NULL COMMENT 'A textual description for the alarm type in German',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   CONSTRAINT PK_T_DIM_ALERTS_TYPE PRIMARY KEY (ALERTS_TYPE_ID)
       NOT enforced
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Dimension to describe, whether an alarm is system or manually generated.';

