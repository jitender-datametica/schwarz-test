--==============================================================
-- Table: T_FACT_MEASUREMENT_SILO_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_MEASUREMENT_SILO_1
   generated from Powerdesigner on Montag, 25. November 2024 10:51:09
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_MEASUREMENT_SILO_1 (
   PRODUCTION_LINE_RESOURCE_ITEM_SID   NUMBER(38,0)    NOT NULL COMMENT 'Id of the production line',
   WAREHOUSE_RESOURCE_ITEM_SID         NUMBER(38,0)    NOT NULL COMMENT 'Id of the stock (e.g. production)',
   SILO_RESOURCE_ITEM_SID              NUMBER(38,0)    NOT NULL COMMENT 'Id of the silo (e.g. plasting in production plants)',
   MIXER_LINE_RESOURCE_ITEM_SID        NUMBER(38,0)    NOT NULL COMMENT 'Id of the material mixer line (e.g. mixer line of a production line in a plant)',
   MEASUREMENT_TMSP                    TIMESTAMP_TZ(9) NOT NULL COMMENT 'Descriptive Attribute - Represents the point in time of a measurement ',
   FILL_LEVEL_RES_ITEM_SID             NUMBER(38,0)    NOT NULL COMMENT 'Id of the parameter (e.g. for utilization)',
   MEASUREMENT_DT                      DATE            NOT NULL COMMENT 'The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). ',
   MATERIAL_RESOURCE_ITEM_SID          NUMBER(38,0)    NOT NULL COMMENT 'Id of the material (e.g. plasting in production plants)',
   FILL_LEVEL_UNIT_ID                  NUMBER(38,0)    NOT NULL COMMENT 'Id of the unit_1 for the fill level (fill_level_meas).',
   MEASUREMENT_TM                      TIME(9)         NOT NULL COMMENT 'Descriptive Attribute - Time of measurement',
   FILL_LEVEL_PCT                      NUMBER(38, 5)   NOT NULL COMMENT 'Fact - non additive - fill level value of silo in percentage. (Value for Fuellstand Silo 01 - Fuellstand Silo 14)',
   FILL_LEVEL_MEAS                     NUMBER(38, 5)   COMMENT 'Fact - non additive - Material quantity stored in the silo.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
   CONSTRAINT PK_T_FACT_MEASUREMENT_SILO PRIMARY KEY (PRODUCTION_LINE_RESOURCE_ITEM_SID, WAREHOUSE_RESOURCE_ITEM_SID, SILO_RESOURCE_ITEM_SID, MIXER_LINE_RESOURCE_ITEM_SID, MEASUREMENT_TMSP) NOT ENFORCED
 )  COMMENT= 'Fact table - Transactional - Periodic Snapshot_1 - capturing the the measurements of a silo - Source - LMS via Proleit ODS (views on SQLServer delivered via Azure Data Factory), IMD (MySQL), Qualifax (MSSQLServer)';

