--==============================================================
-- DBMS name:      Snowflake
-- Created on:     17.03.2021 15:26:08
--==============================================================


--==============================================================
-- Table: T_DIM_ALERTS_MESSAGE_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_ALERTS_MESSAGE_2
   generated from Powerdesigner on Dienstag, 6. April 2021 14:22:42
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_ALERTS_MESSAGE_2 (
   ALERTS_MESSAGE_ID                   NUMBER          NOT NULL COMMENT 'The alarm message number for an alarm',
   ALERTS_LOCATION_ID                  NUMBER          NOT NULL COMMENT 'The unique identifier for the alarm location_2 on which the alarm occured and where the station is located at.',
   ALERTS_PRIORITY_ID                  NUMBER          NOT NULL COMMENT 'The unique identifier for the alarm priorities (also containing inactive components)',
   ALERTS_TYPE_ID                      NUMBER          NOT NULL COMMENT 'Unique identifier for the alarm type (0 = unknown 1 = system created alarm; 2 = manually created alarm)',
   ALERTS_MESSAGE_DESC                 VARCHAR()       NOT NULL COMMENT 'A textual default description for the alarm message in German',
   ALERTS_MESSAGE_DESC_DE              VARCHAR()       NOT NULL COMMENT 'A textual description for the alarm message in German',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   CONSTRAINT PK_T_DIM_ALERTS_MESSAGE PRIMARY KEY (ALERTS_MESSAGE_ID)
       NOT enforced
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Dimension for all system and manually generated alarm message descriptions.';

