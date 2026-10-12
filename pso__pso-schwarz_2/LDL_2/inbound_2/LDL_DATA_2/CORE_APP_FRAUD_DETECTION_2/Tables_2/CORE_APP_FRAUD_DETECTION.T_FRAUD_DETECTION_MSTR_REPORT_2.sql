/* --------------------------------------------------------------------------------
   DDL for table: t_fraud_detection_mstr_report_2
   generated from Powerdesigner on Montag, 14. Oktober 2024 12:38:16
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_MSTR_REPORT_2 (
   report_id                           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of MicroStrategy Report',
   report_grp_id                       NUMBER(38, 0)   COMMENT 'The unique identifier of fraud detection scenario group.',
   report_name                         VARCHAR(100)    NOT NULL COMMENT 'The name of the report which will be used by the navigation.',
   report_descr                        VARCHAR(250)    NOT NULL COMMENT 'Describes the report.',
   report_type_cd                      VARCHAR(20)     NOT NULL COMMENT 'Type of report, code which defines if it is developed for manual or automatic for different layers',
   report_offset                       NUMERIC(38,0)   COMMENT 'The sequence number of the report, in which order it will be displayed',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_FRAUD_DETECTION_MSTR_REPORT PRIMARY KEY (report_id) NOT ENFORCED
 )  COMMENT= 'Keeps the fraud detection metrics for MicroStrategy Dynamic Dashboards ';