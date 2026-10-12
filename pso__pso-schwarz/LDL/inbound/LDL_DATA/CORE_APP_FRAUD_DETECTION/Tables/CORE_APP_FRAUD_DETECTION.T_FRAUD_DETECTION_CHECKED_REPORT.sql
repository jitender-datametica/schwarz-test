/* --------------------------------------------------------------------------------
   DDL for table: t_fraud_detection_checked_report
   generated from Powerdesigner on Friday, 13. Dezember 2024 12:37:06
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_CHECKED_REPORT (
   int_org_sid                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organizatio (store or sales company/VGES)',
   request_tmsp                        TIMESTAMP_TZ(9) NOT NULL COMMENT 'The point in time when this record requested by the MicroStrategy-User.',
   report_id                           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of MicroStrategy Report',
   report_status_cd                    VARCHAR(20)     DEFAULT 'AP' NOT NULL COMMENT 'The status of the report (e.g. AP=Approved). Default is AP.',
   checked_by_user_name                VARCHAR(100)    NOT NULL COMMENT 'The end user, who sets the audit flag',
   comment_by_user                     VARCHAR(100)    COMMENT 'The comment of the user',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_FRAUD_DETECTION_CHECKED_REPORT PRIMARY KEY (int_org_sid, request_tmsp, report_id) NOT ENFORCED
)  COMMENT= 'Keeps the fraud detection audit list, to know which organisation is approved for which report';