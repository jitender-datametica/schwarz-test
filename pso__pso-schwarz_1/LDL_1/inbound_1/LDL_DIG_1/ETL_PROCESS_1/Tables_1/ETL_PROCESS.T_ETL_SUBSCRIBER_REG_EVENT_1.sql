/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_SUBSCRIBER_REG_EVENT_1
   GENERATED FROM POWERDESIGNER ON Donnerstag, 8. September 2022 14:54:18
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_SUBSCRIBER_REG_EVENT_1 (
   SUBSCR_SID                          NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the subscriber',
   COUNTRY_CD                          VARCHAR(5)      NOT NULL COMMENT 'The unique country_1 code',
   EVENT_ID                            VARCHAR(100)    NOT NULL COMMENT 'The identifier of an event',
   EVENT_TYPE                          VARCHAR(100)    NOT NULL COMMENT 'Type of the event, e.g deletion',
   EVENT_DT                            DATE            COMMENT 'The date of the event from SFMC source',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_SUBSCRIBER_REG_EVENT PRIMARY KEY (SUBSCR_SID, COUNTRY_CD, EVENT_ID, EVENT_TYPE) NOT ENFORCED
 )  COMMENT= 'ETL table to support the t_dim_subscriber_reg_1 validity_1 by tracking the event type from SFMC source ';
