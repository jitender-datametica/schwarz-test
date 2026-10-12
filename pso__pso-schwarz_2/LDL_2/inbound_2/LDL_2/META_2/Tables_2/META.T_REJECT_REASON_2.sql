/* --------------------------------------------------------------------------------
   DDL for table: t_reject_reason_2
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:56
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_REJECT_REASON_2 (
   reject_reason_cd                    VARCHAR(20)     NOT NULL COMMENT 'The code identifying the reason, why an ETL job has excluded a record from further processing.',
   reject_reason_descr                 VARCHAR(250)    NOT NULL COMMENT 'A textual description for the reason, why an ETL job has excluded a record from further processing.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_REJECT_REASON PRIMARY KEY (reject_reason_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the reason, why an ETL job has excluded a record from further processing.';