--==============================================================
-- DBMS name:      Snowflake
-- Created on:     17.03.2021 15:26:08
--==============================================================


--==============================================================
-- Table: T_DIM_ALERTS_LOCATION
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_ALERTS_LOCATION
   generated from Powerdesigner on Dienstag, 6. April 2021 10:37:21
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_ALERTS_LOCATION (
   ALERTS_LOCATION_ID                  NUMBER          NOT NULL COMMENT 'The unique identifier for the alarm location on which the alarm occured and where the station is located at.',
   ALERTS_LOCATION_CLASSIFICATION_ID   NUMBER          NOT NULL COMMENT 'The unique identifier for the alarm location classification on which the alarm occured and where the station is located at.',
   ALERTS_LOCATION_PARENT_ID           NUMBER          COMMENT 'The parent ID (location) for a station alert.',
   ALERTS_LOCATION_HIERARCHY_LEVEL_ID  NUMBER          COMMENT 'The hierarchy level of a location id. 1= location, 2 = station',
   ALERTS_LOCATION_DESC                VARCHAR()       NOT NULL COMMENT 'A textual default description for the alarm location in German',
   ALERTS_LOCATION_DESC_DE             VARCHAR()       NOT NULL COMMENT 'A textual description for the alarm location in German',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   CONSTRAINT PK_T_DIM_ALERTS_LOCATION PRIMARY KEY (ALERTS_LOCATION_ID)
       NOT enforced
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Hierarchy for the alert locations and stations within the Bon Gelati.';
