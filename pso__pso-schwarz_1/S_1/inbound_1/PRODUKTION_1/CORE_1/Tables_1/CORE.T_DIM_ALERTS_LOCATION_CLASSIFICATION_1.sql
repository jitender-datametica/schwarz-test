--==============================================================
-- DBMS name:      Snowflake
-- Created on:     17.03.2021 15:26:08
--==============================================================


--==============================================================
-- Table: T_DIM_ALERTS_LOCATION_CLASSIFICATION_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_ALERTS_LOCATION_CLASSIFICATION_1
   generated from Powerdesigner on Mittwoch, 17. März 2021 15:26:13
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_ALERTS_LOCATION_CLASSIFICATION_1 (
   ALERTS_LOCATION_CLASSIFICATION_ID   NUMBER          NOT NULL COMMENT 'The unique identifier for the alarm location_1 classification on which the alarm occured and where the station is located at.',
   ALERTS_LOCATION_CLASSIFICATION_DESC VARCHAR()       NOT NULL COMMENT 'A textual default description for the alarm location_1 classification in German',
   ALERTS_LOCATION_CLASSIFICATION_DESC_DE VARCHAR()       NOT NULL COMMENT 'A textual description for the alarm location_1 classification in German',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   CONSTRAINT PK_T_DIM_ALERTS_LOCATION_CLASS PRIMARY KEY (ALERTS_LOCATION_CLASSIFICATION_ID)
       NOT enforced
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Table to classify alarm locations within the BonGelati.';

