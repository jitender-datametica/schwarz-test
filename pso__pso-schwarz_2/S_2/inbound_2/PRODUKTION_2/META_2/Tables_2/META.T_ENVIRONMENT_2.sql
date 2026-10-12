--==============================================================
-- Table: T_ENVIRONMENT_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_ENVIRONMENT_2
   generated from Powerdesigner on Montag, 7. November 2022 10:16:20
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_ENVIRONMENT_2 (
   ENV_CD                              VARCHAR(50)     NOT NULL COMMENT 'The code which identifies the (development / test_2 / production / ...) environment.',
   ENV_NAME                            VARCHAR(100)    COMMENT 'The name of the i(development / test_2 / production / ...) environment.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_LOAD_ID                         NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   DWH_NODE_CD                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_ENVIRONMENT PRIMARY KEY (ENV_CD) NOT ENFORCED
 )  COMMENT= 'Development, Test_2 and Production can be separated by using different environments.';

