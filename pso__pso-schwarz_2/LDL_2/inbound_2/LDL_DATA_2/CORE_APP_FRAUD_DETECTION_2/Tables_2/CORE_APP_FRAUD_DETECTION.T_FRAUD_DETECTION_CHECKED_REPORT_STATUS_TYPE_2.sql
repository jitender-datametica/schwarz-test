CREATE TABLE CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_CHECKED_REPORT_STATUS_TYPE_2 (
   report_status_cd                   VARCHAR(20)      NOT NULL COMMENT 'The unique code indicating the status_2 of the checked report (e.g. OPEN, COMMENTED, APPROVED ).',
   report_status_descr                VARCHAR(250)     NOT NULL COMMENT 'The descriptive name or explanation of the status.',
   dwh_created_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                        NUMBER(38, 0)    NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update.',
   dwh_node_cd                        VARCHAR(20)      NOT NULL COMMENT 'The code for the source system from which this record was loaded.',
   CONSTRAINT PK_T_FRAUD_DETECTION_CHECKED_REPORT_STATUS_TYPE PRIMARY KEY (report_status_cd) NOT ENFORCED
 ) COMMENT= 'Reference table defining the possible lifecycle statuses of a fraud detection checked report.';