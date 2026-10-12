/* --------------------------------------------------------------------------------
   DDL for table: t_fraud_analysis_status_type
   generated from Powerdesigner on Montag, 14. Oktober 2024 12:35:56
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_APP_FRAUD_DETECTION.T_FRAUD_ANALYSIS_STATUS_TYPE (
   fraud_analysis_status_cd            VARCHAR(20)     NOT NULL COMMENT 'Indicator showing it user has manually clasified this transaction, if it suspicious or not. First status comes: SP-suspicious and then maybe later on NSP- not suspicious',
   fraud_analysis_status_cd_descr      VARCHAR(250)    NOT NULL COMMENT 'Textual description for the marked code',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_FRAUD_ANALYSIS_STATUS_TYPE PRIMARY KEY (fraud_analysis_status_cd) NOT ENFORCED
 )  COMMENT= '';
