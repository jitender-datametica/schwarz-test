--==============================================================
-- Table: T_DATA_QUALITY_RULE_PARAMETER_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DATA_QUALITY_RULE_PARAMETER_2
   generated from Powerdesigner on Montag, 7. November 2022 10:16:20
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_DATA_QUALITY_RULE_PARAMETER_2 (
   DQ_RULE_PARAM_NAME                  VARCHAR(100)    NOT NULL COMMENT 'The code identifying the parameter which need to be set for parametrized data quality rules.',
   DQ_RULE_PARAM_DESCR                 VARCHAR(250)    NOT NULL COMMENT 'A textual description for the parameter which need to be set for parametrized data quality rules.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_LOAD_ID                         NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   DWH_NODE_CD                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DATA_QUALITY_RULE_PARAMETER PRIMARY KEY (DQ_RULE_PARAM_NAME) NOT ENFORCED
 )  COMMENT= 'Minor Entity - This minor entity defines the parameters which need to be set for parametrized data quality rules.';

