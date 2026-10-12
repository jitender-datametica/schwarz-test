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


CREATE TABLE IF NOT EXISTS produktion_core.t_dim_alerts_location (
alerts_location_id BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier for the alarm location on which the alarm occured and where the station is located at.'),
alerts_location_classification_id BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier for the alarm location classification on which the alarm occured and where the station is located at.'),
alerts_location_parent_id BIGNUMERIC OPTIONS(description='The parent ID (location) for a station alert.'),
alerts_location_hierarchy_level_id BIGNUMERIC
OPTIONS(description='The hierarchy level of a location id. 1= location, 2 = station'),
alerts_location_desc STRING(16777216) NOT NULL
OPTIONS(description='A textual default description for the alarm location in German'),
alerts_location_desc_de STRING(16777216) NOT NULL
OPTIONS(description='A textual description for the alarm location in German'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (alerts_location_id) NOT ENFORCED
) OPTIONS(description='Hierarchy for the alert locations and stations within the Bon Gelati.');