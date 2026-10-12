--==============================================================
-- Table: T_MEASUREMENT_PRODUCTION_LINE_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_MEASUREMENT_PRODUCTION_LINE_2
   generated from Powerdesigner on Montag, 26. Juni 2023 19:26:34
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_MEASUREMENT_PRODUCTION_LINE_2 (
   PRODUCTION_LINE_RESOURCE_ITEM_SID   NUMBER(38,0)    NOT NULL COMMENT 'Id of the production line',
   SHIFT_ID                            NUMBER(38,0)    NOT NULL COMMENT 'Concatenated ID: shift_start_dt + shift_type_id as integer. Each day has 3 shifts.',
   MEASUREMENT_TMSP                    TIMESTAMP_TZ(9) NOT NULL COMMENT 'Represents the point in time of a measurement ',
   PRODUCTION_LINE_PARAMETER_RESOURCE_ITEM_SID NUMBER(38,0)    NOT NULL COMMENT 'Id of the parameter (e.g. for utilization)',
   UNIT_ID                             NUMBER(38,0)    NOT NULL COMMENT 'Id of the unit_2 (e.g. material unit_2, production line parameter)',
   MEASUREMENT_DT                      DATE            NOT NULL COMMENT 'Descriptive Attribute - The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). ',
   MEASUREMENT_TM                      TIME(9)         NOT NULL COMMENT 'Descriptive Attribute - Time of measurement',
   VALUE_QTY                           NUMBER(38, 5)   NOT NULL COMMENT 'Fact - non additive value the parameter of the specified production line',
   MEASUREMENT_DELIVERY_STATE_TXT      VARCHAR(1000)   COMMENT 'Measurements are qualified as beeing valid, invalid or are considered as empty. Info is defined by source system. Reason has to be clarified by BSE',
   MEASUREMENT_DELIVERY_SAMPLE_RATE    NUMBER(38, 5)   DEFAULT -1 NOT NULL COMMENT 'Measurements are delivered in different time intervalls, described as sample rate. Originall sample rates are 1, 10, 60 sec. o stays for unspecified/continuosly changing value. -1 stays for unknow (not delivered from source system) / default value.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
   CONSTRAINT PK_T_MEASUREMENT_PRODUCTION_LINE PRIMARY KEY (PRODUCTION_LINE_RESOURCE_ITEM_SID, SHIFT_ID, PRODUCTION_LINE_PARAMETER_RESOURCE_ITEM_SID, MEASUREMENT_TMSP) NOT ENFORCED
 )  COMMENT= 'Transactional Facts - Generic modeled with granularity normalized to 60 Secs (originally delivered as 1, 10, 60 sec measurements) - capturing the the measurements of a production line. The values are results of sensor data activity on different parts of production line monitoring manufaturing process. Source - LMS via Proleit ODS (views on SQLServer delivered via Azure Data Factory), IMD (MySQL), Qualifax (MSSQLServer)';

